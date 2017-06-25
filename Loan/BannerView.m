//
//  BannerView.m
//  横幅
//
//  Created by LiuFeifei on 15/11/16.
//  Copyright © 2015年 lingtouniao. All rights reserved.
//

#import "BannerView.h"
#import "UIImageView+WebCache.h"

#define kMargin 0
// 一张图占屏幕的比例
#define kRatio 1.0
// 偏移量：默认kRatio * self.width为整张图，包含左右间距
//#define kContentOffset (kRatio * self.width - (1 - kRatio) * self.width * 0.5)
#define kContentOffset (kRatio * self.width + kMargin * 0.5)

#define kWidth (self.width * kRatio - kMargin)
#define kHeight self.height

#define kAnimationDuration 0.3

// 是否图完全靠紧左侧，具体需要根据kContentOffset的值来设置
#define kTightToLeft YES

@interface BannerView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView * scroll;
@property (nonatomic, strong) UIPageControl * page;
@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic, strong) UISwipeGestureRecognizer * swipeLeft;
@property (nonatomic, strong) UISwipeGestureRecognizer * swipeRight;
@property (nonatomic, assign) BOOL isSwiping;
@property (nonatomic, assign) BOOL isSubPage;

@end

@implementation BannerView

- (void)setBannersList:(NSArray<BannerModel *> *)bannersList
{
    _bannersList = bannersList;
    [self.timer invalidate];
    [self setupUI];
}

#pragma mark 搭建页面
- (void)setupUI
{
    if (self.subviews.count) {
        for (UIView * view in self.subviews) {
            [view removeFromSuperview];
        }
    }
    
    // 创建scrollView
    self.scroll = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scroll.scrollEnabled = NO;
    [self addSubview:self.scroll];
    
    // 设置滚动图片，图片顺序：3-[0-1-2-3]-0
    NSInteger count = self.bannersList.count;
    if (count <= 1) {
        BannerModel * banner = self.bannersList.firstObject;
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.centerX = kScreenWidth * 0.5;
        NSURL * url = [NSURL URLWithString:banner.bannerUrl];
        [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder_banner"] options:SDWebImageRetryFailed];
        [self addTapForImageView:imageView];
        [self.scroll addSubview:imageView];
        return;
    }
    
    for (int i = 0; i < count + 2; i++) {
        CGFloat x = (i + 0.5) * kMargin + i * kWidth;
        CGFloat y = 0;
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, kWidth, kHeight)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.userInteractionEnabled = YES;
        BannerModel * banner = nil;
        if (i == 0) {
            banner = self.bannersList[count - 1];
            imageView.tag = count - 1;
        } else if (i == count + 1) {
            banner = self.bannersList[0];
            imageView.tag = 0;
        } else {
            banner = self.bannersList[i - 1];
            imageView.tag = i - 1;
        }
        NSURL * url = [NSURL URLWithString:banner.bannerUrl];
        [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder_banner"] options:SDWebImageRetryFailed];
        [self addTapForImageView:imageView];
        [self.scroll addSubview:imageView];
    }
    
    // 设置属性及代理
    self.scroll.delegate = self;
    CGPoint contentOffset = CGPointMake(kContentOffset, 0);
    self.scroll.contentOffset = contentOffset;
    self.scroll.showsHorizontalScrollIndicator = NO;
    self.scroll.showsVerticalScrollIndicator = NO;
    self.scroll.bounces = NO;
//    self.scroll.pagingEnabled = YES;
    
    // 设置滚动范围
    self.scroll.contentSize = CGSizeMake(self.width * kRatio * (self.bannersList.count + 2), kHeight);
    
    // 创建pageControl
    self.page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, kHeight - 20, self.width, 20)];
    self.page.numberOfPages = self.bannersList.count;
    [self.page setCurrentPageIndicatorTintColor:[UIColor orangeColor]];
    [self addSubview:self.page];
    self.page.hidden = YES;
    
    // 创建定时器，定时滚动图片
    [self startTimer];
    
    // 添加轻扫手势及定时器
    [self addSwipeAndTimer];
}

- (void)addSwipeAndTimer
{
    if (self.isSwiping) {
        self.isSwiping = NO;
        [self startTimer];
    }
    [self addGestureRecognizer:self.swipeLeft];
    [self addGestureRecognizer:self.swipeRight];
}

- (UISwipeGestureRecognizer *)swipeRight
{
    if (!_swipeRight) {
        _swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(carousel:)];
        _swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    }
    return _swipeRight;
}

- (UISwipeGestureRecognizer *)swipeLeft
{
    if (!_swipeLeft) {
        _swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(carousel:)];
        _swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    }
    return _swipeLeft;
}

- (void)addTapForImageView:(UIImageView *)imageView
{
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [imageView addGestureRecognizer:tap];
}

- (void)tap:(UIGestureRecognizer *)recognizer
{
    if (!self.bannersList.count) return;
    if (self.delegate && [self.delegate respondsToSelector:@selector(bannerView:banner:)]) {
        UIImageView * imageView = (UIImageView *)recognizer.view;
        BannerModel * banner = self.bannersList[imageView.tag];
        [self.delegate bannerView:self banner:banner];
    }
}

- (void)carousel:(UISwipeGestureRecognizer *)swipe
{
    self.isSwiping = YES;
    [self.timer invalidate];
    [self removeGestureRecognizer:self.swipeLeft];
    [self removeGestureRecognizer:self.swipeRight];
    [self autoScroll:swipe];
}

#pragma mark 创建定时器，定时滚动图片
- (void)startTimer
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(autoScroll:) userInfo:nil repeats:YES];
}

#pragma mark 定时器方法
- (void)autoScroll:(UISwipeGestureRecognizer *)swipe
{
    // 获取当前的page，并加1
    NSInteger page = self.page.currentPage;
    if ([swipe isKindOfClass:[UISwipeGestureRecognizer class]]) {
        switch (swipe.direction) {
            case UISwipeGestureRecognizerDirectionLeft:
                page++;
                break;
            case UISwipeGestureRecognizerDirectionRight:
                page--;
                self.isSubPage = YES;
                break;
            default:
                break;
        }
    } else {
        page++;
    }
    /**
     *  图片编号：0- 1-2-3-4 -5
     *  图片顺序：3-[0-1-2-3]-0（图片页数）
     */
    // 如果页数为4，则超出正常页数，需要变为0
    if (page < 0) {
        page = self.bannersList.count - 1;
    } else if (page >= self.bannersList.count) {
        page = 0;
    }
    self.page.currentPage = page;
    // 更换图片
    [self turnPage];
}

#pragma mark 根据页数更换图片
- (void)turnPage
{
    /**
     *  图片编号：0- 1-2-3-4 -5
     *  图片顺序：3-[0-1-2-3]-0
     */
    kWeakSelf
    __block CGPoint contentOffset = self.scroll.contentOffset;
    if (self.isSubPage) {
        self.isSubPage = NO;
        if (self.page.currentPage == self.bannersList.count - 1) {
            // 如果是第1张图片，需要先动画滚动到第0张，动画结束后再不动画到第4张
            [UIView animateWithDuration:kAnimationDuration * 0.5 delay:.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
                contentOffset.x = 0;
                [weakSelf.scroll setContentOffset:contentOffset];
            } completion:^(BOOL finished) {
                [weakSelf.scroll setContentOffset:CGPointMake(self.bannersList.count * self.width * kRatio, 0) animated:NO];
                [UIView animateWithDuration:kAnimationDuration * 0.5 delay:.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
                    contentOffset.x = (self.bannersList.count - 1) * self.width * kRatio + kContentOffset;
                    [weakSelf.scroll setContentOffset:contentOffset];
                } completion:^(BOOL finished) {
                    [self addSwipeAndTimer];
                }];
            }];
            return;
        } else if (self.page.currentPage == 0) {
            [UIView animateWithDuration:kAnimationDuration animations:^{
                contentOffset.x = kContentOffset;
                [weakSelf.scroll setContentOffset:contentOffset];
            } completion:^(BOOL finished) {
                [self addSwipeAndTimer];
            }];
            return;
        }
    }
    
    if (self.page.currentPage) {
        [UIView animateWithDuration:kAnimationDuration animations:^{
            contentOffset.x = kContentOffset + self.width * kRatio * weakSelf.page.currentPage;
            [weakSelf.scroll setContentOffset:contentOffset];
        } completion:^(BOOL finished) {
            [self addSwipeAndTimer];
        }];
    } else {
        // 如果是第4张图片，需要先动画滚动到第5张，动画结束后再不动画到第1张
        [UIView animateWithDuration:kAnimationDuration * 0.5 delay:.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
            contentOffset.x = self.scroll.contentSize.width - self.width;
            [weakSelf.scroll setContentOffset:contentOffset];
        } completion:^(BOOL finished) {
            [weakSelf.scroll setContentOffset:CGPointMake(self.width * kRatio * 2 - self.width, 0) animated:NO];
            [UIView animateWithDuration:kAnimationDuration * 0.5 delay:.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
                contentOffset.x = kContentOffset;
                [weakSelf.scroll setContentOffset:contentOffset];
            } completion:^(BOOL finished) {
                [self addSwipeAndTimer];
            }];
        }];
    }
}

#pragma mark 滚动代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//     NSLog(@"%.2f", scrollView.contentOffset.x);
    int page = 0;
    if (kTightToLeft) {
        page = self.scroll.contentOffset.x / kWidth;
    } else {
        page = (self.scroll.contentOffset.x + kContentOffset) / kWidth;
    }
    
    page = (page == (self.bannersList.count + 1) ? 0 : page - 1);
    self.page.currentPage = page;
}

@end

//
//  IntroductionView.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/10.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "IntroductionView.h"

#define IntroductionImagesNo 4

@interface IntroductionView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView * scroll;
@property (nonatomic, strong) UIPageControl * page;

@end

@implementation IntroductionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI
{
    // 创建scrollView
    self.scroll = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scroll.delegate = self;
    self.scroll.showsHorizontalScrollIndicator = NO;
    self.scroll.showsVerticalScrollIndicator = NO;
    self.scroll.bounces = NO;
    self.scroll.pagingEnabled = YES;
    self.scroll.contentSize = CGSizeMake(IntroductionImagesNo * self.width, self.height);
    [self addSubview:self.scroll];
    
    // 设置图片
    [self setupImages];
    
    // 创建pageControl
    self.page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.height - 30, 100, 10)];
    self.page.centerX = self.width * 0.5;
    self.page.numberOfPages = IntroductionImagesNo;
    [self.page setCurrentPageIndicatorTintColor:[UIColor orangeColor]];
    self.page.hidden = YES;
    [self addSubview:self.page];
    
}

- (void)setupImages
{
    for (int i = 0; i < IntroductionImagesNo; i++) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.width, 0, self.width, self.height)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.userInteractionEnabled = YES;
        NSString * imageName = [NSString stringWithFormat:@"welcome_image_%d", i];
        imageView.image = [UIImage imageNamed:imageName];
        [self.scroll addSubview:imageView];
        
        if (i == IntroductionImagesNo - 1) {
            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 150)];
            button.backgroundColor = [UIColor clearColor];
//            [button setTitle:@"立即体验" forState:UIControlStateNormal];
            button.center = CGPointMake(i * self.width + self.width * 0.5, self.height - kAdaptiveBaseIphone6(120));
            [button addTarget:self action:@selector(immediatelyUse) forControlEvents:UIControlEventTouchUpInside];
            [self.scroll addSubview:button];
        }
//        else {
//            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake((i + 1) * self.width - 20 - 50, 30, 50, 30)];
//            button.backgroundColor = [UIColor lightGrayColor];
//            [button setTitle:@"跳过" forState:UIControlStateNormal];
//            [button addTarget:self action:@selector(immediatelyUse) forControlEvents:UIControlEventTouchUpInside];
//            [self.scroll addSubview:button];
//        }
    }
}

- (void)immediatelyUse
{
    [self removeFromSuperview];
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = fabs(scrollView.contentOffset.x) / self.width;
    self.page.currentPage = index;
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    int index = fabs(scrollView.contentOffset.x) / self.width;
    self.page.currentPage = index;
}

@end

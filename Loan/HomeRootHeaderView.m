//
//  HomeRootHeaderView.m
//  XiChe
//
//  Created by LiuFeifei on 2017/4/14.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

#import "HomeRootHeaderView.h"

@interface HomeRootHeaderView ()

@property (nonatomic, strong) BannerView * bannerView;

@end

@implementation HomeRootHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self buildUI];
        self.bannerView.bannersList = [NSArray array];
//        [BannerModel getBannerListWithBlock:^(id response, id data, NSError *error) {
//            if (data) {
//                self.bannerView.bannersList = data;
//            }
//        }];
    }
    return self;
}

- (void)buildUI
{
    self.bannerView = [[BannerView alloc] init];
    [self addSubview:self.bannerView];
    
    UILabel * label = [[UILabel alloc] init];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.numberOfLines = 0;
    label.text = @"为您推荐";
    [self addSubview:label];
//
//    UIButton * button = [UIButton createButtonWithTitle:@"洗车" color:kWhiteColor font:kFont(20) block:^(UIButton *button) {
//        
//    }];
//    button.backgroundColor = kMainColor;
//    [self addSubview:button];
    
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.equalTo(self);
        make.height.equalTo(@180);
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kCommonMargin);
        make.top.equalTo(self.bannerView.mas_bottom);
        make.width.lessThanOrEqualTo(self).offset(-2 * kCommonMargin);
        make.height.equalTo(@50);
    }];
//
//    [button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(label);
//        make.top.equalTo(label.mas_bottom);
//        make.width.equalTo(self).offset(-2 * kCommonMargin);
//        make.height.equalTo(@(kGeneralSize));
//    }];
    
}

- (void)refreshHeaderViewWithBanners:(NSArray<BannerModel *> *)banners
{
    if (banners) {
        self.bannerView.bannersList = banners;
    }
}

@end

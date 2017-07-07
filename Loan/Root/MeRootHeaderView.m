//
//  MeRootHeaderView.m
//  XiChe
//
//  Created by LiuFeifei on 2017/4/11.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

#import "MeRootHeaderView.h"
//#import "AccountView.h"

@interface MeRootHeaderView ()

@property (nonatomic, strong) UIImageView * avatarImageView;    //头像
@property (nonatomic, strong) UIButton * carInfoButton; //爱车档案
@property (nonatomic, strong) UILabel * userNameLabel;  //用户名
//@property (nonatomic, strong) AccountView * accountView;    // 账户信息
@property (nonatomic, strong) UIButton * userInfoButton;    //  个人信息

@end

@implementation MeRootHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI
{
    self.avatarImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_avatar"]];
//    self.avatarImageView.layer.cornerRadius = 50;
//    self.avatarImageView.layer.masksToBounds = YES;
    [self addSubview:self.avatarImageView];
    
    self.userNameLabel = [[UILabel alloc] init];
    self.userNameLabel.textColor = kTextColor;
    self.userNameLabel.font = kFont(18);
    self.userNameLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:kMobileNo];
    [self addSubview:self.userNameLabel];
    
    kWeakSelf
//    self.carInfoButton = [UIButton createButtonWithTitle:@"我的爱车" color:kTextColor font:kFont(18) block:^(UIButton *button) {
//        kStrongSelf
//        if (strongSelf.myCarClickBlock) {
//            strongSelf.myCarClickBlock(button);
//        }
//    }];
//    self.carInfoButton.userInteractionEnabled = NO;
//    [self addSubview:self.carInfoButton];
    
//    self.accountView = [[AccountView alloc] init];
//    [self addSubview:self.accountView];
    
    self.userInfoButton = [UIButton createButtonWithIconName:@"icon_arrow" block:^(UIButton *button) {
        kStrongSelf
        if (strongSelf.userInfoClickBlock) {
            strongSelf.userInfoClickBlock(button);
        }
    }];
    [self addSubview:self.userInfoButton];
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(kCommonMargin);
        make.width.height.equalTo(@100);
    }];
    
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImageView.mas_right).offset(kCommonMargin);
        make.bottom.equalTo(self.avatarImageView.mas_centerY);
    }];
    
    [self.carInfoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userNameLabel);
        make.top.equalTo(self.avatarImageView.mas_centerY);
    }];
    
    [self.userInfoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(8, 15));
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-kCommonMargin);
    }];
    
//    [self.accountView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.width.equalTo(self);
//        make.top.equalTo(self.avatarImageView.mas_bottom).offset(kCommonMargin);
//        make.height.equalTo(@50);
//    }];
}

@end

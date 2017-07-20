//
//  MeRootHeaderView.m
//  XiChe
//
//  Created by LiuFeifei on 2017/4/11.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

#import "MeRootHeaderView.h"

@interface MeRootHeaderView ()

@property (nonatomic, strong) UIImageView * avatarImageView;    //头像
@property (nonatomic, strong) UILabel * phoneNoLabel;   //手机号
@property (nonatomic, strong) UILabel * userNameLabel;  //用户名
@property (nonatomic, strong) UIButton * userInfoButton;    //  个人信息

@end

@implementation MeRootHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUserInfo) name:@"userInfoChangedNotification" object:nil];
        [self buildUI];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showUserInfo)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)buildUI
{
    self.avatarImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_avatar"]];
    [self addSubview:self.avatarImageView];
    
    self.phoneNoLabel = [[UILabel alloc] init];
    self.phoneNoLabel.textColor = kTextColor;
    self.phoneNoLabel.font = kFont(18);
    self.phoneNoLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:kMobileNo];
    [self addSubview:self.phoneNoLabel];
    
    
    self.userNameLabel = [[UILabel alloc] init];
    self.userNameLabel.textColor = kTextColor;
    self.userNameLabel.font = kFont(18);
    self.userNameLabel.text = [[NSUserDefaults standardUserDefaults] valueForKey:kUserName];
    [self addSubview:self.userNameLabel];

    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.top.equalTo(self).offset(40);
        make.width.height.equalTo(@69);
    }];
    
    [self.phoneNoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImageView.mas_right).offset(24);
        make.bottom.equalTo(self.avatarImageView.mas_centerY);
    }];
    
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneNoLabel);
        make.top.equalTo(self.avatarImageView.mas_centerY);
    }];
    
//    [self.userInfoButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(8, 15));
//        make.centerY.equalTo(self);
//        make.right.equalTo(self).offset(-kCommonMargin);
//    }];
}

- (void)refreshUserInfo
{
    self.phoneNoLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:kMobileNo];
    self.userNameLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:kUserName];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)showUserInfo
{
    if (self.userInfoClickBlock) {
        self.userInfoClickBlock();
    }
}

@end

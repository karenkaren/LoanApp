//
//  UserLoginView.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/12/1.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "UserLoginView.h"
#import "PasswordView.h"
#import "CaptchaView.h"
#import "LoginHeaderView.h"

@interface UserLoginView ()

@property (nonatomic, strong) CaptchaView * captchaView;
@property (nonatomic, strong) UIButton * loginButton;

@end

@implementation UserLoginView

#pragma mark - override
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self buildUI];
        [self addNotifications];
    }
    return self;
}

- (void)buildUI
{
    LoginHeaderView * headerView = [[LoginHeaderView alloc] initWithTitle:@"你好，欢迎回来"];
    [self addSubview:headerView];
    
    self.telephoneTextField = [[CustomTextField alloc] initWithLeftIconName:@"icon_username" placeHolder:@"请输入手机号"];
    self.telephoneTextField.drawBottomLine = YES;
    self.telephoneTextField.limitedCount = 11;
    self.telephoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:self.telephoneTextField];
    
    PasswordView * passwordView = [[PasswordView alloc] initWithIconName:@"icon_password" placeholder:@"请输入密码"];
    self.passwordTextField = passwordView.passwordTextField;
    [self addSubview:passwordView];
    
    CaptchaView * captchaView = [[CaptchaView alloc] initWithIconName:@"icon_captcha" placeholder:@"请输入4位验证码" messageCode:NO limitedCount:4];
    self.captchaTextField = captchaView.captchaTextField;
    self.captchaButton = captchaView.captchaButton;
    [self addSubview:captchaView];
    self.captchaView = captchaView;
    
    UIButton * loginButton = [UIButton createButtonWithTitle:@"登录" color:kWhiteColor font:kFont(16) block:^(UIButton *button) {
        if (self.loginClickBlock) {
            self.loginClickBlock(button);
        }
    }];
    loginButton.enabled = NO;
    [loginButton setDisenableBackgroundColor:kDisabledColor enableBackgroundColor:kMainColor];
    [self addSubview:loginButton];
    self.loginButton = loginButton;
    
    UIButton * retrieveButton = [UIButton createButtonWithTitle:@"忘记密码？" color:kLinkColor font:kFont(12) block:^(UIButton *button) {
        if (self.resetClickBlock) {
            self.resetClickBlock(button);
        }
    }];
    [self addSubview:retrieveButton];
    
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(2 *kCommonMargin);
        make.right.equalTo(self).offset(-2 * kCommonMargin);
        make.height.greaterThanOrEqualTo(@100);
    }];
    
    [self.telephoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_bottom).offset(50);
        make.left.equalTo(self).offset(2 * kCommonMargin);
        make.width.equalTo(self).offset(self.width - 4 * kCommonMargin);
        make.height.equalTo(@(kGeneralSize));
    }];
    
    [passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(self.telephoneTextField);
        make.top.equalTo(self.telephoneTextField.mas_bottom);
    }];
    
    [captchaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(passwordView);
        make.top.equalTo(passwordView.mas_bottom);
    }];
    
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(captchaView);
        make.top.equalTo(captchaView.mas_bottom).offset(20);
    }];
    
    [retrieveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(loginButton);
        make.top.equalTo(loginButton.mas_bottom).offset(15);
    }];
}

- (void)addNotifications
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)didChange:(NSNotification *)notification
{
    BOOL enabled = self.telephoneTextField.text.length && self.passwordTextField.text.length && self.captchaTextField.text.length;
    self.loginButton.enabled = enabled;
}

#pragma mark - setter methods
- (void)setGetCaptchaClickBlock:(void (^)(UIButton *))getCaptchaClickBlock
{
    _getCaptchaClickBlock = getCaptchaClickBlock;
    if (getCaptchaClickBlock) {
        self.captchaView.getCaptchaClickBlock = getCaptchaClickBlock;
    }
}

@end

//
//  UserRegisterView.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/22.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "UserRegisterView.h"
#import "PasswordView.h"
#import "CaptchaView.h"
#import "LoginHeaderView.h"

@interface UserRegisterView ()

@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic, assign) CaptchaView * captchaView;
@property (nonatomic, assign) UIButton * registerButton;
@property (nonatomic, assign) BOOL agree;

@end

@implementation UserRegisterView

#pragma mark - override
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.agree = YES;
        [self buildUI];
        [self addNotifications];
    }
    return self;
}

#pragma mark - private methods
- (void)buildUI
{
    LoginHeaderView * headerView = [[LoginHeaderView alloc] initWithTitle:@"属于你的借款平台"];
    [self addSubview:headerView];
    
    self.telephoneTextField = [[CustomTextField alloc] initWithLeftIconName:@"icon_mobileno" placeHolder:@"推荐使用银行预留手机号"];
    self.telephoneTextField.drawBottomLine = YES;
    self.telephoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.telephoneTextField.limitedCount = 11;
    [self addSubview:self.telephoneTextField];
    
    PasswordView * passwordView = [[PasswordView alloc] initWithIconName:@"icon_password" placeholder:@"请输入密码"];
    self.passwordTextField = passwordView.passwordTextField;
    [self addSubview:passwordView];
    
    CaptchaView * captchaView = [[CaptchaView alloc] initWithIconName:@"icon_captcha" placeholder:@"请输入4位验证码" messageCode:YES limitedCount:4];
    self.captchaTextField = captchaView.captchaTextField;
    self.captchaButton = captchaView.captchaButton;
    [self addSubview:captchaView];
    self.captchaView = captchaView;
    
    UIButton * registerButton = [UIButton createButtonWithTitle:@"注册" color:kWhiteColor font:kFont(16) block:^(UIButton *button) {
        if (self.registerClickBlock) {
            self.registerClickBlock(button);
        }
    }];
    registerButton.enabled = NO;
    [registerButton setDisenableBackgroundColor:kDisabledColor enableBackgroundColor:kMainColor];
    [self addSubview:registerButton];
    self.registerButton = registerButton;
    
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
    
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(captchaView);
        make.top.equalTo(captchaView.mas_bottom).offset(20);
    }];
}

- (void)addNotifications
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)didChange:(NSNotification *)notification
{
    BOOL enabled = self.telephoneTextField.text.length && self.passwordTextField.text.length && self.captchaTextField.text.length && self.agree;
    self.registerButton.enabled = enabled;
}

#pragma mark - setter methods
- (void)setGetCaptchaClickBlock:(void (^)(UIButton *))getCaptchaClickBlock
{
    _getCaptchaClickBlock = getCaptchaClickBlock;
    if (getCaptchaClickBlock) {
        self.captchaView.getCaptchaClickBlock = getCaptchaClickBlock;
    }
}

- (void)setShowProtocolBlock:(void (^)(void))showProtocolBlock
{
    _showProtocolBlock = showProtocolBlock;
    if (showProtocolBlock) {
//        self.baseLoginView.showProtocolBlock = showProtocolBlock;
    }
}

- (void)startTimer
{
    [self.captchaView startTimer];
}

- (void)stopTimer
{
    [self.captchaView stopTimer];
}

@end

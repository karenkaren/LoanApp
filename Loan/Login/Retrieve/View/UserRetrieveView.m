//
//  UserRetrieveView.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/28.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "UserRetrieveView.h"
#import "CaptchaView.h"

#define kTextFieldHeight kGeneralSize

@interface UserRetrieveView ()

//@property (nonatomic, strong) BaseLoginView * baseLoginView;
@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic, strong) UIButton * submitButton;
@property (nonatomic, strong) CaptchaView * captchaView;

@end

@implementation UserRetrieveView

#pragma mark - override
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kHexColor(0xf9f9f9);
        [self buildUI];
        [self addNotifications];
    }
    return self;
}

#pragma mark - private methods
- (void)buildUI
{
    self.telephoneTextField = [[CustomTextField alloc] initWithLeftTitle:@"手机号" placeHolder:@"请输入手机号"];
    self.telephoneTextField.drawBottomLine = YES;
    self.telephoneTextField.drawTopLine = YES;
    self.telephoneTextField.limitedCount = 11;
    self.telephoneTextField.backgroundColor = kWhiteColor;
    self.telephoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:self.telephoneTextField];
    
    CaptchaView * captchaView = [[CaptchaView alloc] initWithTitle:@"验证码" placeholder:@"请输入验证码" messageCode:YES limitedCount:4];
    self.captchaTextField = captchaView.captchaTextField;
    self.captchaButton = captchaView.captchaButton;
    captchaView.backgroundColor = kWhiteColor;
    [self addSubview:captchaView];
    self.captchaView = captchaView;
    
    self.identityTextField = [[CustomTextField alloc] initWithLeftTitle:@"身份证号" placeHolder:@"请输入身份证号码"];
    self.identityTextField.drawBottomLine = YES;
    self.identityTextField.hidden = YES;
    self.identityTextField.backgroundColor = kWhiteColor;
    self.identityTextField.limitedCount = 18;
    [self addSubview:self.identityTextField];
    
    UIButton * submitButton = [UIButton createButtonWithTitle:@"确定" color:kWhiteColor font:kFont(16) block:^(UIButton *button) {
        if (self.retrieveClickBlock) {
            self.retrieveClickBlock(button);
        }
    }];
    [submitButton setDisenableBackgroundColor:kDisabledColor enableBackgroundColor:kMainColor];
    [self addSubview:submitButton];
    self.submitButton = submitButton;
    
    [self.telephoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.height.equalTo(@(kGeneralSize));
        make.left.width.equalTo(self);
    }];
    
    [captchaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(self.telephoneTextField);
        make.top.equalTo(self.telephoneTextField.mas_bottom);
    }];
    
    [self.identityTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(captchaView);
        make.top.equalTo(captchaView.mas_bottom);
    }];
    
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.height.equalTo(captchaView);
        make.width.equalTo(self).offset(-2 * kCommonMargin);
        make.top.equalTo(captchaView.mas_bottom).offset(20);
    }];
}

- (void)addNotifications
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)didChange:(NSNotification *)notification
{
    BOOL enabled = self.telephoneTextField.text.length && self.captchaTextField.text.length;
    if (!self.identityTextField.hidden) {
        enabled = enabled && self.identityTextField.text.length;
    }
    self.submitButton.enabled = enabled;
}

- (void)startTimer
{
    [self.captchaView startTimer];
}

- (void)stopTimer
{
    [self.captchaView stopTimer];
}

#pragma mark - setter methods
- (void)setGetCaptchaClickBlock:(void (^)(UIButton *))getCaptchaClickBlock
{
    _getCaptchaClickBlock = getCaptchaClickBlock;
    if (getCaptchaClickBlock) {
        self.captchaView.getCaptchaClickBlock = getCaptchaClickBlock;
    }
}

- (void)setShowIdentityDialog:(BOOL)showIdentityDialog
{
    if (_showIdentityDialog == showIdentityDialog) {
        return;
    }
    _showIdentityDialog = showIdentityDialog;
    if (showIdentityDialog) {
        self.identityTextField.hidden = NO;
        self.submitButton.top = self.identityTextField.bottom + 20;
    }
}

@end

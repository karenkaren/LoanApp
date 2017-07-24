//
//  UserModifyView.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/28.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "UserModifyView.h"

@interface UserModifyView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIButton * submitButton;

@end

@implementation UserModifyView

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
    self.passwordTextField = [[CustomTextField alloc] initWithPlaceholder:@"请输入6-18位新密码" insets:UIEdgeInsetsMake(0, 20, 0, 20)];
    self.passwordTextField.drawBottomLine = YES;
    self.passwordTextField.drawTopLine = YES;
    self.passwordTextField.limitedCount = 11;
    self.passwordTextField.backgroundColor = kWhiteColor;
    self.passwordTextField.secureTextEntry = YES;
    [self addSubview:self.passwordTextField];
    
    self.passwordAgainTextField = [[CustomTextField alloc] initWithPlaceholder:@"请再次输入新密码" insets:UIEdgeInsetsMake(0, 20, 0, 20)];
    self.passwordAgainTextField.drawBottomLine = YES;
    self.passwordAgainTextField.limitedCount = 11;
    self.passwordAgainTextField.backgroundColor = kWhiteColor;
    self.passwordAgainTextField.secureTextEntry = YES;
    [self addSubview:self.passwordAgainTextField];
    
    UIButton * submitButton = [UIButton createButtonWithTitle:@"确认重设" color:kWhiteColor font:kFont(16) block:^(UIButton *button) {
        if (self.modifyClickBlock) {
            self.modifyClickBlock(button);
        }
    }];
    submitButton.enabled = NO;
    [submitButton setDisenableBackgroundColor:kDisabledColor enableBackgroundColor:kMainColor];
    [submitButton setTitleColor:kBlackColor forState:UIControlStateNormal];
    [submitButton setTitleColor:kWhiteColor forState:UIControlStateDisabled];
    submitButton.layer.cornerRadius = 5;
    submitButton.layer.masksToBounds = YES;
    [self addSubview:submitButton];
    self.submitButton = submitButton;
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.height.equalTo(@(kGeneralSize));
        make.left.width.equalTo(self);
    }];
    
    [self.passwordAgainTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(self.passwordTextField);
        make.top.equalTo(self.passwordTextField.mas_bottom);
    }];
    
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.height.equalTo(self.passwordAgainTextField);
        make.width.equalTo(self).offset(-2 * kCommonMargin);
        make.top.equalTo(self.passwordAgainTextField.mas_bottom).offset(20);
    }];
}

- (void)addNotifications
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)didChange:(NSNotification *)notification
{
    BOOL enabled = self.passwordTextField.text.length && self.passwordAgainTextField.text.length;
    self.submitButton.enabled = enabled;
}

@end

//
//  PasswordView.m
//  LingTouNiaoLoan
//
//  Created by LiuFeifei on 17/1/10.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

#import "PasswordView.h"

@interface PasswordView ()

@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * placeholder;
@property (nonatomic, copy) NSString * leftIconName;
@property (nonatomic, strong) UIButton * hidenButton;

@end

@implementation PasswordView

- (instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder
{
    self = [super init];
    if (self) {
        self.placeholder = placeholder;
        self.title = title;
        [self buildUI];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    }
    return self;
}

- (instancetype)initWithIconName:(NSString *)iconName placeholder:(NSString *)placeholder
{
    self = [super init];
    if (self) {
        self.placeholder = placeholder;
        self.leftIconName = iconName;
        [self buildUI];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    }
    return self;
}

- (CustomTextField *)passwordTextField
{
    if (!_passwordTextField) {
        if (![esString(self.title) isEqualToString:@""]) {
            _passwordTextField = [[CustomTextField alloc] initWithLeftTitle:self.title placeHolder:self.placeholder];
        } else if (![esString(self.leftIconName) isEqualToString:@""]) {
            _passwordTextField = [[CustomTextField alloc] initWithLeftIconName:self.leftIconName placeHolder:self.placeholder];
        } else {
            _passwordTextField = [[CustomTextField alloc] initWithPlaceholder:self.placeholder];
        }
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.drawBottomLine = YES;
        _passwordTextField.limitedCount = 18;
    }
    return _passwordTextField;
}

- (void)buildUI
{
    [self addSubview:self.passwordTextField];
    UIButton * hidenButton = [UIButton createButtonWithNomalIconName:@"icon_hide" selectedIconName:@"icon_show" block:^(UIButton * button) {
        self.passwordTextField.secureTextEntry = button.selected;
        button.selected = !button.selected;
    }];
    hidenButton.hidden = YES;
    [self addSubview:hidenButton];
    self.hidenButton = hidenButton;
    
    UIView * bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = kLineColor;
    [self addSubview:bottomLine];
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self).offset(-22);
        make.top.left.height.equalTo(self);
    }];
    [hidenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.passwordTextField.mas_height);
        make.width.equalTo(@22);
        make.top.right.equalTo(self);
    }];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.bottom.equalTo(hidenButton);
        make.height.equalTo(@(kLineThick));
    }];
}
//- (UIView *)passwordView
//{
//    if (!_passwordView) {
//        _passwordView = [[UIView alloc] init];
//        [_passwordView addSubview:self.passwordTextField];
//        UIButton * hidenButton = [UIButton createButtonWithNomalIconName:@"yanjing" selectedIconName:@"yanjing2" block:^(UIButton * button) {
//            self.passwordTextField.secureTextEntry = button.selected;
//            button.selected = !button.selected;
//        }];
//        hidenButton.hidden = YES;
//        [_passwordView addSubview:hidenButton];
//        self.hidenButton = hidenButton;
//        
//        UIView * bottomLine = [[UIView alloc] init];
//        bottomLine.backgroundColor = kLineColor;
//        [_passwordView addSubview:bottomLine];
//        
//        [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.equalTo(_passwordView).offset(-22);
//            make.top.left.height.equalTo(_passwordView);
//        }];
//        [hidenButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(self.passwordTextField.mas_height);
//            make.width.equalTo(@22);
//            make.top.right.equalTo(_passwordView);
//        }];
//        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.left.bottom.equalTo(hidenButton);
//            make.height.equalTo(@(kLineThick));
//        }];
//    }
//    return _passwordView;
//}

#pragma mark - notification methods
- (void)textFieldTextDidChange:(NSNotification *)notification
{
    self.hidenButton.hidden = !self.passwordTextField.text.length;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

//
//  CustomButton.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/12/7.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

#pragma mark - 带背景色的button
+ (instancetype)createBigBGButtonWithTitle:(NSString *)title actionBolck:(ButtonBlockAction)actionBolck
{
    CustomButton * button = [CustomButton createBGButtonWithTitle:title actionBolck:actionBolck];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(kScreenWidth));
        make.height.equalTo(@(kAdaptiveBaseIphone6(45)));
    }];
    return button;
}

+ (instancetype)createMiddleBGButtonWithTitle:(NSString *)title actionBolck:(ButtonBlockAction)actionBolck
{
    CustomButton * button = [CustomButton createBGButtonWithTitle:title actionBolck:actionBolck];
    button.layer.cornerRadius = 2.5;
    button.layer.masksToBounds = YES;
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(kAdaptiveBaseIphone6(343)));
        make.height.equalTo(@(kAdaptiveBaseIphone6(45)));
    }];
    return button;
}

+ (instancetype)createSmallBGButtonWithTitle:(NSString *)title actionBolck:(ButtonBlockAction)actionBolck
{
    CustomButton * button = [CustomButton createBGButtonWithTitle:title actionBolck:actionBolck];
    [button setDisenableBackgroundColor:kDisabledColor enableBackgroundColor:kMainColor];
    [button.titleLabel setFont:kFont14];
    button.layer.cornerRadius = 50;
    button.layer.masksToBounds = YES;
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(kAdaptiveBaseIphone6(94)));
        make.height.equalTo(@(kAdaptiveBaseIphone6(23)));
    }];
    return button;
}

+ (instancetype)createBGButtonWithTitle:(NSString *)title actionBolck:(ButtonBlockAction)actionBolck
{
    CustomButton * button = [[CustomButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [button setTitleColor:[kWhiteColor colorWithAlphaComponent:0.8] forState:UIControlStateDisabled];
    [button.titleLabel setFont:kFont18];
    [button sizeToFit];
    button.tappedBlock = actionBolck;
    [button setDisenableBackgroundColor:[kMainColor colorWithAlphaComponent:0.2] enableBackgroundColor:kMainColor];
    return button;
}

#pragma mark - 描边button
+ (instancetype)createBigBorderButtonWithTitle:(NSString *)title actionBolck:(ButtonBlockAction)actionBolck
{
    CustomButton * button = [CustomButton createBorderButtonWithTitle:title actionBolck:actionBolck];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(kScreenWidth));
        make.height.equalTo(@(kAdaptiveBaseIphone6(45)));
    }];
    return button;
}

+ (instancetype)createMiddleBorderButtonWithTitle:(NSString *)title actionBolck:(ButtonBlockAction)actionBolck
{
    CustomButton * button = [CustomButton createBorderButtonWithTitle:title actionBolck:actionBolck];
    button.layer.cornerRadius = 2.5;
    button.layer.masksToBounds = YES;
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(kAdaptiveBaseIphone6(343)));
        make.height.equalTo(@(kAdaptiveBaseIphone6(45)));
    }];
    return button;
}

+ (instancetype)createSmallBorderButtonWithTitle:(NSString *)title actionBolck:(ButtonBlockAction)actionBolck
{
    CustomButton * button = [CustomButton createBorderButtonWithTitle:title actionBolck:actionBolck];
    button.layer.cornerRadius = 50;
    button.layer.masksToBounds = YES;
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(kAdaptiveBaseIphone6(94)));
        make.height.equalTo(@(kAdaptiveBaseIphone6(23)));
    }];
    return button;
}

+ (instancetype)createBorderButtonWithTitle:(NSString *)title actionBolck:(ButtonBlockAction)actionBolck
{
    CustomButton * button = [[CustomButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:kMainColor forState:UIControlStateNormal];
    [button setTitleColor:[kMainColor colorWithAlphaComponent:0.2] forState:UIControlStateDisabled];
    button.backgroundColor = kWhiteColor;
    [button.titleLabel setFont:kFont18];
    [button sizeToFit];
    button.tappedBlock = actionBolck;
    button.layer.borderWidth = 1.0 / kScreenScale;

    return button;
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    if (self.layer.borderWidth) {
        self.layer.borderColor = enabled ? kMainColor.CGColor : [kMainColor colorWithAlphaComponent:0.2].CGColor;
    }
}

@end

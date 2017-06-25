//
//  UserLoginView.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/12/1.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"

@interface UserLoginView : UIView

@property (nonatomic, strong) CustomTextField * telephoneTextField;
@property (nonatomic, strong) CustomTextField * passwordTextField;
@property (nonatomic, strong) CustomTextField * captchaTextField;
@property (nonatomic, strong) UIButton * captchaButton;

@property (nonatomic, copy) void(^resetClickBlock)(UIButton *button);
@property (nonatomic, copy) void(^loginClickBlock)(UIButton *button);
@property (nonatomic, copy) void(^getCaptchaClickBlock)(UIButton *button);

@end

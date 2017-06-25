//
//  UserRegisterView.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/22.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"

@interface UserRegisterView : UIView

@property (nonatomic, strong) CustomTextField * telephoneTextField;
@property (nonatomic, strong) CustomTextField * passwordTextField;
@property (nonatomic, strong) CustomTextField * captchaTextField;
@property (nonatomic, strong) UIButton * captchaButton;

@property (nonatomic, copy) void(^registerClickBlock)(UIButton *button);
@property (nonatomic, copy) void(^getCaptchaClickBlock)(UIButton *button);

@property (nonatomic, copy) VoidBlock showProtocolBlock;

- (void)startTimer;
- (void)stopTimer;

@end

//
//  UserRetrieveView.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/28.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"

@interface UserRetrieveView : UIView

@property (nonatomic, strong) CustomTextField * telephoneTextField;
@property (nonatomic, strong) CustomTextField * captchaTextField;
@property (nonatomic, strong) CustomTextField * identityTextField;
@property (nonatomic, strong) UIButton * captchaButton;

@property (nonatomic, copy) void(^retrieveClickBlock)(UIButton *button);
@property (nonatomic, copy) void(^getCaptchaClickBlock)(UIButton *button);

@property (nonatomic, assign, getter=isShowCaptchDialog) BOOL showIdentityDialog;

- (void)startTimer;
- (void)stopTimer;

@end

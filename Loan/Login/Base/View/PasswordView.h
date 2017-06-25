//
//  PasswordView.h
//  LingTouNiaoLoan
//
//  Created by LiuFeifei on 17/1/10.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"

@interface PasswordView : UIView

@property (nonatomic, strong) CustomTextField * passwordTextField;

- (instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder;
- (instancetype)initWithIconName:(NSString *)title placeholder:(NSString *)placeholder;

@end

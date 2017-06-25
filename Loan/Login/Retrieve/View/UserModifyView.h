//
//  UserModifyView.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/28.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"

@interface UserModifyView : UIView

@property (nonatomic, strong) CustomTextField * passwordTextField;
@property (nonatomic, strong) CustomTextField * passwordAgainTextField;

@property (nonatomic, copy) void(^modifyClickBlock)(UIButton *button);

@end

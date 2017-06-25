//
//  CustomButton.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/12/7.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomButton : UIButton

#pragma mark - 带背景色的button
+ (instancetype)createBigBGButtonWithTitle:(NSString *)title actionBolck:(ButtonBlockAction)actionBolck;
+ (instancetype)createMiddleBGButtonWithTitle:(NSString *)title actionBolck:(ButtonBlockAction)actionBolck;
+ (instancetype)createSmallBGButtonWithTitle:(NSString *)title actionBolck:(ButtonBlockAction)actionBolck;
+ (instancetype)createBGButtonWithTitle:(NSString *)title actionBolck:(ButtonBlockAction)actionBolck;

#pragma mark - 描边button
+ (instancetype)createBigBorderButtonWithTitle:(NSString *)title actionBolck:(ButtonBlockAction)actionBolck;
+ (instancetype)createMiddleBorderButtonWithTitle:(NSString *)title actionBolck:(ButtonBlockAction)actionBolck;
+ (instancetype)createSmallBorderButtonWithTitle:(NSString *)title actionBolck:(ButtonBlockAction)actionBolck;
+ (instancetype)createBorderButtonWithTitle:(NSString *)title actionBolck:(ButtonBlockAction)actionBolck;

@end

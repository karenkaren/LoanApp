//
//  UIButton+Extension.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/24.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ButtonBlockAction)(UIButton * button);

@interface UIButton (Extension)

@property (nonatomic) ButtonBlockAction tappedBlock;

#pragma mark - 点击范围放大
- (void)setEnlargeEdge:(CGFloat) size;
- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;

#pragma mark - 背景颜色
- (void)setDisenableBackgroundColor:(UIColor *)disenableColor enableBackgroundColor:(UIColor *)enableColor;

#pragma mark - 按钮创建
+ (UIButton *)createButtonWithNomalIconName:(NSString *)nomalIconName selectedIconName:(NSString *)selectedIconName block:(ButtonBlockAction)block;
+ (UIButton *)createButtonWithIconName:(NSString *)iconName block:(ButtonBlockAction)block;
+ (UIButton *)createButtonWithTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font block:(ButtonBlockAction)block;

@end

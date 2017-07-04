//
//  UIButton+Extension.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/24.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "UIButton+Extension.h"
#import <objc/runtime.h>

@implementation UIButton (Extension)

#pragma mark - 点击范围放大
static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;

- (void)setEnlargeEdge:(CGFloat)size
{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left
{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect)enlargedRect
{
    NSNumber* topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber* rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber* leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge)
    {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    }
    else
    {
        return self.bounds;
    }
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect rect = [self enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds))
    {
        return [super pointInside:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? YES : NO;
}

#pragma mark - 背景颜色
- (void)setDisenableBackgroundColor:(UIColor *)disenableColor enableBackgroundColor:(UIColor *)enableColor
{
    [self setBackgroundColor:enableColor forStatus:UIControlStateNormal];
    [self setBackgroundColor:disenableColor forStatus:UIControlStateDisabled];
}

- (void)setBackgroundColor:(UIColor *)color forStatus:(UIControlState)state
{
    [self setBackgroundImage:[UIImage imageWithColor:color] forState:state];
}

#pragma mark 创建自定义按钮
- (ButtonBlockAction)tappedBlock {
    return objc_getAssociatedObject(self, @selector(tappedBlock));
}

- (void)setTappedBlock:(ButtonBlockAction)tappedBlock {
    [self addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    objc_setAssociatedObject(self, @selector(tappedBlock), tappedBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)buttonTapped:(UIButton *)button {
    if (self.tappedBlock) {
        self.tappedBlock(button);
    }
} 

+ (UIButton *)createButtonWithNomalIconName:(NSString *)nomalIconName selectedIconName:(NSString *)selectedIconName block:(ButtonBlockAction)block
{
    UIButton * button = [UIButton createButtonWithIconName:nomalIconName block:block];
    [button setImage:[UIImage imageNamed:selectedIconName] forState:UIControlStateSelected];
    return button;
}

+ (UIButton *)createButtonWithIconName:(NSString *)iconName block:(ButtonBlockAction)block
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
    button.tappedBlock = block;
    return button;
}

+ (UIButton *)createButtonWithTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font block:(ButtonBlockAction)block {
    UIButton * button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button.titleLabel setFont:font];
    [button sizeToFit];
    button.tappedBlock = block;
    return button;
}

@end

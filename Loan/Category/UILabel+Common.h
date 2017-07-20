//
//  UILabel+Common.h
//  LingTouNiaoLoan
//
//  Created by LiuFeifei on 17/1/10.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Common)

+ (UILabel *)createLabelWithText:(NSString *)text font:(UIFont *)textFont color:(UIColor *)textColor;
- (void)changeLineSpace:(CGFloat)space;
- (void)changeWordSpace:(CGFloat)space;
- (void)changeLineSpace:(CGFloat)lineSpace wordSpace:(CGFloat)wordSpace;

@end

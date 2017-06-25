//
//  UILabel+Common.m
//  LingTouNiaoLoan
//
//  Created by LiuFeifei on 17/1/10.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

#import "UILabel+Common.h"

@implementation UILabel (Common)

+ (UILabel *)createLabelWithText:(NSString *)text font:(UIFont *)textFont color:(UIColor *)textColor {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = textColor;
    label.backgroundColor = [UIColor clearColor];
    label.font = textFont;
    label.text = text;
    [label sizeToFit];
    return label;
}

@end

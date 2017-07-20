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

- (void)changeLineSpace:(CGFloat)space
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.text.length)];
    self.attributedText = attributedString;
    [self sizeToFit];
}

- (void)changeWordSpace:(CGFloat)space
{
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:self.text attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.text.length)];
    self.attributedText = attributedString;
    [self sizeToFit];
}

- (void)changeLineSpace:(CGFloat)lineSpace wordSpace:(CGFloat)wordSpace
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.text.length)];
    self.attributedText = attributedString;
    [self sizeToFit];
}

@end

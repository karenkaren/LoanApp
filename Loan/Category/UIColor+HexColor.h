//
//  UIColor+HexColor.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/24.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexColor)

#pragma mark - uint -> color
//根据十六进制数获取颜色，hex格式：0xffffff
+ (UIColor *)colorWithHex:(uint)hex;
+ (UIColor *)colorWithHex:(uint)hex alpha:(CGFloat)alpha;

#pragma mark - string -> color
//从十六进制字符串获取颜色 color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color;
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end

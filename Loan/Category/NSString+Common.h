//
//  NSString+Common.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/27.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Common)

// 加密
+ (NSString *)md5:(NSString *)input;
+ (NSString *) sha1:(NSString *)input;

// 字典－>字符串
+ (NSString *)serialize:(NSDictionary *)dict;
// 获取绝对路径
+ (NSString *)netAbsolutePath:(NSString *)path;
// 计算文本尺寸
+ (CGSize)sizeWithText:(NSString *)text boundingSize:(CGSize)boundingSize font:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode;

#pragma mark - 文本格式化
// 去掉空格
+ (NSString *)trimSpacesOfString:(NSString *)string;
+ (NSString* )starsReplacedOfString:(NSString *)str withinRange:(NSRange)range;

@end

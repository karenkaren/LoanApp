//
//  NSString+Check.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/24.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Check)

/**
 * 判断是否为手机号码
 */
+ (BOOL)isPhoneNumber:(NSString *)string;
/**
 *  正则判断是否为18位身份证号
 */
+ (BOOL)isUserIdCard:(NSString *)string;
/**
 *  18位身份证号码校验
 */
+ (BOOL)isValidIDCardNumber:(NSString *)string;
/**
 *  正则判断密码是否为6+18位数字和字母组合
 */
+ (BOOL)isPassword:(NSString *)string;
/**
 *  判断是否为2位小数
 */
+ (BOOL)isValidDecimal:(NSString *)string;
/**
 *  判断是否为整数
 */
+ (BOOL)isPureInterger:(NSString *)string;
/**
 *  判断是否为float型
 */
+ (BOOL)isPureFloat:(NSString *)string;
/**
 *  判断是否为double型
 */
+ (BOOL)isPureDouble:(NSString *)string;
/**
 *  判断是否为纯数字
 */
+ (BOOL)isPureNumericCharacters:(NSString *)string;
/**
 *  判断是否为邮箱
 */
+ (BOOL)isValidEmail:(NSString *)string;
/**
 *  判断字符串是否为空
 */
+ (BOOL)isEmpty:(NSString *)string;
/**
 *  判断字符串是否为有效名字
 */
+(BOOL)isValidName:(NSString *)string;

@end

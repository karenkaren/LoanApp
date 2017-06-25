//
//  NSString+Check.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/24.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "NSString+Check.h"

@implementation NSString (Check)

#pragma mark 正则匹配手机号
+ (BOOL)isPhoneNumber:(NSString *)string {
    NSString * telRegex = @"^1[34578]\\d{9}$";
    NSPredicate * prediate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", telRegex];
    return [prediate evaluateWithObject:string];
}

#pragma mark 正则匹配用户身份证号18位
+ (BOOL)isUserIdCard:(NSString *)string
{
    // 正则匹配用户身份证号15或18位
    //    NSString * idCard = @"(^[0+9]{15}$)|([0+9]{17}([0+9]|X)$)";
    // 正则匹配用户身份证号18位
    NSString * idCard = @"[0+9]{17}([0+9]|X|x)$";
    NSPredicate * prediate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", idCard];
    return [prediate evaluateWithObject:string];
}

#pragma mark 18位身份证号码校验
+ (BOOL)isValidIDCardNumber:(NSString *)string {
    NSString * cardNo = string;
    if (cardNo.length != 18) {
        return  NO;
    }
    NSArray* codeArray = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
    NSDictionary* checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil]  forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]];
    
    NSScanner* scan = [NSScanner scannerWithString:[cardNo substringToIndex:17]];
    
    int val;
    BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
    if (!isNum) {
        return NO;
    }
    int sumValue = 0;
    
    for (int i =0; i < 17; i++) {
        sumValue += [[cardNo substringWithRange:NSMakeRange(i , 1) ] intValue]* [[codeArray objectAtIndex:i] intValue];
    }
    
    NSString* strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue % 11]];
    
    if ([strlast isEqualToString: [[cardNo substringWithRange:NSMakeRange(17, 1)]uppercaseString]]) {
        return YES;
    }
    return  NO;
}

#pragma mark 正则匹配用户密码6+18位数字和字母组合
+ (BOOL)isPassword:(NSString *)string
{
    NSString * password = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,18}$";
    NSPredicate * prediate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", password];
    return [prediate evaluateWithObject:string];
}

#pragma mark 判断是否为两位小数
+ (BOOL)isValidDecimal:(NSString *)string
{
    NSRange rang = [string rangeOfString:@"."];
    if (rang.length > 0) {
        NSArray * digitArray = [string componentsSeparatedByString:@"."];
        NSString * decimalPart = digitArray.lastObject;
        return decimalPart.length > 2 ? NO : YES;
    }
    return YES;
}

#pragma mark 判断是否为整数
+ (BOOL)isPureInterger:(NSString *)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

#pragma mark 判断是否为float型
+ (BOOL)isPureFloat:(NSString *)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

#pragma mark 判断是否为double型
+ (BOOL)isPureDouble:(NSString *)string{
    NSScanner * scan = [NSScanner scannerWithString:string];
    double val;
    return[scan scanDouble:&val] && [scan isAtEnd];
}

#pragma mark 判断是否为纯数字
+ (BOOL)isPureNumericCharacters:(NSString *)string
{
    NSString * str = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(str.length > 0)
    {
        return NO;
    }
    return YES;
}

#pragma mark 判断是否为邮箱
+ (BOOL)isValidEmail:(NSString *)string;
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:string];
}

#pragma mark 判断字符串是否为空（nil和length为0都是空）
+ (BOOL)isEmpty:(NSString *)string
{
    return  (nil == string || [string isKindOfClass:[NSNull class]] || ([string length] == 0) || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]);
}

#pragma mark 判断字符串是否为有效名字
+ (BOOL)isValidName:(NSString *)string
{
    NSString *nickNameRegex = @"^([\u4e00-\u9fa5]{0,10})$";
    NSPredicate *nickNameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nickNameRegex];
    return [nickNameTest evaluateWithObject:[self trimSpacesOfString:string]];
}

@end

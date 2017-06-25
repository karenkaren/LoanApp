//
//  NSString+Common.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/27.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "NSString+Common.h"
#import <CommonCrypto/CommonDigest.h>
//#import <GTM>
//GTMDefines.h
//GTMBase64.h
//GTMBase64.m

@implementation NSString (Common)
#pragma mark - 加密
+ (NSString *)md5:(NSString *)input
{
    if (!input) {
        return nil;
    }
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (unsigned int)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

+ (NSString *)sha1:(NSString *)input
{
    if (!input) {
        return nil;
    }
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

#pragma mark 字典－>字符串
+ (NSString *)serialize:(NSDictionary *)dict {
    NSArray *sortedValues = [[dict allKeys] sortedArrayUsingSelector: @selector(compare:)];
    if ([sortedValues count] == 0) {
        NSAssert(NO, @"sign empty data");
        return @"";
    }
    
    NSMutableString *inputString = [NSMutableString stringWithFormat:@"%@=%@",[sortedValues objectAtIndex:0],[dict valueForKey:[sortedValues objectAtIndex:0]]];
    for (int i = 1; i < [sortedValues count]; i++) {
        [inputString appendString:[NSString stringWithFormat:@"%@=%@",[sortedValues objectAtIndex:i],[dict valueForKey:[sortedValues objectAtIndex:i]]]];
    }
    return inputString;
}

+ (NSString *)netAbsolutePath:(NSString *)path
{
    NSString * fullPath;
    if([path hasPrefix:@"http"])
        fullPath=path;
    else{
        fullPath = [NSString stringWithFormat:@"%@%@", API_BASE_URL, path];
    }
    return fullPath;
}

+ (CGSize)sizeWithText:(NSString *)text boundingSize:(CGSize)boundingSize font:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    CGSize textSize;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = lineBreakMode;
    NSDictionary *ats = @{
                          NSFontAttributeName : font,
                          NSParagraphStyleAttributeName : paragraphStyle
                          };
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0
    CGRect rect = [text boundingRectWithSize:boundingSize
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine
                                  attributes:ats
                                     context:nil];
    textSize        = rect.size;
    textSize.width  = ceil(textSize.width);
    textSize.height = ceil(textSize.height);
    
#else
    // -boundingRectWithSize:options:attributes:context: is available in iOS 7.0 and later
    if ( [text respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)] ) {
        CGRect rect = [text boundingRectWithSize:boundingSize
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine
                                      attributes:ats
                                         context:nil];
        textSize        = rect.size;
        textSize.width  = ceil(textSize.width);
        textSize.height = ceil(textSize.height);
        
    }else{
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        textSize = [text sizeWithFont:font constrainedToSize:boundingSize lineBreakMode:lineBreakMode];
        textSize.width  = ceil(textSize.width);
        textSize.height = ceil(textSize.height);
#pragma clang diagnostic pop
        
    }
#endif
    return textSize;
}

#pragma mark - 文本格式化
// 去掉空格
+ (NSString *)trimSpacesOfString:(NSString *)string
{
    return [string stringByReplacingOccurrencesOfString:@" " withString:@""];
}

+ (NSString *)starsReplacedOfString:(NSString *)str withinRange:(NSRange)range
{
    if (str == nil || [str length]< range.location + range.length)
    {
        return str;
    }
    
    NSMutableString* mStr = [[NSMutableString alloc]initWithString:str];
    
    [mStr replaceCharactersInRange:range withString:[[NSString string] stringByPaddingToLength:range.length withString: @"*" startingAtIndex:0]];
    
    return mStr;
}



@end

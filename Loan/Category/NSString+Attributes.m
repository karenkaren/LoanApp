//
//  NSString+Attributes.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/25.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "NSString+Attributes.h"

@implementation NSString (Attributes)

- (NSAttributedString *)configAttributes:(NSDictionary *)attributes forString:(NSString *)string
{
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    NSString * temp = nil;
    for(int i = 0; i < self.length; i++)
    {
        if (i + string.length > self.length) {
            break;
        }
        temp = [self substringWithRange:NSMakeRange(i, string.length)];
        if ([temp isEqualToString:string]) {
            [attributedString addAttributes:attributes range:NSMakeRange(i, string.length)];
        }
    }
    return attributedString;
}

- (NSAttributedString *)configAttributesWithFontSize:(NSInteger)fontSize forString:(NSString *)string
{
    NSDictionary * attributes = @{NSFontAttributeName : kFont(fontSize)};
    return [self configAttributes:attributes forString:string];
}

- (NSAttributedString *)configAttributes:(NSDictionary *)attributes forStringArray:(NSArray *)stringArray
{
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    for (int i = 0; i < stringArray.count; i++) {
        NSString * string = stringArray[i];
        NSString * temp = nil;
        for(int j = 0; j < self.length; j++)
        {
            if (j + string.length > self.length) {
                break;
            }
            temp = [self substringWithRange:NSMakeRange(j, string.length)];
            if ([temp isEqualToString:string]) {
                [attributedString addAttributes:attributes range:NSMakeRange(j, string.length)];
            }
        }
    }
    return attributedString;
}

- (NSAttributedString *)configAttributesWithFontSize:(NSInteger)fontSize forStringArray:(NSArray *)stringArray
{
    NSDictionary * attributes = @{NSFontAttributeName : kFont(fontSize)};
    return [self configAttributes:attributes forStringArray:stringArray];
}

- (NSAttributedString *)configAttributesArray:(NSArray *)attributesArray forStringArray:(NSArray *)stringArray
{
    if (attributesArray.count != stringArray.count) {
        return nil;
    }
    
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    for (int i = 0; i < stringArray.count; i++) {
        NSString * string = stringArray[i];
        NSDictionary * attributes = attributesArray[i];
        NSString * temp = nil;
        for(int j = 0; j < self.length; j++)
        {
            if (j + string.length > self.length) {
                break;
            }
            temp = [self substringWithRange:NSMakeRange(j, string.length)];
            if ([temp isEqualToString:string]) {
                [attributedString addAttributes:attributes range:NSMakeRange(j, string.length)];
            }
        }
    }
    return attributedString;
}

@end

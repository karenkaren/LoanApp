//
//  NSString+Attributes.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/25.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Attributes)

- (NSAttributedString *)configAttributes:(NSDictionary *)attributes forString:(NSString *)string;
- (NSAttributedString *)configAttributesWithFontSize:(NSInteger)fontSize forString:(NSString *)string;
- (NSAttributedString *)configAttributes:(NSDictionary *)attributes forStringArray:(NSArray *)stringArray;
- (NSAttributedString *)configAttributesWithFontSize:(NSInteger)fontSize forStringArray:(NSArray *)stringArray;
- (NSAttributedString *)configAttributesArray:(NSArray *)attributesArray forStringArray:(NSArray *)stringArray;

@end

//
//  BaseModel.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/26.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

MJExtensionLogAllProperties

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}

@end

//
//  CustomFont.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/10.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "CustomFont.h"

#define DeviceiPhone6plusWidth 375

@implementation CustomFont

+ (UIFont *)systemFontOfSize:(CGFloat)fontSize
{
    return [CustomFont heiti:fontSize];
}

+ (UIFont *)boldSystemFontOfSize:(CGFloat)fontSize
{
    return [CustomFont boldHeiti:fontSize];
}

- (UIFont *)fontWithSize:(CGFloat)fontSize
{
    if (kScreenWidth > DeviceiPhone6plusWidth) {
        return [super fontWithSize:fontSize + 2];
    }else {
        return [super fontWithSize:fontSize];
    }
}

+ (UIFont *)resetSystemFontOfSize:(float)fontSize
{
    return [CustomFont heiti:fontSize];
}

+ (UIFont *)resetBoldSystemFontOfSize:(float)fontSize
{
    return [CustomFont boldHeiti:fontSize];
}

//ios9系统字体为平方PingFangSC，ios9以下的字体为STHeitiSC 类似系统
+ (UIFont *)heiti:(CGFloat)fontSize {
    if (VERSION_9_0_LATER)
    {
        return [CustomFont fontWithName:@"PingFangSC-Light" size:fontSize];
    } else {
        return [CustomFont fontWithName:@"STHeitiSC-Light" size:fontSize];
    }
}

+ (UIFont *)boldHeiti:(CGFloat)fontSize {
    if (VERSION_9_0_LATER)
    {
        return [CustomFont fontWithName:@"PingFangSC-Medium" size:fontSize];
    } else {
        return [CustomFont fontWithName:@"STHeitiSC-Medium" size:fontSize];
    }
}

+ (UIFont *)heitiLightWithSize:(float)fontSize {
    return [self heiti:fontSize];
}

+ (UIFont *)boldHeitiWithSize:(CGFloat)fontSize {
    return [self boldHeiti:fontSize];
}

@end

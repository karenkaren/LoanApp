//
//  BaseDto.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/12/2.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseDto : NSObject

//请求结果代码
@property (nonatomic, assign) NSInteger code;
//请求结果信息
@property (nonatomic, copy) NSString * reason;
//请求结果
@property (nonatomic, strong) id data;

@end

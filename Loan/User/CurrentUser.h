//
//  CurrentUser.h
//  LingTouNiaoLoan
//
//  Created by LiuFeifei on 17/1/16.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

#import "BaseModel.h"

@interface CurrentUser : BaseModel

// 用户sessionKey
@property (nonatomic,copy) NSString *sessionKey;

// 单例
+ (instancetype)mine;
//是否登录
- (BOOL)hasLogged;
//退出登陆调用
- (void)reset;
// 登录成功
+ (void)loginSuccess:(NSString *)sessionKey;
// 上报位置
- (void)postLocation:(NSDictionary *)params block:(APIResultBlock)block;

@end

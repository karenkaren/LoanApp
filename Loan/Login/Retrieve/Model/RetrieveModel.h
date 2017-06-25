//
//  RetrieveModel.h
//  XiChe
//
//  Created by LiuFeifei on 2017/4/5.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

#import "BaseModel.h"

@interface RetrieveModel : BaseModel

// 找回密码验证
+ (void)doGetBackPasswordCheck:(NSDictionary *)params block:(APIResultBlock)block;
// 找回密码提交
+ (void)doGetBackPassword:(NSDictionary *)params block:(APIResultBlock)block;
// 找回密码发送短信验证码
+ (void)getBackPasswordOfSendMobileCode:(NSDictionary *)params block:(void (^)(id response, BOOL showIdentify, NSError *error))block;

@end

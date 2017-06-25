//
//  RegisterModel.h
//  XiChe
//
//  Created by LiuFeifei on 2017/4/5.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

#import "BaseModel.h"

@interface RegisterModel : BaseModel

// 注册
+ (void)doRegister:(NSDictionary *)params block:(APIResultDataBlock)block;
// 注册发送短信验证码
+ (void)registerOfSendMobileCode:(NSDictionary *)params block:(APIResultBlock)block;

@end

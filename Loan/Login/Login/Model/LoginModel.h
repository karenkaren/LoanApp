//
//  LoginModel.h
//  XiChe
//
//  Created by LiuFeifei on 2017/4/5.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

#import "BaseModel.h"

@interface LoginModel : BaseModel
// 登录
+ (void)doLogin:(NSDictionary *)params block:(APIResultDataBlock)block;
// 获取图片验证码
+ (void)getPictureCode:(NSDictionary *)params block:(void(^)(UIImage * image))block;
// 退出登录
+ (void)logout;

@end

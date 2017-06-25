//
//  RegisterModel.m
//  XiChe
//
//  Created by LiuFeifei on 2017/4/5.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

#import "RegisterModel.h"

@implementation RegisterModel

+ (void)doRegister:(NSDictionary *)params block:(APIResultDataBlock)block
{
    [[NetAPIManager sharedNetAPIManager] requestWithPath:kUserRegisterUrl params:params methodType:Post block:^(id response, NSError *error) {
        id data = nil;
        if (!error) {
            BaseDto * dto = [BaseDto mj_objectWithKeyValues:response];
            data = dto.data;
            [[NSUserDefaults standardUserDefaults] setValue:data[kSessionKey] forKey:kSessionKey];
            [[NSUserDefaults standardUserDefaults] setValue:params[kMobileNo] forKey:kMobileNo];
            [[NSUserDefaults standardUserDefaults] setValue:data[kUserId] forKey:kUserId];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [CurrentUser loginSuccess:data[kSessionKey]];
            
        }
        if (block) {
            block(response, data, error);
        }
    }];
}

+ (void)registerOfSendMobileCode:(NSDictionary *)params block:(APIResultBlock)block
{
    NSMutableDictionary * dictionaryM = [NSMutableDictionary dictionaryWithDictionary:params];
    [dictionaryM setValue:@1 forKey:@"sendType"];
    [[NetAPIManager sharedNetAPIManager] requestWithPath:kUserRegisterSendMobileCodeUrl params:dictionaryM methodType:Get block:^(id response, NSError *error) {
        if (block) {
            block(response, error);
        }
    }];
}

@end

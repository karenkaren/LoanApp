//
//  RetrieveModel.m
//  XiChe
//
//  Created by LiuFeifei on 2017/4/5.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

#import "RetrieveModel.h"

@implementation RetrieveModel

+ (void)doGetBackPasswordCheck:(NSDictionary *)params block:(APIResultBlock)block
{
    NSMutableDictionary * dictionaryM = [NSMutableDictionary dictionaryWithDictionary:params];
    [dictionaryM setValue:@2 forKey:@"sendType"];

    [[NetAPIManager sharedNetAPIManager] requestWithPath:kVerifyMobileCodeUrl params:dictionaryM methodType:Get block:^(id response, NSError *error) {
        if (block) {
            block(response, error);
        }
    }];
}

+ (void)doGetBackPassword:(NSDictionary *)params block:(APIResultBlock)block
{
    [[NetAPIManager sharedNetAPIManager] requestWithPath:kRetrievePasswordUrl params:params methodType:Post block:^(id response, NSError *error) {
        if (block) {
            block(response, error);
        }
    }];
}

+ (void)getBackPasswordOfSendMobileCode:(NSDictionary *)params block:(void (^)(id response, BOOL showIdentify, NSError *error))block
{
    NSMutableDictionary * dictionaryM = [NSMutableDictionary dictionaryWithDictionary:params];
    [dictionaryM setValue:@2 forKey:@"sendType"];
    [[NetAPIManager sharedNetAPIManager] requestWithPath:kGetBackPasswordSendMobileCodeUrl params:dictionaryM methodType:Get block:^(id response, NSError *error) {
        BOOL showIdentify = NO;
        if (!error) {
            BaseDto * dto = [BaseDto mj_objectWithKeyValues:response];
            if ([dto.data[@"certification"] integerValue]) {
                showIdentify = YES;
            }
        }
        if (block) {
            block(response, showIdentify, error);
        }
    }];
}

@end

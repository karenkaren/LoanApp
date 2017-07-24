//
//  SHBaseModel.m
//  Loan
//
//  Created by 王安帮 on 2017/7/18.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "SHBaseModel.h"

@implementation SHBaseModel

+ (void)userAuthWithParams:(NSDictionary *)params block:(APIResultBlock)block
{
    [[NetAPIManager sharedNetAPIManager] requestWithPath:kSHUserAuth params:params methodType:Get block:^(id response, NSError *error) {
        if (block) {
            block(response, error);
        }
    }];
}

+ (void)queryUserAuthStatusWithBlock:(APIResultDataBlock)block
{
    [[NetAPIManager sharedNetAPIManager] requestWithPath:kSHGetUserInfoStatus params:nil methodType:Get block:^(id response, NSError *error) {
        id data = nil;
        if (!error) {
            BaseDto * dto = [BaseDto mj_objectWithKeyValues:response];
            data = dto.data;
        }
        if (block) {
            block(response, data, error);
        }
    }];
}

+ (void)applySubmitWithBlock:(APIResultBlock)block
{
    [[NetAPIManager sharedNetAPIManager] requestWithPath:kSHUserApply params:nil methodType:Post block:^(id response, NSError *error) {
        if (block) {
            block(response, error);
        }
    }];
}

+ (void)updateUserInfoWithParams:(NSDictionary *)params block:(APIResultBlock)block
{
    [[NetAPIManager sharedNetAPIManager] requestWithPath:kSHUpdateUserInfo params:params methodType:Post block:^(id response, NSError *error) {
        if (block) {
            block(response, error);
        }
    }];
}

+ (void)getUserInfoWithBlock:(APIResultDataBlock)block
{
    [[NetAPIManager sharedNetAPIManager] requestWithPath:kSHGetUserInfo params:nil methodType:Get block:^(id response, NSError *error) {
        id data = nil;
        if (!error) {
            BaseDto * dto = [BaseDto mj_objectWithKeyValues:response];
            data = dto.data;
        }
        if (block) {
            block(response, data, error);
        }
    }];
}

+ (void)getApplyListWithBlock:(APIResultDataBlock)block
{
    [[NetAPIManager sharedNetAPIManager] requestWithPath:kSHGetApplyList params:nil methodType:Get block:^(id response, NSError *error) {
        id data = nil;
        if (!error) {
            BaseDto * dto = [BaseDto mj_objectWithKeyValues:response];
            data = dto.data;
            if (esString(data[@"submitDate"]).length) {
                [[NSUserDefaults standardUserDefaults] setValue:[esString(data[@"submitDate"]) componentsSeparatedByString:@" "].firstObject forKey:@"applyDate"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }
        if (block) {
            block(response, data, error);
        }
    }];
}

@end

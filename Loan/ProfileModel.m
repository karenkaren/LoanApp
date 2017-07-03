//
//  ProfileModel.m
//  Loan
//
//  Created by 王安帮 on 2017/7/3.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "ProfileModel.h"

@implementation ProfileModel

+ (void)getProfileInfoWithBlock:(APIResultDataBlock)block
{
    [[NetAPIManager sharedNetAPIManager] requestWithPath:kGetUserProfile params:nil methodType:Get block:^(id response, NSError *error) {
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

+ (void)updateProfileInfoWithParams:(NSDictionary *)params block:(APIResultBlock)block
{
    [[NetAPIManager sharedNetAPIManager] requestWithPath:kUpdateUserProfile params:params methodType:Post block:^(id response, NSError *error) {
        if (block) {
            block(response, error);
        }
    }];
}

@end

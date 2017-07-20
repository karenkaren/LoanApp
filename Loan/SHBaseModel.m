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
    [[NetAPIManager sharedNetAPIManager] requestWithPath:@"https://www.flashcredit.cn/api/v1/user/userAuth" params:params methodType:Get block:^(id response, NSError *error) {
        if (block) {
            block(response, error);
        }
    }];
}

+ (void)queryUserAuthStatusWithBlock:(APIResultDataBlock)block
{
    [[NetAPIManager sharedNetAPIManager] requestWithPath:@"https://www.flashcredit.cn/api/v1/user/account/userInfo" params:nil methodType:Get block:^(id response, NSError *error) {
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
    [[NetAPIManager sharedNetAPIManager] requestWithPath:@"https://www.flashcredit.cn/api/v1/user/apply" params:nil methodType:Post block:^(id response, NSError *error) {
        if (block) {
            block(response, error);
        }
    }];
}

@end

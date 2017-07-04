//
//  ProfileViewModel.m
//  Loan
//
//  Created by 王安帮 on 2017/7/1.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "ProfileViewModel.h"

@implementation ProfileViewModel

+ (NSArray *)getCellDataWithData:(NSDictionary *)data
{
    NSArray * cellData = @[@{kProfileTitle : @"姓名",
                             kProfileValue : esString(data[kProfileKeyOfName]),
                             kProfilePlaceholder : @"请输入您的姓名",
                             kProfileLimitCount : @100,
                             kProfileType : @(ProfileTypeInput),
                             kProfileKey : kProfileKeyOfName},
                           @{kProfileTitle : @"身份证号",
                             kProfileValue : esString(data[kProfileKeyOfIDCard]),
                             kProfilePlaceholder : @"请输入您的身份证号",
                             kProfileLimitCount : @18,
                             kProfileType : @(ProfileTypeInput),
                             kProfileKey : kProfileKeyOfIDCard},
                           @{kProfileTitle : @"文化程度",
                             kProfileValue : esString(data[kProfileKeyOfEdition]),
                             kProfilePlaceholder : @"请选择文化程度",
                             kProfileLimitCount : @20,
                             kProfileType : @(ProfileTypeSelect),
                             kProfileKey : kProfileKeyOfEdition},
                           @{kProfileTitle : @"职业",
                             kProfileValue : esString(data[kProfileKeyOfProfession]),
                             kProfilePlaceholder : @"请选择职业",
                             kProfileLimitCount : @50,
                             kProfileType : @(ProfileTypeSelect),
                             kProfileKey : kProfileKeyOfProfession},
                           @{kProfileTitle : @"收入范围",
                             kProfileValue : esString(data[kProfileKeyOfIncome]),
                             kProfilePlaceholder : @"请选择收入范围",
                             kProfileLimitCount : @20,
                             kProfileType : @(ProfileTypeSelect),
                             kProfileKey : kProfileKeyOfIncome},
                           @{kProfileTitle : @"银行信用卡",
                             kProfileValue : @(esBool(data[kProfileKeyOfCredit])),
                             kProfilePlaceholder : @"",
                             kProfileLimitCount : @100,
                             kProfileType : @(ProfileTypeSwitch),
                             kProfileKey : kProfileKeyOfCredit}];
    return cellData;
}

+ (void)getProfileInfoWithBlock:(void (^)(id, id, NSError *))block
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

+ (void)updateProfileInfoWithParams:(NSDictionary *)params block:(void (^)(id, id, NSError *))block
{
    [[NetAPIManager sharedNetAPIManager] requestWithPath:kUpdateUserProfile params:params methodType:Get block:^(id response, NSError *error) {
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

@end

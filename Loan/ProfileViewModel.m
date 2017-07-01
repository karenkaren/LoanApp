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
    NSArray * cellData = nil;
    if (isDictionary(data)) {
        cellData = @[@{kProfileTitle : @"姓名",
                       kProfileValue : data[kProfileKeyOfName],
                       kProfileLimitCount : @100,
                       kProfileCanEdit : @YES,
                       kProfileKey : kProfileKeyOfName,
                       kProfileDetail : @NO,
                       kProfileShowSwitch : @NO}];
    } else {
        cellData = @[@{kProfileTitle : @"姓名",
                       kProfilePlaceholder : @"请输入您的姓名",
                       kProfileLimitCount : @100,
                       kProfileCanEdit : @YES,
                       kProfileKey : kProfileKeyOfName,
                       kProfileDetail : @NO,
                       kProfileShowSwitch : @NO},
                     @{kProfileTitle : @"身份证号",
                       kProfilePlaceholder : @"请输入您的身份证号",
                       kProfileLimitCount : @18,
                       kProfileCanEdit : @NO,
                       kProfileKey : kProfileKeyOfIDCard,
                       kProfileDetail : @NO,
                       kProfileShowSwitch : @NO},
                     @{kProfileTitle : @"文化程度",
                       kProfilePlaceholder : @"请选择文化程度",
                       kProfileLimitCount : @20,
                       kProfileCanEdit : @NO,
                       kProfileKey : kProfileKeyOfEdition,
                       kProfileDetail : @YES,
                       kProfileShowSwitch : @NO},
                     @{kProfileTitle : @"职业",
                       kProfilePlaceholder : @"请选择职业",
                       kProfileLimitCount : @50,
                       kProfileCanEdit : @NO,
                       kProfileKey : kProfileKeyOfProfession,
                       kProfileDetail : @YES,
                       kProfileShowSwitch : @NO},
                     @{kProfileTitle : @"收入范围",
                       kProfilePlaceholder : @"请选择收入范围",
                       kProfileLimitCount : @20,
                       kProfileCanEdit : @NO,
                       kProfileKey : kProfileKeyOfIncome,
                       kProfileDetail : @YES,
                       kProfileShowSwitch : @NO},
                     @{kProfileTitle : @"银行信用卡",
                       kProfilePlaceholder : @"",
                       kProfileLimitCount : @100,
                       kProfileCanEdit : @YES,
                       kProfileKey : kProfileKeyOfCredit,
                       kProfileDetail : @YES,
                       kProfileShowSwitch : @YES}];
    }
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

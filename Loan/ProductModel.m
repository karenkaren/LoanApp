//
//  ProductModel.m
//  Loan
//
//  Created by 王安帮 on 2017/6/24.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "ProductModel.h"

@implementation ProductModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"desc" : @"description"};
}


//+ (void)getLoanListWithSortType:(LoanSortType)loanSortType params:(NSDictionary *)params block:(void (^)(id, NSArray *, NSInteger, NSError *))block
//{
//    
//}


/**
 获取贷款列表

 @param params 请求参数
 @param block 回调block
 */
+ (void)getLoanListWithParams:(NSDictionary *)params block:(void (^)(id response, NSArray * loanList, NSInteger totalCount, NSError * error))block
{
    [[NetAPIManager sharedNetAPIManager] requestWithPath:kLoanList params:params methodType:Get block:^(id response, NSError *error) {
        NSArray * loanList = nil;
        NSInteger totalCount = 0;
        if (!error) {
            BaseDto * dto = [BaseDto mj_objectWithKeyValues:response];
            loanList = [ProductModel mj_objectArrayWithKeyValuesArray:dto.data[@"cloanList"]];
            totalCount = [dto.data[@"totalCount"] integerValue];
        }
        if (block) {
            block(response, loanList, totalCount, nil);
        }
    }];
}


/**
 增加浏览记录

 @param product 浏览的产品
 @param block 回调block
 */
+ (void)addVisitRecordWithProduct:(ProductModel *)product block:(void (^)(id respons, NSError * error))block
{
    NSDictionary * params = @{@"operationType" : @"visit",
                              @"cloanNo" : esString(product.cloanNo)};
    [[NetAPIManager sharedNetAPIManager] requestWithPath:kAddVisitRecord params:params methodType:Post autoShowError:NO block:^(id response, NSError *error) {
        if (block) {
            block(response, error);
        }
    }];
}


/**
 增加申请记录

 @param product 申请的产品
 @param block 回调block
 */
+ (void)addApplyRecordWithProduct:(ProductModel *)product block:(void (^)(id respons, NSError * error))block
{
    NSDictionary * params = @{@"operationType" : @"apply",
                              @"cloanNo" : esString(product.cloanNo)};
    [[NetAPIManager sharedNetAPIManager] requestWithPath:kAddApplyRecord params:params methodType:Post autoShowError:NO block:^(id response, NSError *error) {
        if (block) {
            block(response, error);
        }
    }];
}


/**
 获取浏览/申请记录列表

 @param block 回调block
 */
+ (void)getRecordListWithType:(RecordListType)type params:(NSDictionary *)params block:(void (^)(id response, NSArray * recordList, NSInteger totalCount, NSError * error))block
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:params];
    if (type == RecordListTypeOfApply) {
        [dic setValue:@"apply" forKey:@"operationType"];
    } else {
        [dic setValue:@"visit" forKey:@"operationType"];
    }
    
    [[NetAPIManager sharedNetAPIManager] requestWithPath:kRecordList params:dic methodType:Get block:^(id response, NSError *error) {
        NSArray * recordList = nil;
        NSInteger totalCount = 0;
        if (!error) {
            BaseDto * dto = [BaseDto mj_objectWithKeyValues:response];
            recordList = [ProductModel mj_objectArrayWithKeyValuesArray:dto.data[@"cloanUserList"]];
            totalCount = [dto.data[@"totalCount"] integerValue];
        }
        if (block) {
            block(response, recordList, totalCount, nil);
        }
    }];
}

@end

//
//  ProductModel.m
//  Loan
//
//  Created by 王安帮 on 2017/6/24.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "ProductModel.h"

@implementation ProductModel

/*
 @property (nonatomic, copy) NSString * cloanName;//'贷款名字'
 @property (nonatomic, copy) NSString * cloanLogo;//'图标URL'
 @property (nonatomic, copy) NSString * desc;//待确认
 @property (nonatomic, assign) NSInteger applyCustomer;//''申请人数''
 @property (nonatomic, assign) double dayRate;//日利率
 */

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cloanName = [NSString stringWithFormat:@"现金白卡-第%d个", arc4random_uniform(100)];
        self.cloanLogo = @"logo";
        self.desc = [NSString stringWithFormat:@"%d分钟审批，最高可贷%d万元", arc4random_uniform(10) + 1, arc4random_uniform(100) + 1];
        self.applyCustomer = arc4random_uniform(10000000) + 1;
        self.dayRate = arc4random_uniform(100) / 100 + 0.01;
    }
    return self;
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
+ (void)getLoanListWithParams:(NSDictionary *)params block:(void (^)(id, NSArray *, NSInteger, NSError *))block
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
+ (void)addVisitRecordWithProduct:(ProductModel *)product block:(void (^)(id respons, NSError *))block
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
+ (void)addApplyRecordWithProduct:(ProductModel *)product block:(void (^)(id respons, NSError *))block
{
    NSDictionary * params = @{@"operationType" : @"apply",
                              @"cloanNo" : esString(product.cloanNo)};
    [[NetAPIManager sharedNetAPIManager] requestWithPath:kAddApplyRecord params:params methodType:Post autoShowError:NO block:^(id response, NSError *error) {
        if (block) {
            block(response, error);
        }
    }];
}

@end

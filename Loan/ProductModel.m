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

@end

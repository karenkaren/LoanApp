//
//  Banner.m
//  lingtouniao
//
//  Created by LiuFeifei on 15/12/14.
//  Copyright © 2015年 lingtouniao. All rights reserved.
//

#import "BannerModel.h"

@implementation BannerModel

+ (void)getBannerListWithBlock:(APIResultDataBlock)block {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"location":@1}];
    [[NetAPIManager sharedNetAPIManager] requestWithPath:kBannerList params:dic methodType:Get block:^(id response, NSError *error) {
        NSArray * data = nil;
        if (!error) {
            BaseDto * dto = [BaseDto mj_objectWithKeyValues:response];
            data = [BannerModel mj_objectArrayWithKeyValuesArray:dto.data[@"bannerList"]];
        }
        if (block) {
            block(response, data, error);
        }
    }];
}

@end

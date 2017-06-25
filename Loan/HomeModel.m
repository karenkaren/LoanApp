//
//  HomeModel.m
//  XiChe
//
//  Created by LiuFeifei on 2017/4/21.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

#import "HomeModel.h"
#import "PlatformModel.h"

@implementation HomeModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"platformList" : [PlatformModel class]};
}

+ (void)getHomeInfo:(NSDictionary *)params block:(APIResultDataBlock)block
{
    [[NetAPIManager sharedNetAPIManager] requestWithPath:kHomepageRecommend params:params methodType:Get block:^(id response, NSError *error) {
        id data = nil;
        if (!error) {
            BaseDto * dto = [BaseDto mj_objectWithKeyValues:response];
            data = [HomeModel mj_objectWithKeyValues:dto.data];
        }
        if (block) {
            block(response, data, error);
        }
    }];
}

@end

//
//  UserRetrieveController.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/28.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "BaseLoginController.h"

typedef NS_ENUM(NSUInteger, RetrieveType) {
    kRetrieveTypeOfRetrieve,
    kRetrieveTypeOfReset
};

@interface UserRetrieveController : BaseLoginController

- (instancetype)initWithRetrieveType:(RetrieveType)retrieveType;

@end

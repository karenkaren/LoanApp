//
//  ProfileModel.h
//  Loan
//
//  Created by 王安帮 on 2017/7/3.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "BaseModel.h"

@interface ProfileModel : BaseModel

/*
"createDate": "2017-06-27 19:08:19.0",
"hasCreditCard": 1,
"id": 1000005,
"userId": 12000168,
"userName": "李达1"
*/
@property (nonatomic, copy) NSString * createDate;
@property (nonatomic, assign) BOOL hasCreditCard;
@property (nonatomic, copy) NSString * userId;
@property (nonatomic, copy) NSString * userName;

+ (void)getProfileInfoWithBlock:(APIResultDataBlock)block;
+ (void)updateProfileInfoWithParams:(NSDictionary *)params block:(APIResultBlock)block;

@end

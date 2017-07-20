//
//  SHBaseModel.h
//  Loan
//
//  Created by 王安帮 on 2017/7/18.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "BaseModel.h"

@interface SHBaseModel : BaseModel

+ (void)userAuthWithParams:(NSDictionary *)params block:(APIResultBlock)block;
+ (void)queryUserAuthStatusWithBlock:(APIResultDataBlock)block;
+ (void)applySubmitWithBlock:(APIResultBlock)block;

@end

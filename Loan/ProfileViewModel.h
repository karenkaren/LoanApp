//
//  ProfileViewModel.h
//  Loan
//
//  Created by 王安帮 on 2017/7/1.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import <Foundation/Foundation.h>


#define kProfileTitle       @"title"
#define kProfilePlaceholder @"placeholder"
#define kProfileValue       @"value"
#define kProfileType        @"type"
#define kProfileKey         @"key"
#define kProfileLimitCount  @"limitCount"

// type
typedef enum : NSUInteger {
    ProfileTypeInput,
    ProfileTypeSelect,
    ProfileTypeSwitch
} ProfileType;

// key
#define kProfileKeyOfName @"userName"
#define kProfileKeyOfIDCard @"idCard"
#define kProfileKeyOfEdition @"edition"
#define kProfileKeyOfProfession @"profession"
#define kProfileKeyOfIncome @"income"
#define kProfileKeyOfCredit @"hasCreditCard"

@interface ProfileViewModel : NSObject

+ (NSArray *)getCellDataWithData:(NSDictionary *)data;
+ (void)getProfileInfoWithBlock:(void (^)(id response, id data, NSError * error))block;
+ (void)updateProfileInfoWithParams:(NSDictionary *)params block:(void (^)(id response, id data, NSError * error))block;

@end

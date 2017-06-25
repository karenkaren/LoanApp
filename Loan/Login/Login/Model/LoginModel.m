//
//  LoginModel.m
//  XiChe
//
//  Created by LiuFeifei on 2017/4/5.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

#import "LoginModel.h"
#import "UIDevice+Info.h"

@implementation LoginModel

+ (void)doLogin:(NSDictionary *)params block:(APIResultDataBlock)block
{
    [[NetAPIManager sharedNetAPIManager] requestWithPath:kUserLoginUrl params:params methodType:Post block:^(id response, NSError *error) {
        id data = nil;
        if (!error) {
            BaseDto * dto = [BaseDto mj_objectWithKeyValues:response];
            data = dto.data;
            [[NSUserDefaults standardUserDefaults] setValue:data[kSessionKey] forKey:kSessionKey];
            [[NSUserDefaults standardUserDefaults] setValue:params[kMobileNo] forKey:kMobileNo];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [CurrentUser loginSuccess:data[kSessionKey]];
        }
        if (block) {
            block(response, data, error);
        }
    }];
}

+ (void)getPictureCode:(NSDictionary *)params block:(void (^)(UIImage *))block
{
    [[NetAPIManager sharedNetAPIManager] requestWithPath:kGetPictureCaptchaUrl params:@{@"machineNo" : [UIDevice IDFA]} methodType:Get block:^(id response, NSError *error) {
        if (!error) {
            BaseDto * dto = [BaseDto mj_objectWithKeyValues:response];
            NSString * path = [API_BASE_URL stringByAppendingPathComponent:dto.data[@"pictureCode"]];
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:path]];
            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
                UIImage * image = [UIImage imageWithData:data];
                if (block) {
                    block(image);
                }
            }];
        }
    }];


}

// 退出登录
+ (void)logout
{
//    [[NetAPIManager sharedNetAPIManager] requestWithPath:kUserLogoutUrl params:nil methodType:Delete autoShowError:NO block:^(id response, NSError *error) {
//        
//    }];
    [[CurrentUser mine] reset];
}

@end

//
//  CurrentUser.m
//  LingTouNiaoLoan
//
//  Created by LiuFeifei on 17/1/16.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

#import "CurrentUser.h"

@implementation CurrentUser

static CurrentUser *_currentUser = nil;
+ (instancetype)mine
{
    if (nil == _currentUser) {
        _currentUser = [[CurrentUser alloc] initMine];
    }
    return _currentUser;
}

- (instancetype)initMine
{
    self = [super init];
    if (self) {
        NSString * sessionKey = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionKey];
        if([sessionKey isKindOfClass:[NSString class]] && ![sessionKey isEqualToString:@""]){
            self.sessionKey = sessionKey;
        }
    }
    return self;
}

- (NSString *)sessionKey
{
    if(!_sessionKey)
        return @"";
    return _sessionKey;
}

//是否登录
- (BOOL)hasLogged
{
    if([self.sessionKey isKindOfClass:[NSString class]] && ![self.sessionKey isEqualToString:@""]){
        return YES;
    }
    return NO;
}

//退出登陆调用
- (void)reset
{
    if (_currentUser) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kSessionKey];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kMobileNo];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserName];
        [[NSUserDefaults standardUserDefaults] synchronize];
        /* Clear cookies */
        [GlobalManager deleteAllHTTPCookies];
//        [NetDataCacheManager resetCache];
        _currentUser = nil;
        [[self class] mine];
    }
}

+ (void)loginSuccess:(NSString *)sessionKey
{
//    [NetDataCacheManager resetCache];
    [CurrentUser mine].sessionKey = sessionKey;
    [[NSUserDefaults standardUserDefaults] setObject:sessionKey forKey:kSessionKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification
                                                        object:nil
                                                      userInfo:nil];
}

// 上报位置
- (void)postLocation:(NSDictionary *)params block:(APIResultBlock)block
{
    [[NetAPIManager sharedNetAPIManager] requestWithPath:kUserLocationUrl params:params methodType:Get autoShowError:NO block:^(id response, NSError *error) {
        if (block) {
            block(response, error);
        }
    }];
}

//MJExtensionCodingImplementation
//- (void)save
//{
//    kWeakSelf
//    DispatchOnBackgroundQueue(^{
//        [NSThread sleepForTimeInterval:1.0f];
//        [[NSUserDefaults standardUserDefaults] setObject:weakSelf.sessionKey forKey:kSessionKey];
//    });
//}

@end

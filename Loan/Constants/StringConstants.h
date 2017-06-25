//
//  StringConstants.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/24.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringConstants : NSObject

#pragma mark - Notification
#pragma mark 用户登录状态
extern NSString * const kLoginSuccessNotification;
extern NSString * const kLogoutSuccessNotification;

#pragma mark - UserDefault
#pragma mark 存储在 defaults中 的 网络接口地址
extern NSString * const kDefaults_NetAddress;
extern NSString * const kDefaults_POST_ADDR;
extern NSString * const kDefaults_WEB_ADDR;
extern NSString * const kServerAPIErrorDomain;

#pragma mark - Common
extern NSString * const kSessionKey;
extern NSString * const kUserName;
extern NSString * const kMobileNo;
extern NSString * const kUserId;
extern NSString * const kClientId;

extern NSString * const kSessionKeyTimeOut;

extern NSString * const kEnterBackgroundDate;

@end

//
//  GlobalManager.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/31.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AppDelegate;

@interface GlobalManager : NSObject

+ (AppDelegate *)appDelegate;
+ (UIViewController *)appRootViewController;
+ (UIWindow *)mainWindow;
+ (UIWindow *)keyWindow;

/**
 *  app版本号
 */
+ (NSString *)appVersion;
/**
 *  app build号
 */
+ (NSString *)buildVersion;
/**
 *  app名称
 */
+ (NSString *)displayName;
/**
 *  appstore下载链接
 */
+ (NSString *)appDownloadUrl;
/**
 *  apple ID
 */
+ (NSString *)appleID;

#pragma mark - 是否为第一次加载
+ (BOOL)isFreshLaunch;
#pragma mark - 初始设置
+ (void)globleSetting;
#pragma mark - 清空cookies
+ (void)deleteAllHTTPCookies;

@end

//
//  GlobalManager.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/31.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "GlobalManager.h"
#import "AppDelegate.h"
#import "SocialConstants.h"
#import <UMSocialCore/UMSocialCore.h>
#import "UMSocialWechatHandler.h"
//#import "UMSocialQQHandler.h"
//#import "UMSocialSinaSSOHandler.h"

@implementation GlobalManager

#pragma mark - 初始设置
+ (void)globleSetting
{
    // 键盘
    [self initIQKeyboardManager];
    // 显示
    [self initializeGlobleApprence];
    // 分享
    [self shareSetting];
    // 推送
}

// 友盟分享设置
+ (void)shareSetting
{
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMENG_APP_KEY];
    
    [GlobalManager configUSharePlatforms];
    
    [GlobalManager confitUShareSettings];
}

+ (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}

+ (void)configUSharePlatforms
{
    /*
     设置微信的appKey和appSecret
     [微信平台从U-Share 4/5升级说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_1
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WECHAT_APP_KEY appSecret:WECHAT_APP_SECRET redirectURL:nil];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     100424468.no permission of union id
     [QQ/QZone平台集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_3
     */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQ_APP_ID/*设置QQ平台的appID*/  appSecret:nil redirectURL:defaultUrlForShare];
    
//    /*
//     设置新浪的appKey和appSecret
//     [新浪微博集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_2
//     */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
//    
//    /* 钉钉的appKey */
//    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_DingDing appKey:@"dingoalmlnohc0wggfedpk" appSecret:nil redirectURL:nil];
//    
//    /* 支付宝的appKey */
//    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_AlipaySession appKey:@"2015111700822536" appSecret:nil redirectURL:nil];
//    
//    
//    /* 设置易信的appKey */
//    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_YixinSession appKey:@"yx35664bdff4db42c2b7be1e29390c1a06" appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
//    
//    /* 设置点点虫（原来往）的appKey和appSecret */
//    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_LaiWangSession appKey:@"8112117817424282305" appSecret:@"9996ed5039e641658de7b83345fee6c9" redirectURL:@"http://mobile.umeng.com/social"];
//    
//    /* 设置领英的appKey和appSecret */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Linkedin appKey:@"81t5eiem37d2sc"  appSecret:@"7dgUXPLH8kA8WHMV" redirectURL:@"https://api.linkedin.com/v1/people"];
//    
//    /* 设置Twitter的appKey和appSecret */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Twitter appKey:@"fB5tvRpna1CKK97xZUslbxiet"  appSecret:@"YcbSvseLIwZ4hZg9YmgJPP5uWzd4zr6BpBKGZhf07zzh3oj62K" redirectURL:nil];
//    
//    /* 设置Facebook的appKey和UrlString */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Facebook appKey:@"506027402887373"  appSecret:nil redirectURL:nil];
//    
//    /* 设置Pinterest的appKey */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Pinterest appKey:@"4864546872699668063"  appSecret:nil redirectURL:nil];
//    
//    /* dropbox的appKey */
//    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_DropBox appKey:@"k4pn9gdwygpy4av" appSecret:@"td28zkbyb9p49xu" redirectURL:@"https://mobile.umeng.com/social"];
//    
//    /* vk的appkey */
//    [[UMSocialManager defaultManager]  setPlaform:UMSocialPlatformType_VKontakte appKey:@"5786123" appSecret:nil redirectURL:nil];
//    
}


#pragma mark -- 全局显示
+ (void)initializeGlobleApprence
{
    // tab bar
    [[UITabBar appearance] setTintColor:kColor333333];
    [[UITabBar appearance] setBackgroundColor:kWhiteColor];
    
    //navigation bar
    NSDictionary * attributes = [NSDictionary dictionaryWithObjectsAndKeys:[CustomFont boldHeiti:18], NSFontAttributeName, kColor333333,NSForegroundColorAttributeName, nil];
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
    [[UINavigationBar appearance] setBarTintColor:kWhiteColor];
    
    // text field
    [UITextField appearance].tintColor = kTextColor;
}

#pragma mark -- 键盘设置
+ (void)initIQKeyboardManager{
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside     = YES;
    [IQKeyboardManager sharedManager].shouldShowTextFieldPlaceholder = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar              = NO;
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField  = 80;
    [[IQKeyboardManager sharedManager] setEnable:YES];
}

#pragma mark - app 相关
+ (AppDelegate *)appDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

+ (UIWindow *)mainWindow
{
    return [[self appDelegate] window];
}

+ (UIWindow *)keyWindow
{
    return [UIApplication sharedApplication].keyWindow;
}

+ (UIViewController *)appRootViewController
{
    return [[self mainWindow] rootViewController];
}

+ (NSString *)appVersion
{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return version;
}

+ (NSString *)buildVersion
{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    return version;
}

+ (NSString *)displayName
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
}

+ (NSString *)appDownloadUrl
{
    return @"https://itunes.apple.com/cn/app/hua-wu-you/id1219176656";
}

+ (NSString *)appleID
{
    return @"1219176656";
}

#define kCheckFreshLaunchAppVersion @"CheckFreshLaunchAppVersion"
+ (BOOL)isFreshLaunch
{
    static NSString *__previousVersion = nil;
    static BOOL __isFreshLaunch = NO;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __previousVersion = [[NSUserDefaults standardUserDefaults] objectForKey:kCheckFreshLaunchAppVersion];
        NSString *current = [GlobalManager appVersion];
        if (__previousVersion && [__previousVersion compare:current] == NSOrderedSame) {
            __isFreshLaunch = NO;
        } else {
            __isFreshLaunch = YES;
            [[NSUserDefaults standardUserDefaults] setObject:current forKey:kCheckFreshLaunchAppVersion];
        }
    });
    return __isFreshLaunch;
}

+ (void)deleteAllHTTPCookies
{
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *c in cookieStorage.cookies) {
        [cookieStorage deleteCookie:c];
    }
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

@end

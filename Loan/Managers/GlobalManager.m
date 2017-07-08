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
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
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
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:UMENG_APP_KEY];
    
    //打开调试log的开关
    [UMSocialData openLog:YES];
    
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:WECHAT_APP_ID appSecret:WECHAT_APP_SECRET url:defaultUrlForShare];
    
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialQQHandler setQQWithAppId:QQ_APP_ID appKey:QQ_APP_KEY url:defaultUrlForShare];
    //设置支持没有客户端情况下使用SSO授权
    [UMSocialQQHandler setSupportWebView:YES];
    
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
//    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:SINA_APP_KEY secret:SINA_APP_SECRET RedirectURL:SINA_APP_REDIRECT_URL];
    
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToSina, UMShareToWechatSession, UMShareToWechatTimeline]];
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

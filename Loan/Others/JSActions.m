//
//  JSActions.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/28.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "JSActions.h"
#import "UIAlertView+Block.h"
#import "ImagesManager.h"

@interface JSActions()

@property (nonatomic, strong) NSDictionary * params;

@end

@implementation JSActions

#pragma mark - 页面跳转
- (id)goPageIos:(NSDictionary *)dic
{
    self.params = dic;
    DispatchAsyncOnMainThread(^{
        NSString * pageName = esString(dic[@"type"]);
        if ([pageName isEqualToString:@"login"]) {
            [self gotoLoginController];
        } else if ([pageName isEqualToString:@"registered"]) {
            [self gotoRegisterController];
        } else if ([pageName isEqualToString:@"realName"]) {
            [self gotoRealNameController];
        } else if ([pageName isEqualToString:@"about"]) {
            [self gotoAboutController];
            //[self uploadImgIos];
        } else if ([pageName isEqualToString:@"feedback"]) {
            [self gotoFeedbackController];
        } else if ([pageName isEqualToString:@"editPassword"]) {
            [self gotoEditPasswordController];
        }
    });
    return nil;
}

- (void)gotoEditPasswordController
{
    [[ControllersManager sharedControllersManager] resetPassword];
}

- (void)gotoFeedbackController
{
//    [[ControllersManager sharedControllersManager] feedbackController:^{
//        [self refreshWebView:NO];
//    }];
}

- (void)gotoAboutController
{
//    [[ControllersManager sharedControllersManager] aboutUsController:^{
//        [self refreshWebView:NO];
//    }];
}

- (void)gotoLoginController
{
    [[ControllersManager sharedControllersManager] loginController:^{
        [self refreshWebView:YES];
    }];
}

- (void)gotoRegisterController
{
    [[ControllersManager sharedControllersManager] registerController:^{
        [self refreshWebView:YES];
    }];
}

- (void)gotoRealNameController
{
}

- (void)refreshWebView:(BOOL)refresh
{
    [self.baseViewController.navigationController popToViewController:self.baseViewController animated:YES];
    
    NSString * url = esString(self.params[@"url"]);
    if ([url isEqualToString:@""]) {
        if (refresh) {
            [self.webView reload];
        }
    } else {
        JSContext * context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        NSString * callbackJS = @"myCallback(url)"; //准备执行的js代码
        [context evaluateScript:callbackJS];//通过oc方法调用js的callback方法
        [context[@"setTimeout"] callWithArguments:@[context[@"myCallback"], @0, url]];
    }
}

#pragma mark - sessionKey
- (NSString *)getSessionKeyIos
{
    DLog(@"session key:%@", [[CurrentUser mine] sessionKey]);
    return [[CurrentUser mine] sessionKey];
}

#pragma mark - 弹框
- (id)alertIos:(NSDictionary *)dic
{
    if ([dic[@"type"] integerValue] == 1) {
        DispatchSyncOnMainThread(^{
            [NSObject showHudTipStr:esString(dic[@"content"])];
        });
    } else if ([dic[@"type"] integerValue] == 2) {
        NSString * content = esString(dic[@"content"]);
        NSString * title = esString(dic[@"title"]);
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:title message:content delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    return nil;
}

#pragma mark - 打电话
- (id)telPhoneIos:(NSDictionary *)dic
{
    DLog(@"拨打电话");
    NSString * telphoneNo = esString(dic[@"phone"]);
    if (telphoneNo.length) {
        NSString * url =[NSString stringWithFormat:@"telprompt://%@",telphoneNo];//这种方式会提示用户确认是否拨打电话
        [self openUrl:url];
    }
    return nil;
}

- (void)openUrl:(NSString *)urlStr
{
    //注意url中包含协议名称，iOS根据协议确定调用哪个应用，例如发送邮件是“sms://”其中“//”可以省略写成“sms:”(其他协议也是如此)
    NSURL *url = [NSURL URLWithString:urlStr];
    UIApplication * application = [UIApplication sharedApplication];
    if(![application canOpenURL:url]){
        DLog(@"无法打开\"%@\"，请确保此应用已经正确安装.",url);
        return;
    }
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 10) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:url];
    }
}

#pragma mark - 退出
- (id)logoutIos
{
    [[ControllersManager sharedControllersManager] logout];
    return nil;
}

#pragma mark - sessionKey 过期
- (id)sessionKeyTimeOutIos:(NSDictionary *)dic
{
    DLog(@"js调用方法，会话过期");
    self.params = dic;
    [[ControllersManager sharedControllersManager] sessionKeyTimeOut:^{
        [self refreshWebView:YES];
    }];
    return nil;
}

#pragma mark - 上传图片
- (id)uploadImgIos
{
    [ImagesManager uploadImageInController:self.baseViewController block:^(id sender) {
        if (isDictionary(sender) && ![esString(sender[@"filePath"]) isEqualToString:@""]) {
            JSContext * context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
            NSString * callbackJS = @"uploadCallback(url)"; //准备执行的js代码
            [context evaluateScript:callbackJS];//通过oc方法调用js的callback方法
            [context[@"setTimeout"] callWithArguments:@[context[@"uploadCallback"], @0, esString(sender[@"filePath"])]];
        }
    }];
    return nil;
}

@end

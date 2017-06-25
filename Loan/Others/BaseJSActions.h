//
//  BaseJSActions.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/18.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface BaseJSActions : NSObject

@property (nonatomic, strong) UIWebView * webView;
@property (nonatomic, strong) UIViewController * baseViewController;

#pragma mark - 公开方法
// 始化参数
- (instancetype)initWithWebView:(UIWebView *)webView baseViewController:(UIViewController *)baseViewController;
//// 获取h5传过来的参数
//- (NSDictionary *)getParamsWithDictionary:(NSDictionary *)dictionary;
//// 获取h5的回调方法
//- (NSString *)getCallbackWithDictionary:(NSDictionary *)dictionary;
//// 执行回调方法
//- (void)excuteCallback:(NSString *)callback params:(NSDictionary *)params completionHandler:(ErrorBlock)handler;

@end

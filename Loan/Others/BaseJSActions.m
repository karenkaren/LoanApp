//
//  BaseJSActions.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/18.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "BaseJSActions.h"

@implementation BaseJSActions

- (instancetype)initWithWebView:(UIWebView *)webView baseViewController:(UIViewController *)baseViewController
{
    self = [super init];
    if(self) {
        self.webView = webView;
        self.baseViewController = baseViewController;
    }
    return self;
}

//- (NSDictionary *)getParamsWithDictionary:(NSDictionary *)dictionary
//{
//    NSDictionary * params = nil;
//    if (isDictionary(dictionary) && dictionary.count) {
//        params = dictionary[@"params"];
//        if (isDictionary(params)) {
//            return params;
//        } else {
//            return nil;
//        }
//    }
//    return params;
//}
//
//- (NSString *)getCallbackWithDictionary:(NSDictionary *)dictionary
//{
//    NSString * callback = nil;
//    if (isDictionary(dictionary) && dictionary.count) {
//        callback = esString(dictionary[@"callback"]);
//    }
//    return callback;
//}
//
//- (void)excuteCallback:(NSString *)callback params:(NSDictionary *)params completionHandler:(ErrorBlock)handler
//{
//    if (callback && ![callback isEqualToString:@""]) {
//        if (params == nil) {
//            params = @{};
//        }
//        NSData * data = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];
//        NSString * paramsString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        [self.webView evaluateJavaScript:[NSString stringWithFormat:@"%@('%@')", callback, paramsString] completionHandler:^(id _Nullable javaScriptString, NSError * _Nullable error) {
//            handler(error);
//        }];
//    }
//}

@end

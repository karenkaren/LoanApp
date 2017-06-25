//
//  BaseWebViewController.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/28.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseWebViewController : BaseViewController

@property (nonatomic, strong) UIWebView * webView;
@property (nonatomic, strong) NSURLRequest * request;
@property (nonatomic, assign) BOOL showNavigation;

- (id)initWithURL:(NSString *)urlString;
- (id)initWithRequest:(NSURLRequest *)request;

- (void)alertError:(NSError *)error;

@end


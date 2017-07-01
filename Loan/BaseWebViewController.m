//
//  BaseWebViewController.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/28.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "BaseWebViewController.h"
#import "JSActions.h"

@interface BaseWebViewController ()<UIAlertViewDelegate, UIWebViewDelegate>

@property (nonatomic, strong) JSActions * jsActions;

@property (nonatomic,strong) JSContext * context;

@end

@implementation BaseWebViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:self.hideNavigation animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view addSubview:self.webView];
    [self registerHandlers];
    
    self.jsActions = [[JSActions alloc] initWithWebView:self.webView baseViewController:self];
    
    NSURL * url = self.request.URL;
    if (url.absoluteString.length > 0) {
        [self.webView loadRequest:self.request];
        [self showWaitingIcon];
    } else {
        if (self.title.length == 0) {
            self.navigationItem.title = @"地址为空";
        }
    }
}

#pragma mark - init
- (id)initWithURL:(NSString *)urlString{
    
    NSURL *url = [NSURL URLWithString:urlString];
    if (![url host]) {
        urlString = [NSString stringWithFormat:@"%@%@", WEB_BASE_URL, urlString];
        url = [NSURL URLWithString:urlString];
    }
    self = [self initWithRequest:[NSURLRequest requestWithURL:url]];
    if (self) {
        
    }
    return self;
}

- (id)initWithRequest:(NSURLRequest *)request{
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        self.request = request;
    }
    return self;
}

#pragma mark - back
- (void)back
{
    if (self.webView.canGoBack) {
        [self.webView goBack];
    } else {
        [super back];
    }
}

#pragma mark - Private methods
- (void)registerHandlers
{
    self.context = [_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    NSArray * actions = [NSObject getAllMethodsFromClass:[JSActions class]];
    for (NSString * actionString in actions) {
        NSString * registerActionString = [actionString componentsSeparatedByString:@":"].firstObject;
        kWeakSelf
        self.context[registerActionString] = ^(id msg){
            
            kStrongSelf
            id callbackData = nil;
            SEL action = NSSelectorFromString(actionString);
            if (strongSelf && [strongSelf.jsActions respondsToSelector:action]) {
                callbackData = [strongSelf.jsActions performSelector:action withObject:msg];
            }
            return callbackData;
        };
    }
}

- (void)alertError:(NSError *)error{
    
    if([error code] == NSURLErrorCancelled) {
        return;
    }
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"加载失败" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重试", nil];
    [alertView show];
}

#pragma mark - UIWebView Delegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
//    [self showWaitingIcon];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self dismissWaitingIcon];
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if ([title length]) {
        self.navigationItem.title = title;
    }
    [self registerHandlers];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self dismissWaitingIcon];
    [self alertError:error];
}

#pragma mark - alert delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if (self.navigationController.childViewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        if (self.presentingViewController) {
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
    } else {
        [self.webView loadRequest:self.request];
    }
}

#pragma mark - Property Accessor
- (void)setRequest:(NSURLRequest *)request{
    if (_request == request) {
        return;
    }
    _request = [request copy];
}

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height - 20)];
        _webView.scrollView.bounces = NO;
        _webView.backgroundColor = [UIColor clearColor];
        _webView.delegate = self;
        _webView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.context = [_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//        if (!self.hideNavigation) {
//            _webView.y = 0;
//            _webView.height = self.view.bounds.size.height;
//        }
    }
    return _webView;
}

@end

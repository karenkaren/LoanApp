//
//  BaseViewController+NetworkTips.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/25.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "UIViewController+NetworkTips.h"
#import "NetFailView.h"
#import <objc/runtime.h>

#define WAITING_ICON_SIZE 60

@interface UIViewController ()

@property (nonatomic, strong) NetFailView * netFailView;

@end

@implementation UIViewController (NetworkTips)

// TODO:
NSString * locationString(NSString *key)
{
    return key;
}

#pragma mark - 加载视图
// todo: 待细化
- (void)showLoadingView {
    UIView * loadingView = [self loadingView];
    if (loadingView) {
        [self showNetFailViewWithCustomView:loadingView animated:NO];
    }else{
        UIImage * iconImage = [self iconImageWhenLoading];
        NSString * tipsMessage = [self tipsMessageWhenLoading];
        NSString * tipsSubMessage = [self tipsSubMessageWhenLoading];
        [self showNetFailViewWithMessage:tipsMessage subMessage:tipsSubMessage iconImage:iconImage];
    }
    self.netFailView.tapGesture.enabled = NO;
}

#pragma mark - 等待视图
- (void)showWaitingIcon
{
    [NSObject showWaitingIconInView:self.view];
}

- (void)dismissWaitingIcon
{
    [NSObject dismissWaitingIconInView:self.view];
}

#pragma mark - 点击出错或空数据视图
- (void)touchNetFailView:(UIView *)view
{
    [self showLoadingView];
}

#pragma mark - 错误或空数据时的view尺寸
- (CGRect)boundsForErrorOrEmptyView{
    return self.view.bounds;
}

#pragma mark - 出错时各种提示信息
//#pragma mark -- 出错时的图标
- (UIImage *)iconImageWhenError:(NSError *)error{
    return [UIImage imageNamed:@"net_error"];
}

//#pragma mark -- 出错时的提示信息
- (NSString *)tipsMessageWhenError:(NSError *)error{
    return locationString(@"net_empty_title");
}

//#pragma mark -- 出错时的子提示信息
- (NSString *)tipsSubMessageWhenError:(NSError *)error{
    return locationString(@"click_screen_reload");
}

#pragma mark - 数据为空时各种提示信息
//#pragma mark -- 数据为空时的图标
- (UIImage *)iconImageWhenDataEmpty{
    return [UIImage imageNamed:@"viewcontroller_data_empty"];
}

//#pragma mark -- 数据为空时的提示信息
- (NSString *)tipsMessageWhenDataEmpty {
    return locationString(@"empty_data");
}

//#pragma mark -- 数据为空时的子提示信息
- (NSString *)tipsSubMessageWhenDataEmpty {
    return locationString(@"empty_data");
}

#pragma mark - 加载时各种提示信息
//#pragma mark -- 正在加载时的图标
- (UIImage *)iconImageWhenLoading {
    return [UIImage sd_animatedGIFNamed:@"loading"];
}

- (NSString *)tipsMessageWhenLoading{
    return @"努力加载中...";
}

//#pragma mark -- 正在加载时的子提示信息
- (NSString *)tipsSubMessageWhenLoading{
    return nil;
}

#pragma mark - 视图相关
//#pragma mark -- 提示view的背景颜色
- (UIColor *)tipsViewBackgroundColor{
    return self.view.backgroundColor;
}

//#pragma mark -- 空视图
- (UIView *)emptyView{
    return nil;
}

//#pragma mark -- 出错视图
- (UIView *)errorViewWhenError:(NSError *)error{
    return nil;
}

//#pragma mark -- 正在加载视图
- (UIView *)loadingView{
    return nil;
}

#pragma mark - 显示出错视图
- (void)showErrorView{
    [self showErrorViewWithError:nil];
}

//#pragma mark -- 显示出错视图
- (void)showErrorViewWithError:(NSError *)error{
    UIView * errorView = [self errorViewWhenError:error];
    if (errorView) {
        [self showNetFailViewWithCustomView:errorView animated:NO];
    } else {
        UIImage * iconImage = [self iconImageWhenError:error];
        NSString * tipsMessage = [self tipsMessageWhenError:error];
        NSString * tipsSubMessage = [self tipsSubMessageWhenError:error];
        [self showNetFailViewWithMessage:tipsMessage subMessage:tipsSubMessage iconImage:iconImage];
    }
}

//#pragma mark -- 显示带有自定义提示信息和默认图标的出错视图
- (void)showErrorViewWithMessage:(NSString *)message {
    [self showErrorViewWithMessage:message iconImage:[self iconImageWhenError:nil]];
}

//#pragma mark -- 显示带有自定义提示信息和自定义图标名称的出错视图
- (void)showErrorViewWithMessage:(NSString *)message iconImageName:(NSString *)imageName{
    [self showErrorViewWithMessage:message iconImage:[UIImage imageNamed:imageName]];
}

//#pragma mark -- 显示带有自定义提示信息和自定义图标的出错视图
- (void)showErrorViewWithMessage:(NSString*)message iconImage:(UIImage *)image{
    [self showNetFailViewWithMessage:message iconImage:image frame:[self boundsForErrorOrEmptyView] animated:NO];
}

//#pragma mark -- 自定义尺寸显示带有图标和提示信息的出错视图
- (void)showErrorViewWithMessage:(NSString *)message iconImageName:(NSString *)imageName frame:(CGRect)frame{
    [self showNetFailViewWithMessage:message iconImage:[UIImage imageNamed:imageName] frame:frame animated:NO];
}

//#pragma mark -- 显示自定义出错视图
- (void)showErrorViewWithCustomView:(UIView *)customView frame:(CGRect)frame{
    [self showNetFailViewWithCustomView:customView frame:frame animated:NO];
}

#pragma mark - 空数据视图
//#pragma mark -- 显示空数据视图
- (void)showDataEmptyView {
    UIView *emptyView = [self emptyView];
    if (emptyView) {
        [self showNetFailViewWithCustomView:emptyView animated:NO];
    }else{
        UIImage * iconImage = [self iconImageWhenDataEmpty];
        NSString * tipsMessage = [self tipsMessageWhenDataEmpty];
        NSString * tipsSubMessage = [self tipsSubMessageWhenDataEmpty];
        [self showNetFailViewWithMessage:tipsMessage subMessage:tipsSubMessage iconImage:iconImage];
    }
}

//#pragma mark -- 显示带有图标的空数据视图
- (void)showDataEmptyViewWithMessage:(NSString *)message iconImageName:(NSString *)imageName{
    [self showDataEmptyViewWithMessage:message iconImage:[UIImage imageNamed:imageName]];
}

//#pragma mark -- 显示带有提示信息的空数据视图
- (void)showDataEmptyViewWithMessage:(NSString*)message {
    [self showDataEmptyViewWithMessage:message iconImage:[self iconImageWhenDataEmpty]];
}

//#pragma mark -- 显示带有提示信息和图标的空数据视图
- (void)showDataEmptyViewWithMessage:(NSString*)message iconImage:(UIImage *)image{
    [self showNetFailViewWithMessage:message iconImage:image frame:[self boundsForErrorOrEmptyView] animated:NO];
}

//#pragma mark -- 自定义尺寸显示带有提示信息和图标的空数据视图
- (void)showDataEmptyViewWithMessage:(NSString *)message iconImageName:(NSString *)imageName frame:(CGRect)frame{
    [self showNetFailViewWithMessage:message iconImage:[UIImage imageNamed:imageName] frame:frame animated:NO];
}

//#pragma mark -- 显示带有图标，提示、子提示信息的网络失败视图
- (void)showNetFailViewWithMessage:(NSString *)message subMessage:(NSString *)subMessage iconImageName:(NSString *)imageName{
    [self showNetFailViewWithMessage:message subMessage:subMessage iconImageName:imageName frame:[self boundsForErrorOrEmptyView]];
}

//#pragma mark -- 自定义尺寸显示带有图标，提示、子提示信息的网络失败视图
- (void)showNetFailViewWithMessage:(NSString *)message subMessage:(NSString *)subMessage iconImageName:(NSString *)imageName frame:(CGRect)frame{
    [self showNetFailViewWithMessage:message subMessage:subMessage iconImage:[UIImage imageNamed:imageName] frame:frame animated:NO];
}

//#pragma mark -- 显示带有图标，提示、子提示信息的网络失败视图
-(void)showNetFailViewWithMessage:(NSString *)message subMessage:(NSString *)subMessage iconImage:(UIImage *)image{
    [self showNetFailViewWithMessage:message subMessage:subMessage iconImage:image frame:[self boundsForErrorOrEmptyView] animated:NO];
}

//#pragma mark -- 显示带有图标，提示、子提示信息的网络失败视图
- (void)showNetFailViewWithMessage:(NSString *)message iconImage:(UIImage *)image frame:(CGRect)frame animated:(BOOL)animated
{
    [self showNetFailViewWithMessage:message subMessage:nil iconImage:image frame:frame animated:NO];
}

//#pragma mark -- 显示自定义网络失败视图
- (void)showNetFailViewWithCustomView:(UIView *)customView animated:(BOOL)animated{
    [self showNetFailViewWithCustomView:customView frame:[self boundsForErrorOrEmptyView] animated:animated];
}

#pragma mark - 最终调用方法
//#pragma mark -- 自定义尺寸、动画，显示带有图标，提示、子提示信息的网络失败视图(最终调用方法)
-(void)showNetFailViewWithMessage:(NSString *)message subMessage:(NSString *)subMessage iconImage:(UIImage *)image frame:(CGRect)frame animated:(BOOL)animated
{
    if (!self.netFailView)
    {
        self.netFailView = [[NetFailView alloc] initWithFrame:frame];
        kWeakSelf
        self.netFailView.touchNetFailView = ^(UIView *view){
            [weakSelf touchNetFailView:view];
        };
    }
    self.netFailView.frame = frame;
    [self.netFailView setMessage:message];
    [self.netFailView setSubMessage:subMessage];
    [self.netFailView setIconImage:image];
    [self showNetFailViewAnimated:animated];
}

//#pragma mark -- 自定义尺寸显示自定义网络失败视图(最终调用方法)
- (void)showNetFailViewWithCustomView:(UIView *)customView frame:(CGRect)frame animated:(BOOL)animated {
    if (!self.netFailView)
    {
        self.netFailView = [[NetFailView alloc] initWithFrame:frame];
        kWeakSelf
        self.netFailView.touchNetFailView = ^(UIView *view){
            [weakSelf touchNetFailView:view];
        };
    }
    [self.netFailView setCustomView:customView];
    [self showNetFailViewAnimated:animated];
}

#pragma mark -- 是否动画显示网络失败视图
- (void)showNetFailViewAnimated:(BOOL)animated{
    
    if (self.netFailView.superview != self.view) {
        [self.view addSubview:self.netFailView];
    }
    // set backgroundColor
    UIColor *backgroundColor = [self tipsViewBackgroundColor];
    if (backgroundColor == nil) {
        backgroundColor = [UIColor clearColor];
    }
    self.netFailView.backgroundColor = backgroundColor;
    
    // bring to front
    self.netFailView.hidden = YES;
    [self.view bringSubviewToFront:self.netFailView];
    
    [self willShowErrorEmptyDataTipsView:self.netFailView animated:animated];
    
    if (animated) {
        self.netFailView.hidden = NO;
        self.netFailView.alpha = 0.0f;
        kWeakSelf
        [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^(){
            weakSelf.netFailView.alpha = 1.0f;
        } completion:^(BOOL finished){
            [weakSelf didShowErrorEmptyDataTipsView:weakSelf.netFailView animated:animated];
        }];
    }else{
        self.netFailView.hidden = NO;
        self.netFailView.alpha = 1.0f;
        [self didShowErrorEmptyDataTipsView:self.netFailView animated:animated];
    }
}

#pragma mark -- 隐藏网络失败视图
-(void)dismissNetFailView
{
    [self dismissNetFailViewAnimated:NO];
}

- (void)dismissNetFailViewAnimated:(BOOL)animated{
//    self.netFailView.tapGesture.enabled = YES;
    [self willDismissErrorEmptyDataTipsView:self.netFailView animated:animated];
    if (animated) {
        kWeakSelf
        [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^(){
            weakSelf.netFailView.alpha = 0.0f;
        } completion:^(BOOL finished){
            [weakSelf didDismissErrorEmptyDataTipsView:weakSelf.netFailView animated:animated];
        }];
    } else {
        self.netFailView.hidden = YES;
        self.netFailView.alpha = 0.0f;
        [self didDismissErrorEmptyDataTipsView:self.netFailView animated:animated];
    }
}

#pragma mark - 可重写，可理解为代理
- (void)willShowErrorEmptyDataTipsView:(UIView *)view animated:(BOOL)animated{
    
}

- (void)didShowErrorEmptyDataTipsView:(UIView *)view animated:(BOOL)animated{
    
}

- (void)willDismissErrorEmptyDataTipsView:(UIView *)view animated:(BOOL)animated{
    
}

- (void)didDismissErrorEmptyDataTipsView:(UIView *)view animated:(BOOL)animated{
    
}

#pragma mark - runtime
//定义常量 必须是C语言字符串
static char * netFailViewKey = "netFailViewKey";
- (void)setNetFailView:(NetFailView *)netFailView
{
    /*
     OBJC_ASSOCIATION_ASSIGN;            //assign策略
     OBJC_ASSOCIATION_COPY_NONATOMIC;    //copy策略
     OBJC_ASSOCIATION_RETAIN_NONATOMIC;  // retain策略
     
     OBJC_ASSOCIATION_RETAIN;
     OBJC_ASSOCIATION_COPY;
     */
    /*
     * id object 给哪个对象的属性赋值
     const void *key 属性对应的key
     id value  设置属性值为value
     objc_AssociationPolicy policy  使用的策略，是一个枚举值，和copy，retain，assign是一样的，手机开发一般都选择NONATOMIC
     objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy);
     */
    
    objc_setAssociatedObject(self, netFailViewKey, netFailView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NetFailView *)netFailView {
    return objc_getAssociatedObject(self, netFailViewKey);
}

@end

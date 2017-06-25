//
//  UIViewController+NetworkTips.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/25.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+GIF.h"

@interface UIViewController (NetworkTips)

#pragma mark - 加载视图
- (void)showLoadingView;
#pragma mark - 等待视图
- (void)showWaitingIcon;
- (void)dismissWaitingIcon;

#pragma mark - 点击出错或空数据视图
- (void)touchNetFailView:(UIView *)view;

#pragma mark - 错误或空数据时提示信息展示的区域尺寸，默认为self.view.bounds
- (CGRect)boundsForErrorOrEmptyView;

#pragma mark - 出错时各种提示信息
- (UIImage *)iconImageWhenError:(NSError *)error;
- (NSString *)tipsMessageWhenError:(NSError *)error;
- (NSString *)tipsSubMessageWhenError:(NSError *)error;

#pragma mark - 数据为空时各种提示信息
- (UIImage *)iconImageWhenDataEmpty;
- (NSString *)tipsMessageWhenDataEmpty;
- (NSString *)tipsSubMessageWhenDataEmpty;

#pragma mark - 加载时各种提示信息
- (UIImage *)iconImageWhenLoading;
- (NSString *)tipsMessageWhenLoading;
- (NSString *)tipsSubMessageWhenLoading;

#pragma mark - 视图相关
- (UIColor *)tipsViewBackgroundColor;
- (UIView *)emptyView;
- (UIView *)errorViewWhenError:(NSError *)error;
- (UIView *)loadingView;

#pragma mark - 显示出错视图
- (void)showErrorView;
- (void)showErrorViewWithError:(NSError *)error;
- (void)showErrorViewWithMessage:(NSString *)message;
- (void)showErrorViewWithMessage:(NSString *)message iconImageName:(NSString *)imageName;
- (void)showErrorViewWithMessage:(NSString*)message iconImage:(UIImage *)image;
- (void)showErrorViewWithMessage:(NSString *)message iconImageName:(NSString *)imageName frame:(CGRect)frame;
- (void)showErrorViewWithCustomView:(UIView *)customView frame:(CGRect)frame;

#pragma mark - 显示空数据视图
- (void)showDataEmptyView;
- (void)showDataEmptyViewWithMessage:(NSString *)message iconImageName:(NSString *)imageName;
- (void)showDataEmptyViewWithMessage:(NSString*)message;
- (void)showDataEmptyViewWithMessage:(NSString*)message iconImage:(UIImage *)image;
- (void)showDataEmptyViewWithMessage:(NSString *)message iconImageName:(NSString *)imageName frame:(CGRect)frame;
- (void)showNetFailViewWithMessage:(NSString *)message subMessage:(NSString *)subMessage iconImageName:(NSString *)imageName;
- (void)showNetFailViewWithMessage:(NSString *)message subMessage:(NSString *)subMessage iconImageName:(NSString *)imageName frame:(CGRect)frame;
-(void)showNetFailViewWithMessage:(NSString *)message subMessage:(NSString *)subMessage iconImage:(UIImage *)image;
- (void)showNetFailViewWithMessage:(NSString *)message iconImage:(UIImage *)image frame:(CGRect)frame animated:(BOOL)animated;
- (void)showNetFailViewWithCustomView:(UIView *)customView animated:(BOOL)animated;

#pragma mark - 最终调用方法
-(void)showNetFailViewWithMessage:(NSString *)message subMessage:(NSString *)subMessage iconImage:(UIImage *)image frame:(CGRect)frame animated:(BOOL)animated;
- (void)showNetFailViewWithCustomView:(UIView *)customView frame:(CGRect)frame animated:(BOOL)animated;

//#pragma mark -- 是否动画显示网络失败视图
//- (void)showNetFailViewAnimated:(BOOL)animated;

#pragma mark -- 隐藏网络失败视图
-(void)dismissNetFailView;
- (void)dismissNetFailViewAnimated:(BOOL)animated;

#pragma mark - 可重写，可理解为代理
- (void)willShowErrorEmptyDataTipsView:(UIView *)view animated:(BOOL)animated;
- (void)didShowErrorEmptyDataTipsView:(UIView *)view animated:(BOOL)animated;
- (void)willDismissErrorEmptyDataTipsView:(UIView *)view animated:(BOOL)animated;
- (void)didDismissErrorEmptyDataTipsView:(UIView *)view animated:(BOOL)animated;

@end

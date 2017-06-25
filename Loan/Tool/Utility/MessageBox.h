//
//  MessageBox.h
//  LingTouNiaoLoan
//
//  Created by LiuFeifei on 17/1/19.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageBox : NSObject

/**
 *  提示盒子，显示在window上，一定时间后自动消失
 *
 *  @param message 提示信息，默认2s后自动消失
 */
+ (void)boxShowWithMessage:(NSString *)message;

/**
 *  提示盒子，一定时间后自动消失
 *
 *  @param message 提示信息，默认2s后自动消失
 *  @param view    添加到的view
 */
+ (void)boxShowWithMessage:(NSString *)message onView:(UIView *)view;

/**
 *  提示盒子，一定时间后自动消失
 *
 *  @param message  提示信息
 *  @param view     添加到的view
 *  @param duration 显示持续时间
 */
+ (void)boxShowWithMessage:(NSString *)message onView:(UIView *)view duration:(NSTimeInterval)duration;
/**
 *  提示盒子，显示在window上，一定时间后自动消失
 *
 *  @param message  提示信息
 *  @param duration 显示持续时间
 */
+ (void)boxShowWithMessage:(NSString *)message duration:(NSTimeInterval)duration;

/**
 *  访问网络时出现的提示盒子
 *
 *  @param message 提示信息
 *  @param view    添加到的view
 */
+ (void)boxShowLoadWithMessage:(NSString *)message onView:(UIView *)view;

/**
 *  访问网络时出现的提示盒子，默认添加到window上
 *
 *  @param message 提示信息
 */
+ (void)boxShowLoadWithMessage:(NSString *)message;

/**
 *  访问网络成功，从父视图中删除
 *
 *  @param view 提示盒子的父视图
 */
+ (void)removeLoadMessageBoxFromView:(UIView *)view;

/**
 *  访问网络成功，从父视图中删除，默认父视图是window
 */
+ (void)removeLoadMessageBox;

@end

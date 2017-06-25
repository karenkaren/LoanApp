//
//  NSObject+Common.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/27.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import <Foundation/Foundation.h>

//static NSString * const HTTPResponseSerializerWithBodyKey = @"body";
//static NSString * const HTTPResponseSerializerWithStatusKey = @"statusCode";

@interface NSObject (Common)

#pragma mark - Net Error Handle
-(id)handleResponse:(id)response;
-(id)handleResponse:(id)response autoShowError:(BOOL)autoShowError;

#pragma mark - alert
+ (void)showAlertTitle:(NSString *)title msg:(NSString *)msg cancelTitle:(NSString *)cancelTitle commitBtnTitle:(NSString *)commitText handlerBlock:(void (^)(void))handler onVC:(UIViewController *)vc;

#pragma mark - tips
+ (void)showWaitingIconInView:(UIView *)view;
+ (void)dismissWaitingIconInView:(UIView *)view;
+ (BOOL)showError:(NSError *)error;
+ (BOOL)showMessage:(NSString *)message;
+ (void)showHudTipStr:(NSString *)tipStr;

#pragma mark - Net Data Persistence
+ (BOOL)saveResponseData:(NSDictionary *)data toPath:(NSString *)requestPath;
+ (id)loadResponseWithPath:(NSString *)requestPath;

#pragma mark - runtime
+ (NSArray *)getAllMethodsFromClass:(Class)class;

#pragma mark - Dictionary to Object
+(id)objectOfClass:(Class)modelClass fromJSON:(NSDictionary *)dict;

#pragma mark - json 字符串
+ (NSString *)jsonStringWithObject:(id)object;

@end

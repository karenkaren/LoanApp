//
//  ControllersManager.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/27.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

/**
    控制各controller的跳转
 */
#import <Foundation/Foundation.h>

@interface ControllersManager : NSObject

singleton_interface(ControllersManager)

@property (nonatomic, strong) UIViewController * rootViewController;

- (void)setupProjectRootViewController;

#pragma mark - about user
- (void)sessionKeyTimeOut:(VoidBlock)block;
- (void)logout;
+ (void)actionWhenLogin:(VoidBlock)block;
- (void)loginController:(VoidBlock)finishBlock;
- (void)loginController:(VoidBlock)finishBlock animated:(BOOL)animated;
- (void)resetPassword;
- (void)retrievePassword;
- (void)registerController:(VoidBlock)finishBlock;

#pragma mark - switch controller
//- (void)aboutUsController:(VoidBlock)finishBlock;
//- (void)feedbackController:(VoidBlock)finishBlock;

@end

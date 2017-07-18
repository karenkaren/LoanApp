//
//  ControllersManager.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/27.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "ControllersManager.h"
#import "BaseNavigationController.h"
#import "ProjectRootController.h"
#import "MeRootController.h"
#import "UserLoginController.h"
#import "UserRetrieveController.h"
#import "UserRegisterController.h"
//#import "AboutRootController.h"
//#import "FeedbackController.h"
#import "LoginModel.h"
#import "UIAlertView+Block.h"
#import "SHRootViewController.h"

@interface ControllersManager ()<UIAlertViewDelegate>

@end

@implementation ControllersManager

singleton_implementation(ControllersManager)

#pragma mark - 设置根视图
- (void)setupProjectRootViewController
{
    NSString * iosStatus = [[NSUserDefaults standardUserDefaults] valueForKey:@"iosStatus"];
    
    if ([iosStatus isEqualToString:@"SHENHE"]) {
        SHRootViewController * rootController = [[SHRootViewController alloc] init];
        [[GlobalManager mainWindow] setRootViewController:rootController];
        self.rootViewController = rootController;
    } else {
        ProjectRootController * rootController = [[ProjectRootController alloc] init];
        [[GlobalManager mainWindow] setRootViewController:rootController];
        self.rootViewController = rootController;
    }
}

#pragma mark - private methods
- (void)pushToViewController:(UIViewController *)viewController finishBlock:(VoidBlock)finishBlock
{
    [self pushToViewController:viewController finishBlock:finishBlock animated:YES];
}

- (void)pushToViewController:(UIViewController *)viewController finishBlock:(VoidBlock)finishBlock animated:(BOOL)animated
{
    if ([self.rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController * nav = (UINavigationController *)self.rootViewController;
        nav.finishBlock = finishBlock;
        for (UIViewController * controller in nav.childViewControllers) {
            if ([controller isKindOfClass:[viewController class]]) {
                [nav popToViewController:controller animated:animated];
                return;
            }
        }
        UIViewController * topViewController = nav.topViewController;
        [topViewController.navigationController pushViewController:viewController animated:animated];
    } else {
        BaseNavigationController * navController = [[BaseNavigationController alloc] initWithRootViewController:viewController];
        navController.finishBlock = finishBlock;
        [self.rootViewController presentViewController:navController animated:animated completion:nil];
    }
}

#pragma mark - about user
- (void)sessionKeyTimeOut:(VoidBlock)block
{
    DispatchAsyncOnMainThread(^{
        [[CurrentUser mine] reset];
        [[ControllersManager sharedControllersManager] setupProjectRootViewController];
        if (![[NSUserDefaults standardUserDefaults] boolForKey:kSessionKeyTimeOut]) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kSessionKeyTimeOut];
//            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"你的登录信息已经过期，请重新登录" preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kSessionKeyTimeOut];
//            }];
//            [alertController addAction:cancelAction];
//            
//            UIAlertAction * confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kSessionKeyTimeOut];
//                [[ControllersManager sharedControllersManager] loginController:^{
//                    if (block) {
//                        block();
//                    }
//                } animated:YES];
//            }];
//            [alertController addAction:confirmAction];
//            
//            if ([self.rootViewController isKindOfClass:[UINavigationController class]]) {
//                UINavigationController * navi = (UINavigationController *)self.rootViewController;
//                [navi.visibleViewController presentViewController:alertController animated:YES completion:nil];
//            } else {
//                [self.rootViewController presentViewController:alertController animated:YES completion:nil];
//            }
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你的登录信息已经过期，请重新登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kSessionKeyTimeOut];
                if (buttonIndex) {
                    [[ControllersManager sharedControllersManager] loginController:^{
                        if (block) {
                            block();
                        }
                    } animated:YES];
                }
            }];
        }
    });
}

- (void)logout
{
    DispatchAsyncOnMainThread(^{
        [LoginModel logout];
        [[ControllersManager sharedControllersManager] setupProjectRootViewController];
    });
}

+ (void)actionWhenLogin:(VoidBlock)block
{
    if ([[CurrentUser mine] hasLogged]) {
        // 如果用户已经登录
        if (block) {
            block();
        }
    } else {
        // 如果用户未登录，跳转到登录页面
        [[ControllersManager sharedControllersManager] loginController:^(void){
            if (block) {
                block();
            }
        }];
    }
}

- (void)loginController:(VoidBlock)finishBlock animated:(BOOL)animated
{
    UserLoginController * loginController = [[UserLoginController alloc] init];
    [self pushToViewController:loginController finishBlock:finishBlock animated:animated];
}

- (void)loginController:(VoidBlock)finishBlock
{
    [self loginController:finishBlock animated:YES];
}

- (void)resetPassword
{
    BaseNavigationController * retrieveNav = [[BaseNavigationController alloc] initWithRootViewController:[[UserRetrieveController alloc] initWithRetrieveType:kRetrieveTypeOfReset]];
        if ([self.rootViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController * nav = (UINavigationController *)self.rootViewController;
            [nav.visibleViewController presentViewController:retrieveNav animated:YES completion:nil];
        }
}

- (void)retrievePassword
{
    BaseNavigationController * retrieveNav = [[BaseNavigationController alloc] initWithRootViewController:[[UserRetrieveController alloc] init]];
    if ([self.rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController * nav = (UINavigationController *)self.rootViewController;
        [nav.visibleViewController presentViewController:retrieveNav animated:YES completion:nil];
    }
}

- (void)registerController:(VoidBlock)finishBlock
{
    UserRegisterController * registerController = [[UserRegisterController alloc] init];
    [self pushToViewController:registerController finishBlock:finishBlock];
}

#pragma mark - switch controller
//- (void)aboutUsController:(VoidBlock)finishBlock
//{
//    AboutRootController * aboutController = [[AboutRootController alloc] init];
//    [self pushToViewController:aboutController finishBlock:finishBlock];
//}
//
//- (void)feedbackController:(VoidBlock)finishBlock
//{
//    FeedbackController * feedbackController = [[FeedbackController alloc] init];
//    [self pushToViewController:feedbackController finishBlock:finishBlock];
//}

@end

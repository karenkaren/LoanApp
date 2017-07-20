//
//  ProjectRootController.m
//  XiChe
//
//  Created by LiuFeifei on 17/4/2.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

#import "ProjectRootController.h"
#import "BaseNavigationController.h"
#import "HomeRootController.h"
//#import "ShopRootController.h"
#import "MeRootController.h"
//#import "AboutRootController.h"
#import "LoanRootController.h"

@interface ProjectRootController ()<UITabBarControllerDelegate>

@end

@implementation ProjectRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    [self creatControllers];
}

- (void)creatControllers
{
    // 1.首页
    HomeRootController * home = [[HomeRootController alloc] init];
    BaseNavigationController * homeNav = [[BaseNavigationController alloc] initWithRootViewController:home];
    UITabBarItem * item1 = [[UITabBarItem alloc] initWithTitle:@"神马贷款"
                                                        image:[[UIImage imageNamed:@"tab_home_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                selectedImage:[[UIImage imageNamed:@"tab_home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    home.tabBarItem = item1;
    
    // 2.贷款
    LoanRootController * loan = [[LoanRootController alloc] init];
    BaseNavigationController * shopNav = [[BaseNavigationController alloc] initWithRootViewController:loan];
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"贷款"
                                                        image:[[UIImage imageNamed:@"tab_list_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                selectedImage:[[UIImage imageNamed:@"tab_list_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    shopNav.tabBarItem = item2;
    
    // 3.我的
    MeRootController * me = [[MeRootController alloc] init];
    BaseNavigationController * meNav = [[BaseNavigationController alloc] initWithRootViewController:me];
    UITabBarItem * item3 = [[UITabBarItem alloc] initWithTitle:@"我的"
                                                        image:[[UIImage imageNamed:@"tab_account_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                selectedImage:[[UIImage imageNamed:@"tab_account_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    meNav.tabBarItem = item3;
    
//    // 4.关于
//    AboutRootController * about = [[AboutRootController alloc] init];
//    BaseNavigationController * aboutNav = [[BaseNavigationController alloc] initWithRootViewController:about];
//    [self addChildViewController:aboutNav];
//    UITabBarItem * item4 = [[UITabBarItem alloc] initWithTitle:@"关于"
//                                                        image:[[UIImage imageNamed:@"tab_about_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
//                                                selectedImage:[[UIImage imageNamed:@"tab_about_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    aboutNav.tabBarItem = item4;
    
    NSArray *controllers = [NSArray arrayWithObjects:homeNav, shopNav, meNav, nil];
    self.viewControllers = controllers;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    if ([[CurrentUser mine] hasLogged])
        return YES;
    else{
        BaseNavigationController * navController = (BaseNavigationController *)viewController;
        if([navController.topViewController isKindOfClass:[MeRootController class]]){
            [[ControllersManager sharedControllersManager] loginController:^{
                [self setSelectedIndex:2];
            }];
            return NO;
        }
        return YES;
    }
//    return YES;
}

@end

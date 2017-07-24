//
//  SHRootViewController.m
//  Loan
//
//  Created by 王安帮 on 2017/7/18.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "SHRootViewController.h"

#import "SHHomeViewController.h"
#import "SHMeRootController.h"

@interface SHRootViewController ()<UITabBarControllerDelegate>

@end

@implementation SHRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    [self creatControllers];
}

- (void)creatControllers
{
    // 1.首页
    SHHomeViewController * home = [[SHHomeViewController alloc] init];
    BaseNavigationController * homeNav = [[BaseNavigationController alloc] initWithRootViewController:home];
    UITabBarItem * item1 = [[UITabBarItem alloc] initWithTitle:@"神马贷款"
                                                         image:[[UIImage imageNamed:@"tab_home_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                 selectedImage:[[UIImage imageNamed:@"tab_home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    home.tabBarItem = item1;
    
    // 2.我的
    SHMeRootController * me = [[SHMeRootController alloc] init];
    BaseNavigationController * meNav = [[BaseNavigationController alloc] initWithRootViewController:me];
    UITabBarItem * item2 = [[UITabBarItem alloc] initWithTitle:@"我的"
                                                         image:[[UIImage imageNamed:@"tab_account_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                 selectedImage:[[UIImage imageNamed:@"tab_account_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    meNav.tabBarItem = item2;
    
    NSArray *controllers = [NSArray arrayWithObjects:homeNav, meNav, nil];
    self.viewControllers = controllers;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    if ([[CurrentUser mine] hasLogged])
        return YES;
    else{
        BaseNavigationController * navController = (BaseNavigationController *)viewController;
        if([navController.topViewController isKindOfClass:[SHMeRootController class]]){
            [[ControllersManager sharedControllersManager] loginController:^{
                [self setSelectedIndex:1];
            }];
            return NO;
        }
        return YES;
    }
}

@end

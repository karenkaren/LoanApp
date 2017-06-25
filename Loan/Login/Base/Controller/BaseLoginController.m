//
//  BaseLoginController.m
//  LingTouNiaoLoan
//
//  Created by LiuFeifei on 17/1/11.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

#import "BaseLoginController.h"

#define kErrorColor kHexColor(0x146DBA)

@interface BaseLoginController ()

@end

@implementation BaseLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 返回按钮
    
    UIBarButtonItem * backButton = [UIBarButtonItem barItemWithImage:[UIImage imageNamed:@"nav_return"] target:self action:@selector(back)];
    if (self.baseNavigationController.childViewControllers.count == 1) {
        backButton = [UIBarButtonItem barItemWithImage:[UIImage imageNamed:@"nav_close"] target:self action:@selector(back)];
    }
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self changeErrorStatus:NO];
    [self.baseNavigationController hideBorder:YES];
    [self.baseNavigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWilDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.baseNavigationController.barBackgroundColor = kWhiteColor;
}

- (void)changeErrorStatus:(BOOL)change
{
////    UIColor * color = change ? kErrorColor : kMainColor;
//    UIColor * color = kMainColor;
//    self.baseNavigationController.barBackgroundColor = color;
//    if (!change) {
//        return;
//    }
//    for (UIView * view in self.view.subviews) {
//        for (UIView * subview in view.subviews) {
//            if ([subview isKindOfClass:[BaseLoginView class]]) {
//                BaseLoginView * baseView = (BaseLoginView *)subview;
//                baseView.backgroundColor = color;
//                return;
//            }
//        }
//    }
}

//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}

@end

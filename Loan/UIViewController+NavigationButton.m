//
//  UIViewController+NavigationButton.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/28.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "UIViewController+NavigationButton.h"
#import "UIBarButtonItem+ClearBackground.h"

@implementation UIViewController (NavigationButton)

- (void)showBackButton:(BOOL)willShow
{
    if (willShow && self.navigationController != nil && self.navigationController.childViewControllers.count > 1) {
        UIBarButtonItem * backButton = [UIBarButtonItem barItemWithImage:[UIImage imageNamed:@"nav_return"] target:self action:@selector(back)];
        self.navigationItem.leftBarButtonItem = backButton;
    } else {
        self.navigationItem.leftBarButtonItem = nil;
    }
}

- (void)showCloseButton:(BOOL)willShow
{
    if (willShow && self.navigationController != nil && self.navigationController.childViewControllers.count == 1) {
        UIBarButtonItem * closeButton = [UIBarButtonItem barItemWithImage:[UIImage imageNamed:@"nav_close"] target:self action:@selector(back)];
        self.navigationItem.leftBarButtonItem = closeButton;
    } else {
        self.navigationItem.leftBarButtonItem = nil;
    }
}

- (void)back
{
    if (self.navigationController.visibleViewController == self) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

@end

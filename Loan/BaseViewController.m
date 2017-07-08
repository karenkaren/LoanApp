//
//  BaseViewController.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/24.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseNavigationController.h"

@implementation BaseViewController

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    if ([self.navigationController isKindOfClass:[BaseNavigationController class]]) {
        self.baseNavigationController = (BaseNavigationController *)self.navigationController;
    }
    
    self.view.backgroundColor = kBackgroundColor;
    
    [self showCloseButton:self.showCloseButton];
    [self showBackButton:!self.showCloseButton];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

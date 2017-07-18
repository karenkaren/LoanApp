//
//  SHHomeViewController.m
//  Loan
//
//  Created by 王安帮 on 2017/7/18.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "SHHomeViewController.h"
#import "SHHomeView.h"

@interface SHHomeViewController ()

@end

@implementation SHHomeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    SHHomeView * homeView = [[SHHomeView alloc] init];
    [self.view addSubview:homeView];
    
    [homeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    homeView.applyClickBlock = ^(UIButton *button) {
        DLog(@"start apply");
    };
}

@end

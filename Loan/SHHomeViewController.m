//
//  SHHomeViewController.m
//  Loan
//
//  Created by 王安帮 on 2017/7/18.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "SHHomeViewController.h"
#import "SHHomeView.h"
#import "SHProfileInfoController.h"
#import "SHBaseModel.h"
#import "SHBasicInfoController.h"
#import "SHProgressController.h"

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
        [ControllersManager actionWhenLogin:^{
            [self checkUserStatus];
        }];
    };
}

- (void)checkUserStatus
{
    [self showWaitingIcon];
    [SHBaseModel queryUserAuthStatusWithBlock:^(id response, id data, NSError *error) {
        [self dismissWaitingIcon];
        if (!error) {
            BOOL isRealName = [data[@"isRealName"] boolValue];
            BOOL isBasicInfo = [data[@"isBasicInfo"] boolValue];
            BOOL isApplySubmit = [data[@"isApplySubmit"] boolValue];

            if (!isRealName) {
                SHProfileInfoController * profileInfoController = [[SHProfileInfoController alloc] init];
                profileInfoController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:profileInfoController animated:YES];
                return;
            }
            
            if (!isBasicInfo) {
                DLog(@"未填写基本信息");
                SHBasicInfoController * basicInfoController = [[SHBasicInfoController alloc] init];
                basicInfoController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:basicInfoController animated:YES];
                return;
            }
            
            if (isApplySubmit) {
                DLog(@"已经提交申请");
                SHProgressController * progressController = [[SHProgressController alloc] init];
                progressController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:progressController animated:YES];
            }
        }
    }];
    
}

@end

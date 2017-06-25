//
//  UserModifyController.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/28.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "UserModifyController.h"
#import "UserModifyView.h"
#import "RetrieveModel.h"

@interface UserModifyController ()

@property (nonatomic, strong) UserModifyView * userModifyView;

@end

@implementation UserModifyController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.baseNavigationController hideBorder:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"重设密码";
    
    // 添加视图
    UserModifyView * userModifyView = [[UserModifyView alloc] init];
    [self.view addSubview:userModifyView];
    [userModifyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.userModifyView = userModifyView;
    
    // 添加方法
    userModifyView.modifyClickBlock = ^(UIButton *button) {
        [self modifySubmit:button];
    };
}

- (void)modifySubmit:(UIButton *)button
{
    NSString * password = self.userModifyView.passwordTextField.text;
    NSString * passwordAgain = self.userModifyView.passwordAgainTextField.text;
    if (![password isEqualToString:passwordAgain]) {
        [NSObject showHudTipStr:@"两次密码不一致，请重新输入"];
        return;
    }
    
    if (![NSString isPassword:password]) {
        [NSObject showHudTipStr:@"密码应该为6-18位字母和数字组合"];
        return;
    }

    [self.params setValue:password forKey:@"newPwd"];
    
    [self showWaitingIcon];
    button.enabled = NO;
    [RetrieveModel doGetBackPassword:self.params block:^(id response, NSError *error) {
        [self dismissWaitingIcon];
        button.enabled = YES;
        if (!error) {
            [self.navigationController popToRootViewControllerAnimated:NO];
            [[CurrentUser mine] reset];
            [[ControllersManager sharedControllersManager] loginController:^{
                if (self.navigationController.finishBlock) {
                    self.navigationController.finishBlock();
                }
            } animated:NO];
        }
    }];
}

@end

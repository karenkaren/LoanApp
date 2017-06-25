//
//  UserRegisterController.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/10.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "UserRegisterController.h"
#import "UserRegisterView.h"
#import "RegisterModel.h"
#import "UserLoginController.h"
#import "ControllersManager.h"
#import "BaseWebViewController.h"

@interface UserRegisterController ()

@property (nonatomic, strong) UserRegisterView * userRegisterView;

@end

@implementation UserRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    
    // 添加视图
    UserRegisterView * userRegisterView = [[UserRegisterView alloc] init];
    [self.view addSubview:userRegisterView];
    [userRegisterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.userRegisterView = userRegisterView;
    
    // 添加方法
    userRegisterView.registerClickBlock = ^(UIButton *button) {
        [self registerSubmit:button];
    };
    userRegisterView.getCaptchaClickBlock = ^(UIButton *button) {
        [self getCaptchaSubmit];
    };
    
    // agree方法
    userRegisterView.showProtocolBlock = ^(void) {
        DLog(@"显示用户注册协议");
//        BaseWebViewController * webView = [[BaseWebViewController alloc] initWithURL:registerProtocolH5Url];
//        webView.showNavigation = YES;
//        self.baseNavigationController.barBackgroundColor = kWhiteColor;
//        [self.navigationController pushViewController:webView animated:YES];
    };
}

- (void)back
{
    [self.userRegisterView stopTimer];
    [super back];
}

- (void)registerSubmit:(UIButton *)button
{
    if (![NSString isPhoneNumber:self.userRegisterView.telephoneTextField.text]) {
        [NSObject showHudTipStr:@"手机号输入不规范，请重新输入！"];
        [self changeErrorStatus:YES];
        return;
    }
    
    if (![NSString isPassword:self.userRegisterView.passwordTextField.text]) {
        [NSObject showHudTipStr:@"密码必须为6-18位数字和字母组合"];
        [self changeErrorStatus:YES];
        return;
    }
    
    if (![NSString isPureInterger:self.userRegisterView.captchaTextField.text]) {
        [NSObject showHudTipStr:@"验证码输入错误，请重新输入！"];
        [self changeErrorStatus:YES];
        return;
    }
    
    NSDictionary * params = @{@"mobileNo" : self.userRegisterView.telephoneTextField.text,
                              @"password" : self.userRegisterView.passwordTextField.text,
                              @"mobileCode" : self.userRegisterView.captchaTextField.text,
                              @"readAndAgree" : @YES
                              };
    [self showWaitingIcon];
    button.enabled = NO;
    [RegisterModel doRegister:params block:^(id response, id data, NSError *error) {
        [self dismissWaitingIcon];
        button.enabled = YES;
        if (!error) {
            [self dismissViewControllerAnimated:YES completion:nil];
            if (self.navigationController.finishBlock) {
                self.navigationController.finishBlock();
            }
        }
    }];
}

- (void)getCaptchaSubmit
{
    if (![NSString isPhoneNumber:self.userRegisterView.telephoneTextField.text]) {
        [NSObject showHudTipStr:@"手机号输入不规范，请重新输入！"];
        [self changeErrorStatus:YES];
        return;
    }
    NSDictionary * params = @{@"mobileNo" : self.userRegisterView.telephoneTextField.text};
    [RegisterModel registerOfSendMobileCode:params block:^(id response, NSError *error) {
        if (!error) {
            [self.userRegisterView startTimer];
        }
    }];
}

@end

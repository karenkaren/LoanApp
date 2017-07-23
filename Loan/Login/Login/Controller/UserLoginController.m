//
//  UserLoginController.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/10.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "UserLoginController.h"
#import "UserLoginView.h"
#import "UserRegisterController.h"
#import "LoginModel.h"
#import "BaseNavigationController.h"
#import "ControllersManager.h"
#import "NetAddressSettingController.h"
#import "UserRegisterController.h"
#import "UserRetrieveController.h"
#import "UIDevice+Info.h"

@interface UserLoginController ()

@property (nonatomic, strong) UserLoginView * userLoginView;

@end

@implementation UserLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    
    // 注册
    UIBarButtonItem * registerButton = [UIBarButtonItem barItemWithTitle:@"注册" target:self action:@selector(registerSubmit) andTextColor:kTextColor];
    self.navigationItem.rightBarButtonItem = registerButton;
    
    // 添加视图
    UserLoginView * userLoginView = [[UserLoginView alloc] init];
    [self.view addSubview:userLoginView];
    [userLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.userLoginView = userLoginView;
    
    // 添加方法
    userLoginView.loginClickBlock = ^(UIButton *button) {
        [self loginSubmit:button];
    };
    userLoginView.resetClickBlock = ^(UIButton *button) {
        [self forgetSubmit];
    };
    userLoginView.getCaptchaClickBlock = ^(UIButton *button) {
        [self getCaptchaSubmit:button];
    };
    
    // 获取验证码
    [self getCaptchaSubmit:nil];
    
#if (defined(ADHOC) || defined(DEBUG))
    
//    UIButton * severButton = [[UIButton alloc] init];
//    [severButton setTitle:@"设置服务器" forState:UIControlStateNormal];
//    [severButton setDisenableBackgroundColor:kHexColor(0xcccccc) enableBackgroundColor:[UIColor blueColor]];
//    [severButton addTarget:self action:@selector(setServer) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:severButton];
//    
//    [severButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(kScreenWidth, kGeneralSize));
//        make.left.bottom.equalTo(userLoginView);
//    }];
    
#endif

}

-(void)setServer{
    NetAddressSettingController *vc = [[NetAddressSettingController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loginSubmit:(UIButton *)button
{
    if (![NSString isPhoneNumber:self.userLoginView.telephoneTextField.text]) {
        [NSObject showHudTipStr:@"请输入正确的手机号"];
        [self changeErrorStatus:YES];
        return;
    }
    
    if (![NSString isPassword:self.userLoginView.passwordTextField.text]) {
        [NSObject showHudTipStr:@"密码应该为6-18位字母与数字组合"];
        [self changeErrorStatus:YES];
        return;
    }
    
    if (!self.userLoginView.captchaTextField.hidden) {
        if (![NSString isPureInterger:self.userLoginView.captchaTextField.text]) {
            [NSObject showHudTipStr:@"验证码输入错误，请重新输入"];
            [self changeErrorStatus:YES];
            return;
        }
    }

    NSDictionary * params = @{@"mobileNo" : self.userLoginView.telephoneTextField.text,
                              @"password" : self.userLoginView.passwordTextField.text,
                             @"machineNo" : [UIDevice IDFA],
                           @"pictureCode" : self.userLoginView.captchaTextField.text};
    [self showWaitingIcon];
    button.enabled = NO;
    [LoginModel doLogin:params block:^(id response, id data, NSError *error) {
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

- (void)forgetSubmit
{
//    [[ControllersManager sharedControllersManager] retrievePassword];
    UserRetrieveController * retrieveController = [[UserRetrieveController alloc] init];
    [self.navigationController pushViewController:retrieveController animated:YES];
}

- (void)registerSubmit
{
//    [[ControllersManager sharedControllersManager] registerController:self.navigationController.finishBlock];
    UserRegisterController * registerController = [[UserRegisterController alloc] init];
    [self.navigationController pushViewController:registerController animated:YES];
}

- (void)getCaptchaSubmit:(UIButton *)button
{
    [self showWaitingIcon];
    button.enabled = NO;
    [LoginModel getPictureCode:nil block:^(UIImage *image) {
        [self dismissWaitingIcon];
        button.enabled = YES;
        if (image) {
            [self.userLoginView.captchaButton setImage:image forState:UIControlStateNormal];
        } else {
            [NSObject showMessage:@"获取图片验证码错误，请重试"];
        }
    }];
}

@end

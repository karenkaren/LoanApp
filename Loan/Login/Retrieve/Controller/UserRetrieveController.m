//
//  UserRetrieveController.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/28.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "UserRetrieveController.h"
#import "UserRetrieveView.h"
#import "UserModifyController.h"
#import "RetrieveModel.h"

@interface UserRetrieveController ()

@property (nonatomic, strong) UserRetrieveView * userRetrieveView;
@property (nonatomic, assign) RetrieveType retrieveType;

@end

@implementation UserRetrieveController

- (instancetype)initWithRetrieveType:(RetrieveType)retrieveType
{
    self = [super init];
    if (self) {
        self.retrieveType = retrieveType;
    }
    return self;
}

- (void)back
{
    [self.userRetrieveView stopTimer];
    [super back];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.baseNavigationController hideBorder:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"找回密码";
    
    // 添加视图
    UserRetrieveView * userRetrieveView = [[UserRetrieveView alloc] init];
    switch (self.retrieveType) {
        // 如果从账户中心过来修改密码，则将手机号带过来，且不能修改
        case kRetrieveTypeOfReset:
        {
            NSString * mobileNo = [[NSUserDefaults standardUserDefaults] stringForKey:kMobileNo];
            if (![esString(mobileNo) isEqualToString:@""]) {
                userRetrieveView.telephoneTextField.text = esString(mobileNo);
                userRetrieveView.telephoneTextField.enabled = NO;
            }
        }
            break;
        default:
            break;
    }
    [self.view addSubview:userRetrieveView];
    [userRetrieveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.userRetrieveView = userRetrieveView;
    
    // 添加方法
    kWeakSelf
    userRetrieveView.retrieveClickBlock = ^(UIButton *button) {
        kStrongSelf
        if (strongSelf) {
            [strongSelf nextSubmit:button];
        }
    };
    
    userRetrieveView.getCaptchaClickBlock = ^(UIButton *button) {
        kStrongSelf
        if (strongSelf) {
            [strongSelf getCaptchaSubmit];
        }
    };
}

- (void)nextSubmit:(UIButton *)button
{
    if (![NSString isPhoneNumber:self.userRetrieveView.telephoneTextField.text]) {
        [NSObject showHudTipStr:@"请输入正确的手机号"];
        [self changeErrorStatus:YES];
        return;
    }
    
    if (![NSString isPureInterger:self.userRetrieveView.captchaTextField.text]) {
        [NSObject showHudTipStr:@"验证码输入错误，请重新输入！"];
        [self changeErrorStatus:YES];
        return;
    }
    
    if (!self.userRetrieveView.identityTextField.hidden) {
        if (![NSString isValidIDCardNumber:self.userRetrieveView.identityTextField.text]) {
            [NSObject showHudTipStr:@"请输入正确的身份证号"];
            [self changeErrorStatus:YES];
            return;
        }
    }
    
    NSMutableDictionary * params = @{@"mobileNo" : self.userRetrieveView.telephoneTextField.text,
                                     @"mobileCode" : self.userRetrieveView.captchaTextField.text
                                     }.mutableCopy;
    if (!self.userRetrieveView.identityTextField.hidden) {
        [params setValue:self.userRetrieveView.identityTextField.text forKey:@"idCard"];
    }
    
    [self showWaitingIcon];
    button.enabled = NO;
    [RetrieveModel doGetBackPasswordCheck:params block:^(id response, NSError *error) {
        [self dismissWaitingIcon];
        button.enabled = YES;
        if (!error) {
            UserModifyController * modifyController = [[UserModifyController alloc] init];
            modifyController.params = params;
            [self.navigationController pushViewController:modifyController animated:YES];
        }
    }];
}

- (void)getCaptchaSubmit
{
    if (![NSString isPhoneNumber:self.userRetrieveView.telephoneTextField.text]) {
        [NSObject showHudTipStr:@"手机号输入不规范，请重新输入！"];
        [self changeErrorStatus:YES];
        return;
    }
    
    [self.userRetrieveView startTimer];
    NSDictionary * params = @{@"mobileNo" : self.userRetrieveView.telephoneTextField.text};
    
    [self showWaitingIcon];
    [RetrieveModel getBackPasswordOfSendMobileCode:params block:^(id response, BOOL showIdentify, NSError *error) {
        [self dismissWaitingIcon];
        self.userRetrieveView.showIdentityDialog = showIdentify;
    }];
}

@end

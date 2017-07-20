//
//  LoadingViewController.m
//  Loan
//
//  Created by 王安帮 on 2017/7/18.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "LoadingViewController.h"

@interface LoadingViewController ()

@end

@implementation LoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getIosStatus];
}

- (void)getIosStatus
{
    [[NetAPIManager sharedNetAPIManager] requestWithPath:@"https://www.flashcredit.cn/api/v1/ios/check" params:nil methodType:Get block:^(id response, NSError *error) {
        if (!error) {
            BaseDto * dto = [BaseDto mj_objectWithKeyValues:response];
            NSString * iosStatus = dto.data[@"iosStatus"];
            // todo:
//            NSString * iosStatus = @"SHENHE";
            [[NSUserDefaults standardUserDefaults] setValue:esString(iosStatus) forKey:@"iosStatus"];
            [[ControllersManager sharedControllersManager] setupProjectRootViewController];
        } else {
            [self getIosStatus];
        }
    }];
}

@end

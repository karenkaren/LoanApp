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
    
    [[NetAPIManager sharedNetAPIManager] requestWithPath:@"https://www.flashcredit.cn/api/v1/ios/check" params:nil methodType:Get block:^(id response, NSError *error) {
        if (!error) {
            BaseDto * dto = [BaseDto mj_objectWithKeyValues:response];
//            NSString * iosStatus = dto.data[@"iosStatus"];
            // todo:
            NSString * iosStatus = @"SHENHE";
            [[NSUserDefaults standardUserDefaults] setValue:esString(iosStatus) forKey:@"iosStatus"];
            [[ControllersManager sharedControllersManager] setupProjectRootViewController];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

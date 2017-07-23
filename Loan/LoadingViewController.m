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
    
    NSString * imageName = @"";
    if (kScreenHeight == 960 * 0.5) {
        imageName = @"640-960";
    } else if (kScreenHeight == 1136 * 0.5) {
        imageName = @"640-1136";
    } else if (kScreenHeight == 1334 * 0.5) {
        imageName = @"750-1134";
    } else {
        imageName = @"1242-2208";
    }
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [self.view addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self getIosStatus];
}

- (void)getIosStatus
{
    [[NetAPIManager sharedNetAPIManager] requestWithPath:@"https://www.flashcredit.cn/api/v1/ios/check" params:nil methodType:Get autoShowError:NO block:^(id response, NSError *error) {
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

//
//  SettingController.m
//  Loan
//
//  Created by 王安帮 on 2017/6/24.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "SettingController.h"
#import "BaseWebViewController.h"

@interface SettingController ()

@property (nonatomic, strong) NSArray * originalDatas;

@end

@implementation SettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.tableView.tableFooterView = [self getTableFooterView];
    
    self.originalDatas = @[@{@"title" : @"关于我们",
                             @"image" : @"logo",
                             @"sel" : @""},
                           @{@"title" : @"意见反馈",
                             @"image" : @"logo",
                             @"sel" : @""},
                           @{@"title" : @"客服热线",
                             @"image" : @"logo",
                             @"sel" : @"callService:",
                             @"detail" : @"18000000000"},
                           @{@"title" : @"商务合作",
                             @"image" : @"logo",
                             @"sel" : @""},
                           @{@"title" : @"给个好评吧",
                             @"image" : @"logo",
                             @"sel" : @"goAppStore"},
                           @{@"title" : @"分享给好友",
                             @"image" : @"logo",
                             @"sel" : @"shareToFriends"}];
}

- (UIView *)getTableFooterView
{
    UIView * footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    
    UIButton * logoutButton = [UIButton createButtonWithTitle:@"退出登录" color:kWhiteColor font:kFont(24) block:^(UIButton *button) {
        [[CurrentUser mine] reset];
        [[ControllersManager sharedControllersManager] setupProjectRootViewController];
    }];
    logoutButton.backgroundColor = [UIColor yellowColor];
    [footerView addSubview:logoutButton];
    
    [logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(footerView).offset(-4 * kCommonMargin);
        make.center.equalTo(footerView);
        make.height.equalTo(@(kGeneralSize));

    }];
    
    return footerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.originalDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSDictionary * cellDic = self.originalDatas[indexPath.row];
    cell.textLabel.text = cellDic[@"title"];
    cell.imageView.image = [UIImage imageNamed:cellDic[@"image"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * cellDic = self.originalDatas[indexPath.row];
    SEL action = NSSelectorFromString(cellDic[@"sel"]);
    if ([self respondsToSelector:action]) {
        [self performSelector:action withObject:cellDic[@"detail"] afterDelay:0.0f];
    }
}

- (void)shareToFriends
{
    DLog(@"share");
}

- (void)callService:(NSString *)telephoneNo
{
    if (![NSString isEmpty:telephoneNo]) {
        NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", telephoneNo]];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

- (void)goAppStore
{
    DLog(@"去评分");
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[GlobalManager appDownloadUrl]]];
}

@end

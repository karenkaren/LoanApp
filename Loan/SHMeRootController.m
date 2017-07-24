//
//  SHMeRootController.m
//  Loan
//
//  Created by 王安帮 on 2017/7/24.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "SHMeRootController.h"
#import "MeRootHeaderView.h"
#import "SettingController.h"
#import "SHProgressController.h"
#import "SHBasicProfileController.h"
//#import "ProfileModel.h"
#import "TableViewDevider.h"
#import "SHBaseModel.h"

@interface SHMeRootController ()

@property (nonatomic, strong) MeRootHeaderView * tableHeaderView;
@property (nonatomic, strong) NSArray * originalDatas;
@property (nonatomic, strong) NSDictionary * userInfo;

@end

@implementation SHMeRootController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.baseNavigationController hideBorder:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.baseNavigationController hideBorder:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的";
    
    [self createTableViewWithStyle:UITableViewStyleGrouped];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 16, 0, 0);
    self.enableRefresh = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"NormalCell"];
    
    self.tableHeaderView = [[MeRootHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 141)];
    self.tableView.tableHeaderView = self.tableHeaderView;
    
    kWeakSelf
    self.tableHeaderView.userInfoClickBlock = ^() {
        DLog(@"查看个人信息");
        kStrongSelf
        [strongSelf showUserInfo];
    };
    
    self.originalDatas = @[@{@"title" : @"我的申请",
                             @"image" : @"icon_apply",
                             @"sel" : @"goApplyRercord"},
                           @{@"title" : @"我的消息",
                             @"image" : @"icon_message",
                             @"sel" : @"goMessage"},
                           @{@"title" : @"设置",
                             @"image" : @"icon_setting",
                             @"sel" : @"goSetting"}];
    
    [SHBaseModel getUserInfoWithBlock:^(id response, id data, NSError *error) {
        if (!error) {
            self.userInfo = data;
            [[NSUserDefaults standardUserDefaults] setValue:esString(data[kUserName]) forKey:kUserName];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"userInfoChangedNotification" object:nil];
        }
    }];
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
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NormalCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = kFont(14);
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
        [self performSelector:action withObject:nil afterDelay:0.0f];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headerView = [TableViewDevider getViewWithHeight:10 margin:0 showTopLine:YES showBottomLine:NO];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (void)goSetting
{
    SettingController * settingController = [[SettingController alloc] init];
    settingController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:settingController animated:YES];
}

- (void)goApplyRercord
{
    [self showWaitingIcon];
    [SHBaseModel queryUserAuthStatusWithBlock:^(id response, id data, NSError *error) {
        [self dismissWaitingIcon];
        if (!error) {
            BOOL isApplySubmit = [data[@"isApplySubmit"] boolValue];
            if (isApplySubmit) {
                [self showWaitingIcon];
                [SHBaseModel getApplyListWithBlock:^(id response, id data, NSError *error) {
                    [self dismissWaitingIcon];
                    if (!error) {
                        SHProgressController * progressController = [[SHProgressController alloc] init];
                        progressController.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:progressController animated:YES];
                    }
                }];
                return;
            } else {
                [NSObject showMessage:@"暂无申请记录"];
            }
        } else {
            [NSObject showMessage:@"查询申请记录失败"];
        }
    }];
}

- (void)showUserInfo
{
    SHBasicProfileController * profileController = [[SHBasicProfileController alloc] init];
    profileController.userInfo = self.userInfo;
    profileController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:profileController animated:YES];
}

- (void)goMessage
{
    [NSObject showMessage:@"暂无消息"];
}

@end

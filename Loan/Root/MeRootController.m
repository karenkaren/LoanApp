//
//  MeRootController.m
//  LingTouNiaoLoan
//
//  Created by LiuFeifei on 16/12/29.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "MeRootController.h"
#import "MeRootHeaderView.h"
#import "SettingController.h"
#import "RecordController.h"
#import "ProfileController.h"

@interface MeRootController ()

@property (nonatomic, strong) MeRootHeaderView * tableHeaderView;
@property (nonatomic, strong) NSArray * originalDatas;

@end

@implementation MeRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的";
    
    [self createTableViewWithStyle:UITableViewStyleGrouped];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"NormalCell"];

    self.tableHeaderView = [[MeRootHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 130)];
    self.tableView.tableHeaderView = self.tableHeaderView;
//    [self.view layoutIfNeeded];
    
    kWeakSelf
//    self.tableHeaderView.myCarClickBlock = ^(UIButton * button) {
//        DLog(@"我的爱车");
//        kStrongSelf
//        [strongSelf showMyCar];
//    };
    
    self.tableHeaderView.userInfoClickBlock = ^(UIButton * button) {
        DLog(@"查看个人信息");
        kStrongSelf
        [strongSelf showUserInfo];
    };
    
    self.originalDatas = @[@{@"title" : @"我的申请",
                             @"image" : @"icon_account",
                             @"sel" : @"goApplyRercord"},
                           @{@"title" : @"浏览记录",
                             @"image" : @"icon_account",
                             @"sel" : @"goVisitRercord"},
                           @{@"title" : @"我的消息",
                             @"image" : @"icon_account",
                             @"sel" : @""},
                           @{@"title" : @"设置",
                             @"image" : @"icon_account",
                             @"sel" : @"goSetting"}];
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

- (void)goSetting
{
    SettingController * settingController = [[SettingController alloc] init];
    settingController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:settingController animated:YES];
}

- (void)goApplyRercord
{
    RecordController * recordController = [[RecordController alloc] initWithRecordType:RecordTypeOfApply];
    recordController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:recordController animated:YES];
}

- (void)goVisitRercord
{
    RecordController * recordController = [[RecordController alloc] initWithRecordType:RecordTypeOfVisit];
    recordController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:recordController animated:YES];
}

- (void)showUserInfo
{
    ProfileController * profileController = [[ProfileController alloc] init];
    profileController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:profileController animated:YES];
}

@end

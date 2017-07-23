//
//  SettingController.m
//  Loan
//
//  Created by 王安帮 on 2017/6/24.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "SettingController.h"
#import "BaseWebViewController.h"
#import "FeedbackController.h"
#import "ShareSnsUtils.h"
#import "NormalFooterView.h"

@interface SettingController ()

@property (nonatomic, strong) NSArray * originalDatas;

@end

@implementation SettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    
    [self createTableViewWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight - kStatusBarHeight) style:UITableViewStyleGrouped];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 16, 0, 0);
    self.enableRefresh = NO;
    self.tableView.tableFooterView = [self getTableFooterView];

    self.originalDatas = @[@[@{@"title" : @"意见反馈",
                               @"image" : @"icon_feedback",
                               @"sel" : @"goFeedback"},
                             @{@"title" : @"去评分",
                               @"image" : @"icon_score",
                               @"sel" : @"goAppStore"}],
                           @[@{@"title" : @"关于我们",
                               @"image" : @"icon_about",
                               @"sel" : @"goAboutUs"},
                             @{@"title" : @"帮助中心",
                               @"image" : @"icon_help",
                               @"sel" : @"goHelpCenter"},
                             @{@"title" : @"客服热线",
                               @"image" : @"icon_hotline",
                               @"sel" : @"callService:",
                               @"detail" : @"18000000000"},
                             @{@"title" : @"分享给好友",
                               @"image" : @"icon_share",
                               @"sel" : @"shareToFriends"},
                             @{@"title" : @"商务合作",
                               @"image" : @"icon_cooperation",
                               @"sel" : @"cooperate"}]];
}

- (UIView *)getTableFooterView
{
    NormalFooterView * footerView = [[NormalFooterView alloc] initWithTitle:@"退出登录"];
    footerView.height = 80;
    footerView.width = self.tableView.width;
    footerView.hideTopLine = YES;
    footerView.buttonClickBlock = ^(UIButton *button) {
        [[CurrentUser mine] reset];
        [[ControllersManager sharedControllersManager] setupProjectRootViewController];
    };

    return footerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.originalDatas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * rowsData = self.originalDatas[section];
    return rowsData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = kFont(14);
    NSDictionary * cellDic = self.originalDatas[indexPath.section][indexPath.row];
    cell.textLabel.text = cellDic[@"title"];
    cell.imageView.image = [UIImage imageNamed:cellDic[@"image"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * cellDic = self.originalDatas[indexPath.section][indexPath.row];
    SEL action = NSSelectorFromString(cellDic[@"sel"]);
    if ([self respondsToSelector:action]) {
        [self performSelector:action withObject:cellDic[@"detail"] afterDelay:0.0f];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section) {
        return 53;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (void)shareToFriends
{
    DLog(@"share");
    [[[ShareSnsUtils alloc] init] shareOnViewController:self];
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

- (void)goAboutUs
{
    BaseWebViewController * webController = [[BaseWebViewController alloc] initWithURL:@"https://www.baidu.com"];
    [self.navigationController pushViewController:webController animated:YES];
}

- (void)goHelpCenter
{
    BaseWebViewController * webController = [[BaseWebViewController alloc] initWithURL:@"https://www.51huawuyou.com/"];
    [self.navigationController pushViewController:webController animated:YES];
}

- (void)goFeedback
{
    FeedbackController * feedbackController = [[FeedbackController alloc] init];
    [self.navigationController pushViewController:feedbackController animated:YES];
}

- (void)cooperate
{
    [NSObject showMessage:@"敬请期待"];
}

@end

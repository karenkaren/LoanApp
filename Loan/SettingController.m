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

@interface SettingController ()<UMSocialUIDelegate>

@property (nonatomic, strong) NSArray * originalDatas;

@end

@implementation SettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    
    [self createTableViewWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight - kStatusBarHeight) style:UITableViewStyleGrouped];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
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
                               @"sel" : @""}]];
}

- (UIView *)getTableFooterView
{
    UIView * footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    
    UIButton * logoutButton = [UIButton createButtonWithTitle:@"退出登录" color:kBlackColor font:kFont(18) block:^(UIButton *button) {
        [[CurrentUser mine] reset];
        [[ControllersManager sharedControllersManager] setupProjectRootViewController];
    }];
    logoutButton.backgroundColor = kMainColor;
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
    return 10;
}

- (void)shareToFriends
{
    DLog(@"share");
    [ShareSnsUtils shareSnsOnViewController:self delegate:self];
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

@end

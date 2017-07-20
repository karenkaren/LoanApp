//
//  SHProgressController.m
//  Loan
//
//  Created by 王安帮 on 2017/7/19.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "SHProgressController.h"
#import "SHProgressCell.h"
#import "TableViewDevider.h"

@interface SHProgressController ()

@end

@implementation SHProgressController

- (void)back
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"申请进度";
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kAdaptiveBaseIphone6(50 + 36))];
    headerView.backgroundColor = kWhiteColor;
    
    UIImageView * headerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"step2"]];
    headerImageView.width = headerView.width - kAdaptiveBaseIphone6(41);
    headerImageView.height = kAdaptiveBaseIphone6(50);
    headerImageView.center = headerView.center;
    [headerView addSubview:headerImageView];
    
    self.tableView.tableHeaderView = headerView;
    self.enableRefresh = NO;
    self.tableView.scrollEnabled = NO;
    [self.tableView registerClass:[SHProgressCell class] forCellReuseIdentifier:@"Cell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHProgressCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHProgressCell * cell = [[SHProgressCell alloc] init];
    return [cell getCellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [TableViewDevider getViewWithHeight:10 margin:0 showTopLine:YES showBottomLine:NO];
}

@end

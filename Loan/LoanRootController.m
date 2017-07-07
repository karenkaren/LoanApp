//
//  LoanRootController.m
//  Loan
//
//  Created by 王安帮 on 2017/6/24.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "LoanRootController.h"
#import "LoanRootCell.h"
#import "ProductDetailController.h"
#import "FilterView.h"

@interface LoanRootController ()

@property (nonatomic, strong) NSMutableArray * productList;
@property (nonatomic, copy) NSString * tagString;

@end

@implementation LoanRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"贷款";
    
    FilterView * filterView = [[FilterView alloc] initWithFrame:self.view.bounds];
    [filterView setDefaultFilterType:FilterTypeALL filterChangedBlock:^(UIButton *button, NSString *keyString) {
        self.tagString = keyString;
        [self refreshAction];
    }];
    [self.view addSubview:filterView];
    
    self.tableView.frame = CGRectMake(0, filterView.bottom, kScreenWidth, self.view.height - filterView.height - kNavigationBarHeight - kTabBarHeight - kStatusBarHeight);
    [self.tableView registerClass:[LoanRootCell class] forCellReuseIdentifier:@"Cell"];
    self.tableView.backgroundColor = kColorD8D8D8;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.productList = [NSMutableArray array];

}

- (void)refreshAction
{
    if (self.currentPage == 0) {
        [self.productList removeAllObjects];
    } else {
        if (self.currentPage * self.pageSize >= self.totalCount) {
            [self.tableView.mj_footer endRefreshing];
            return;
        }
    }
    
    NSDictionary * params = @{@"currentPage" : @(self.currentPage), @"pageSize" : @(self.pageSize), @"tagString" : self.tagString};
    kWeakSelf
    if (![self isRefreshing]) {
        [self showWaitingIcon];
    }
    [ProductModel getLoanQueryListWithParams:params block:^(id response, NSArray *productList, NSInteger totalCount, NSError *error) {
        kStrongSelf
        [strongSelf stopRefresh];
        [strongSelf dismissWaitingIcon];
        if (productList && totalCount) {
            strongSelf.totalCount = totalCount;
            [strongSelf.productList addObjectsFromArray:productList];
        }
        [strongSelf.tableView reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.productList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoanRootCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.product = self.productList[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoanRootCell * cell = [[LoanRootCell alloc] init];
    return [cell getCellHeightWithProduct:self.productList[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductDetailController * productDetailController = [[ProductDetailController alloc] initWithProduct:self.productList[indexPath.row]];
    productDetailController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:productDetailController animated:YES];
}

@end

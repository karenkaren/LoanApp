//
//  BaseTableViewController.m
//  XiChe
//
//  Created by LiuFeifei on 17/4/2.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)createTableViewWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    [self.tableView removeFromSuperview];
    self.tableView = nil;
    self.tableView = [[UITableView alloc] initWithFrame:frame style:style];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.backgroundColor = kBackgroundColor;
    [self setEnableFooterRefresh:self.enableFooterRefresh];
    [self setEnableHeaderRefresh:self.enableHeaderRefresh];
    [self.view addSubview:self.tableView];
}

- (void)createTableViewWithStyle:(UITableViewStyle)style
{
    [self.tableView removeFromSuperview];
    self.tableView = nil;

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight - kTabBarHeight - kStatusBarHeight) style:style];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.backgroundColor = kBackgroundColor;
    [self setEnableFooterRefresh:self.enableFooterRefresh];
    [self setEnableHeaderRefresh:self.enableHeaderRefresh];
    [self.view addSubview:self.tableView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self createTableViewWithStyle:UITableViewStylePlain];
    self.enableFooterRefresh = YES;
    self.enableHeaderRefresh = YES;
    self.pageSize = 20;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}

- (void)setEnableHeaderRefresh:(BOOL)enableHeaderRefresh
{
    _enableHeaderRefresh = enableHeaderRefresh;
    
    if (enableHeaderRefresh) {
        kWeakSelf
        // 下拉刷新
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            kStrongSelf
            strongSelf.currentPage = 0;
            [strongSelf refreshAction];
        }];
    } else {
        self.tableView.mj_header = nil;
    }
}

- (void)setEnableFooterRefresh:(BOOL)enableFooterRefresh
{
    _enableFooterRefresh = enableFooterRefresh;
    
    if (enableFooterRefresh) {
        // 上拉刷新
        kWeakSelf
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            kStrongSelf
            strongSelf.currentPage++;
            [strongSelf refreshAction];
        }];
    } else {
        self.tableView.mj_footer = nil;
    }
}

- (void)setEnableRefresh:(BOOL)enableRefresh
{
    _enableRefresh = enableRefresh;
    self.enableHeaderRefresh = enableRefresh;
    self.enableFooterRefresh = enableRefresh;
}

- (void)refreshAction
{
}

- (void)startRefresh
{
    [self.tableView.mj_header beginRefreshing];
}

- (void)stopRefresh
{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (BOOL)isRefreshing
{
    if ([self.tableView.mj_header isRefreshing]) {
        return YES;
    }
    if ([self.tableView.mj_footer isRefreshing]) {
        return YES;
    }
    return NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end

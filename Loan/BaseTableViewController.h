//
//  BaseTableViewController.h
//  XiChe
//
//  Created by LiuFeifei on 17/4/2.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

#import "BaseViewController.h"
#import "MJRefresh.h"

@interface BaseTableViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger totalCount;

//@property (assign) BOOL hideRefreshHeader;
//@property (assign) BOOL hideLoadingView;
//@property (nonatomic,assign) LoadingViewState loadingViewState;

@property (nonatomic, strong) UITableView * tableView;
- (void)createTableViewWithFrame:(CGRect)frame style:(UITableViewStyle)style;
- (void)createTableViewWithStyle:(UITableViewStyle)style;

@property (nonatomic, assign) BOOL enableHeaderRefresh;
@property (nonatomic, assign) BOOL enableFooterRefresh;
- (void)refreshAction;
- (void)startRefresh;
- (void)stopRefresh;
- (BOOL)isRefreshing;

@end

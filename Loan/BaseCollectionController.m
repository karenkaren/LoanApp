//
//  BaseCollectionController.m
//  Loan
//
//  Created by 王安帮 on 2017/6/24.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "BaseCollectionController.h"

@interface BaseCollectionController ()

@end

@implementation BaseCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(100, 100);
    [self createCollectionViewWithCollectionViewLayout:layout];
    self.pageSize = 20;
    self.enableFooterRefresh = YES;
    self.enableHeaderRefresh = YES;
}

- (void)createCollectionViewWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    [self.collectionView removeFromSuperview];
    self.collectionView = nil;
    self.collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = kWhiteColor;
    [self setEnableFooterRefresh:self.enableFooterRefresh];
    [self setEnableHeaderRefresh:self.enableHeaderRefresh];
    [self.view addSubview:self.collectionView];
}

- (void)createCollectionViewWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    [self.collectionView removeFromSuperview];
    self.collectionView = nil;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight - kTabBarHeight - kStatusBarHeight) collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = kWhiteColor;
    [self setEnableFooterRefresh:self.enableFooterRefresh];
    [self setEnableHeaderRefresh:self.enableHeaderRefresh];
    [self.view addSubview:self.collectionView];
}

- (void)setEnableHeaderRefresh:(BOOL)enableHeaderRefresh
{
    _enableHeaderRefresh = enableHeaderRefresh;
    
    if (enableHeaderRefresh) {
        kWeakSelf
        // 下拉刷新
        self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            kStrongSelf
            strongSelf.currentPage = 0;
            [strongSelf refreshAction];
        }];
    } else {
        self.collectionView.mj_header = nil;
    }
}

- (void)setEnableFooterRefresh:(BOOL)enableFooterRefresh
{
    _enableFooterRefresh = enableFooterRefresh;
    
    if (enableFooterRefresh) {
        // 上拉刷新
        kWeakSelf
        self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            kStrongSelf
            strongSelf.currentPage++;
            [strongSelf refreshAction];
        }];
    } else {
        self.collectionView.mj_footer = nil;
    }
}

- (void)refreshAction
{
}

- (void)startRefresh
{
    [self.collectionView.mj_header beginRefreshing];
}

- (void)stopRefresh
{
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
}

- (BOOL)isRefreshing
{
    if ([self.collectionView.mj_header isRefreshing]) {
        return YES;
    }
    if ([self.collectionView.mj_footer isRefreshing]) {
        return YES;
    }
    return NO;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end

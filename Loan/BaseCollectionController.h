//
//  BaseCollectionController.h
//  Loan
//
//  Created by 王安帮 on 2017/6/24.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "BaseViewController.h"
#import "MJRefresh.h"

@interface BaseCollectionController : BaseViewController<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger totalCount;

@property (nonatomic, strong) UICollectionView * collectionView;
- (void)createCollectionViewWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout;
- (void)createCollectionViewWithCollectionViewLayout:(UICollectionViewLayout *)layout;

@property (nonatomic, assign) BOOL enableHeaderRefresh;
@property (nonatomic, assign) BOOL enableFooterRefresh;
- (void)refreshAction;
- (void)startRefresh;
- (void)stopRefresh;

@end

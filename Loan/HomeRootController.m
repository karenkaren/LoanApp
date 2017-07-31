//
//  HomeRootController.m
//  XiChe
//
//  Created by LiuFeifei on 17/4/2.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

#import "HomeRootController.h"
#import "HomeRootHeaderView.h"
//#import "HomeModel.h"
#import "HomeRootCell.h"
#import "ProductDetailController.h"
#import "BaseWebViewController.h"

@interface HomeRootController ()

@property (nonatomic, strong) HomeRootHeaderView * homeRootHeaderView;
@property (nonatomic, strong) NSMutableArray<ProductModel *> * productList;
//@property (nonatomic, strong) BMKLocationService * locService;
//@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end

@implementation HomeRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"神马贷款";
    
//    self.coordinate = CLLocationCoordinate2DMake(39.915, 116.404);
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(kScreenWidth / 4.0, kScreenWidth / 4.0);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    [self createCollectionViewWithCollectionViewLayout:layout];
    
    [self.collectionView registerClass:[HomeRootHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [self.collectionView registerClass:[HomeRootCell class] forCellWithReuseIdentifier:@"Cell"];
    
//    //初始化BMKLocationService
//    _locService = [[BMKLocationService alloc]init];
//    _locService.delegate = self;
//    //启动LocationService
//    [_locService startUserLocationService];
    
    self.productList = [NSMutableArray array];
    [self refreshAction];

}

- (void)refreshAction
{
    if (self.currentPage == 0) {
        [self.productList removeAllObjects];
    } else {
        if (self.currentPage * self.pageSize >= self.totalCount) {
            [self.collectionView.mj_footer endRefreshing];
            return;
        }
    }
    
    if (![self isRefreshing]) {
        [self showWaitingIcon];
    }
    NSDictionary * params = @{@"currentPage" : @(self.currentPage), @"pageSize" : @(self.pageSize)};
    kWeakSelf
    [ProductModel getLoanListWithParams:params block:^(id response, NSArray *productList, NSInteger totalCount, NSError *error) {
        kStrongSelf
        [strongSelf dismissWaitingIcon];
        [strongSelf stopRefresh];
        if (productList && totalCount) {
            strongSelf.totalCount = totalCount;
            [strongSelf.productList addObjectsFromArray:productList];
            [strongSelf.collectionView reloadData];
        }
    }];
    
    [BannerModel getBannerListWithBlock:^(id response, id data, NSError *error) {
        if (data) {
            [self.homeRootHeaderView refreshHeaderViewWithBanners:data];
        }
    }];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    self.homeRootHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    kWeakSelf
    self.homeRootHeaderView.selectedBannerBlock = ^(BannerModel *banner) {
        kStrongSelf
        if (![NSString isEmpty:banner.linkUrl]) {
            BaseWebViewController * webViewController = [[BaseWebViewController alloc] initWithURL:banner.linkUrl];
            webViewController.hidesBottomBarWhenPushed = YES;
            [strongSelf.navigationController pushViewController:webViewController animated:YES];
        }
        
    };
    
    return self.homeRootHeaderView;
}

// 设置section头视图的参考大小，与tableheaderview类似
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(kScreenWidth, 212);
    }
    else {
        return CGSizeMake(0, 0);
    }
}

//- (void)getHomeDataWithCoordinate:(CLLocationCoordinate2D)coordinate
//{
////    NSDictionary * dic = @{@"latitude" : @(coordinate.latitude), @"longitude" : @(coordinate.longitude)};
//    
//    [HomeModel getHomeInfo:nil block:^(id response, id data, NSError *error) {
//        if (data) {
//            HomeModel * homeModel = (HomeModel *)data;
//            self.platformList = homeModel.platformList;
//            [self.collectionView reloadData];
//        }
//    }];
//}

////处理位置坐标更新
//- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
//{
//    CLLocationCoordinate2D coordinate = userLocation.location. coordinate;
//    [self getHomeDataWithCoordinate:coordinate];
//    NSDictionary * dic = @{@"latitude" : @(coordinate.latitude), @"longitude" : @(coordinate.longitude)};
//    [[CurrentUser mine] postLocation:dic block:nil];
//    [_locService stopUserLocationService];
//}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.productList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeRootCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.product = self.productList[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductModel * product = self.productList[indexPath.row];
    BaseWebViewController * webController = [[BaseWebViewController alloc] initWithURL:product.h5link];
    webController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webController animated:YES];
    
//    ProductDetailController * productDetailController = [[ProductDetailController alloc] initWithProduct:self.productList[indexPath.row]];
//    productDetailController.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:productDetailController animated:YES];
}

@end

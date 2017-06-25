//
//  HomeRootController.m
//  XiChe
//
//  Created by LiuFeifei on 17/4/2.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

#import "HomeRootController.h"
#import "HomeRootHeaderView.h"
#import "HomeModel.h"
#import "HomeRootCell.h"

@interface HomeRootController ()<BMKLocationServiceDelegate>

@property (nonatomic, strong) HomeRootHeaderView * homeRootHeaderView;
@property (nonatomic, strong) NSArray<PlatformModel *> * platformList;
//@property (nonatomic, strong) BMKLocationService * locService;
//@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end

@implementation HomeRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    
//    self.coordinate = CLLocationCoordinate2DMake(39.915, 116.404);
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(kScreenWidth / 3.0, kScreenWidth / 3.0);
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
    
    // todo:test
    NSMutableArray * plarformList = [NSMutableArray arrayWithCapacity:30];
    for (int i = 0; i < 30; i++) {
        PlatformModel * platform = [[PlatformModel alloc] init];
        platform.platformName = [NSString stringWithFormat:@"领投鸟%d", arc4random_uniform(100)];
        platform.plarformIconUrl = @"logo";
        platform.plarformType = arc4random_uniform(3);
        [plarformList addObject:platform];
    }
    self.platformList = plarformList;

}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    self.homeRootHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    
    return self.homeRootHeaderView;
}

// 设置section头视图的参考大小，与tableheaderview类似
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(kScreenWidth, 180);
    }
    else {
        return CGSizeMake(0, 0);
    }
}

- (void)getHomeDataWithCoordinate:(CLLocationCoordinate2D)coordinate
{
//    NSDictionary * dic = @{@"latitude" : @(coordinate.latitude), @"longitude" : @(coordinate.longitude)};
    
    [HomeModel getHomeInfo:nil block:^(id response, id data, NSError *error) {
        if (data) {
            HomeModel * homeModel = (HomeModel *)data;
            self.platformList = homeModel.platformList;
            [self.collectionView reloadData];
        }
    }];
}

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
    return self.platformList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeRootCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.platformInfo = self.platformList[indexPath.row];
    return cell;
}

@end

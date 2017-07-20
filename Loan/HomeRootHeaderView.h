//
//  HomeRootHeaderView.h
//  XiChe
//
//  Created by LiuFeifei on 2017/4/14.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BannerView.h"

@interface HomeRootHeaderView : UICollectionReusableView

@property (nonatomic, copy) void(^selectedBannerBlock)(BannerModel * banner);
- (void)refreshHeaderViewWithBanners:(NSArray<BannerModel *> *)banners;

@end

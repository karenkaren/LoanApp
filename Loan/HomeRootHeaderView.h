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

- (void)refreshHeaderViewWithBanners:(NSArray<BannerModel *> *)banners;

@end

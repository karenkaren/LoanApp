//
//  BannerView.h
//  横幅
//
//  Created by LiuFeifei on 15/11/16.
//  Copyright © 2015年 lingtouniao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BannerModel.h"

@class BannerView;
@protocol BannerViewDelegate <NSObject>

@optional
- (void)bannerView:(BannerView *)bannerView banner:(BannerModel *)banner;

@end

@interface BannerView : UIView

@property (nonatomic, weak) id<BannerViewDelegate> delegate;
@property (nonatomic, strong)  NSArray<BannerModel *> * bannersList;

@end

//
//  BaseCollectionController.h
//  Loan
//
//  Created by 王安帮 on 2017/6/24.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseCollectionController : BaseViewController<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView * collectionView;
- (void)createCollectionViewWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout;
- (void)createCollectionViewWithCollectionViewLayout:(UICollectionViewLayout *)layout;

@end

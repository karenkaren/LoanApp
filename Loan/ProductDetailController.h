//
//  ProductDetailController.h
//  Loan
//
//  Created by 王安帮 on 2017/6/25.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "BaseTableViewController.h"
#import "ProductModel.h"

@interface ProductDetailController : BaseTableViewController

@property (nonatomic, strong) ProductModel * product;
- (instancetype)initWithProduct:(ProductModel *)product;

@end

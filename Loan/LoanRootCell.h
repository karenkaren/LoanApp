//
//  LoanRootCell.h
//  Loan
//
//  Created by 王安帮 on 2017/6/24.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"

@interface LoanRootCell : UITableViewCell

@property (nonatomic, strong) ProductModel * product;

- (CGFloat)getCellHeightWithProduct:(ProductModel *)product;

@end

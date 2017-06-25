//
//  RecordCell.h
//  Loan
//
//  Created by 王安帮 on 2017/6/25.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"

@interface RecordCell : UITableViewCell

@property (nonatomic, strong) ProductModel * product;

- (CGFloat)getCellHeightWithProduct:(ProductModel *)product;

@end

//
//  ProductDetailCell.h
//  Loan
//
//  Created by 王安帮 on 2017/6/25.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ProductDetailCellStyleUnknow,
    ProductDetailCellStyleImage,
    ProductDetailCellStyleText
} ProductDetailCellStyle;

@interface ProductDetailCell : UITableViewCell

@property (nonatomic, strong) NSDictionary * detailData;
- (CGFloat)getCellHeightWithData:(NSDictionary *)data;

@end

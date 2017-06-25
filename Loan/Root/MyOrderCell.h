//
//  MyOrderCell.h
//  XiChe
//
//  Created by LiuFeifei on 2017/4/12.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyOrderCell;
@protocol MyOrderCellDelegate <NSObject>

- (void)myOrderCell:(MyOrderCell *)myOrderCell dataIndex:(NSInteger)dataIndex;

@end

@interface MyOrderCell : UITableViewCell

@property (nonatomic, strong) NSArray * datas;
@property (nonatomic, weak) id<MyOrderCellDelegate> delegate;

@end

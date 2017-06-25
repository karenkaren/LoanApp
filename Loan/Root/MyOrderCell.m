//
//  MyOrderCell.m
//  XiChe
//
//  Created by LiuFeifei on 2017/4/12.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

#import "MyOrderCell.h"

@implementation MyOrderCell

- (void)setDatas:(NSArray *)datas
{
    _datas = datas;
    if (isArray(datas)) {
        [self addAllSubviews];
    }
}

- (void)addAllSubviews
{
    for (UIView * subview in self.contentView.subviews) {
        [subview removeFromSuperview];
    }
    
    CGFloat width = self.width / _datas.count;
    for (int i = 0; i < _datas.count; i++) {
        kWeakSelf
        UIButton * button = [UIButton createButtonWithTitle:esString(_datas[i]) color:kTextColor font:kFont(18) block:^(UIButton *button) {
            kStrongSelf
            if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(myOrderCell:dataIndex:)]) {
                [strongSelf.delegate myOrderCell:strongSelf dataIndex:button.tag];
            }
        }];
        button.tag = i;
        button.frame = CGRectMake(i * width, 0, width, self.height);
        button.backgroundColor = kRandomColor;
        [self.contentView addSubview:button];
    }
}

@end

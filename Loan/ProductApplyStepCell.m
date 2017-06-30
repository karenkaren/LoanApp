//
//  ProductApplyStepCell.m
//  Loan
//
//  Created by 王安帮 on 2017/6/30.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "ProductApplyStepCell.h"

@implementation ProductApplyStepCell

- (void)setApplyStepArray:(NSArray *)applyStepArray
{
    _applyStepArray = applyStepArray;
    
    for (UIView * subview in self.contentView.subviews) {
        [subview removeFromSuperview];
    }
    
    CGFloat margin = kScreenWidth / (applyStepArray.count * 2 * 2 - 1);
    for (int i = 0; i < applyStepArray.count * 2 - 1; i++) {
        UIImageView * imageView = [[UIImageView alloc] init];
        NSString * imageName = i % 2 ? @"icon_arrow.png" : @"icon_smiling.png";
        imageView.image = [UIImage imageNamed:imageName];
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(margin + margin * i * 2);
            make.top.equalTo(self.contentView).offset(5);
            make.size.mas_equalTo(CGSizeMake(margin, margin));
        }];
        
        if (i % 2) {
            NSDictionary * dic = applyStepArray[i / 2];
            UILabel * titleLabel = [[UILabel alloc] init];
            titleLabel.text = esString(dic[@"stepName"]);
            [titleLabel sizeToFit];
            [self.contentView addSubview:titleLabel];
            
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(imageView.mas_bottom).offset(5);
                make.centerX.equalTo(imageView);
            }];
        }
    }
}

@end

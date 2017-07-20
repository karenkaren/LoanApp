//
//  SHProgressCell.m
//  Loan
//
//  Created by 王安帮 on 2017/7/20.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "SHProgressCell.h"

@implementation SHProgressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.layer.borderColor = kLineColor.CGColor;
        self.layer.borderWidth = kLineThick;
        
        [self addAllSubviews];
    }
    return self;
}

- (void)addAllSubviews
{
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"reviewing"]];
    [self.contentView addSubview:imageView];
    
    UILabel * titleLabel = [UILabel createLabelWithText:@"审批中..." font:kFont(18) color:kBlackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:titleLabel];
    
    NSString * appleDate = [[NSUserDefaults standardUserDefaults] valueForKey:@"applyDate"];
    NSString * content = [NSString stringWithFormat:@"申请提交时间：%@\n审批结果在1-2个工作日内给出，如遇节假日或周末顺延。超过3个工作日请联系客服",appleDate];
    UILabel * contentLabel = [UILabel createLabelWithText:content font:kFont(14) color:kColor666666];
    contentLabel.numberOfLines = 0;
    contentLabel.textAlignment = NSTextAlignmentCenter;
    [contentLabel changeLineSpace:6];
    [self.contentView addSubview:contentLabel];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(31);
        make.centerX.equalTo(self.contentView);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(20);
        make.width.centerX.equalTo(self.contentView);
        make.height.equalTo(@18);
    }];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(9);
        make.width.equalTo(@288);
        make.centerX.equalTo(self.contentView);
        make.height.greaterThanOrEqualTo(@22);
    }];
}

- (CGFloat)getCellHeight
{
    [self layoutIfNeeded];
    [self setNeedsLayout];
    
    return self.contentView.subviews.lastObject.bottom + 37;
}

@end

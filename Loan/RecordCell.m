//
//  RecordCell.m
//  Loan
//
//  Created by 王安帮 on 2017/6/25.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "RecordCell.h"
#import "UIImageView+WebCache.h"

@interface RecordCell ()

@property (nonatomic, strong) UIImageView * iconImageView;
@property (nonatomic, strong) UILabel * productNameLabel;
@property (nonatomic, strong) UILabel * descLabel;
@property (nonatomic, strong) UILabel * limitRangeLabel;
@property (nonatomic, strong) UILabel * interestRateLabel;

@end

@implementation RecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = kBackgroundColor;
        [self addAllSubviews];
    }
    return self;
}

- (void)addAllSubviews
{
    UIView * backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = kWhiteColor;
    [self.contentView addSubview:backgroundView];
    
    UIView * topLineView = [[UIView alloc] init];
    topLineView.backgroundColor = kLineColor;
    [backgroundView addSubview:topLineView];
    
    self.iconImageView = [[UIImageView alloc] init];
    [backgroundView addSubview:self.iconImageView];
    
    self.productNameLabel = [[UILabel alloc] init];
    self.productNameLabel.font = kFont(14);
    [backgroundView addSubview:self.productNameLabel];
    
    self.descLabel = [[UILabel alloc] init];
    self.descLabel.font = kFont(12);
    self.descLabel.textColor = kColor999999;
//    self.descLabel.numberOfLines = 0;
    [backgroundView addSubview:self.descLabel];
    
    UIImageView * arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_arrow"]];
    [backgroundView addSubview:arrowImageView];
    
    UIView * separatorLineView = [[UIView alloc] init];
    separatorLineView.backgroundColor = kLineColor;
    [backgroundView addSubview:separatorLineView];
    
    UILabel * limitRangeTitleLabel = [[UILabel alloc] init];
    limitRangeTitleLabel.font = kFont(12);
    limitRangeTitleLabel.textColor = kColor999999;
    limitRangeTitleLabel.text = @"额度范围";
    [backgroundView addSubview:limitRangeTitleLabel];
    
    self.limitRangeLabel = [[UILabel alloc] init];
    self.limitRangeLabel.font = kFont(12);
    self.limitRangeLabel.textColor = [UIColor redColor];
    [backgroundView addSubview:self.limitRangeLabel];
    
    UILabel * interestRateTitleLabel = [[UILabel alloc] init];
    interestRateTitleLabel.font = kFont(12);
    interestRateTitleLabel.textColor = kColor999999;
    interestRateTitleLabel.text = @"日利率";
    [backgroundView addSubview:interestRateTitleLabel];
    
    self.interestRateLabel = [[UILabel alloc] init];
    self.interestRateLabel.font = kFont(12);
    self.interestRateLabel.textColor = [UIColor redColor];
    [backgroundView addSubview:self.interestRateLabel];
    
    UIView * bottomLineView = [[UIView alloc] init];
    bottomLineView.backgroundColor = kLineColor;
    [backgroundView addSubview:bottomLineView];

    UIView * superView = self.contentView;
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.equalTo(superView);
        make.height.equalTo(superView).offset(-10);
    }];
    
    superView = backgroundView;
    [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.top.equalTo(superView);
        make.height.equalTo(@(kLineThick));
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(superView).offset(30);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.productNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.iconImageView.mas_centerY).offset(-5);
        make.left.equalTo(self.iconImageView.mas_right).offset(30);
        make.right.lessThanOrEqualTo(arrowImageView.mas_left).offset(-5);
        make.height.equalTo(@14);
    }];
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.mas_centerY).offset(5);
        make.left.equalTo(self.productNameLabel);
        make.right.lessThanOrEqualTo(arrowImageView.mas_left).offset(-5);
        make.height.equalTo(@12);
    }];
    
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(superView.mas_right).offset(-kCommonMargin);
        make.centerY.equalTo(self.iconImageView);
        make.size.mas_equalTo(CGSizeMake(8, 15));
    }];
    
    [separatorLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(superView);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(30);
        make.height.equalTo(@(kLineThick));
    }];
    
    [limitRangeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView);
        make.top.equalTo(separatorLineView.mas_bottom).offset(10);
        make.height.equalTo(@12);
        make.width.lessThanOrEqualTo(superView);
    }];
    
    [self.limitRangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(limitRangeTitleLabel);
        make.left.equalTo(limitRangeTitleLabel.mas_right).offset(5);
        make.height.equalTo(@12);
        make.width.lessThanOrEqualTo(superView);
    }];
    
    [interestRateTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.interestRateLabel.mas_left).offset(-5);
        make.centerY.equalTo(limitRangeTitleLabel);
        make.width.lessThanOrEqualTo(superView);
        make.height.equalTo(@12);
    }];
    
    [self.interestRateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(arrowImageView);
        make.centerY.equalTo(limitRangeTitleLabel);
        make.width.lessThanOrEqualTo(superView);
        make.height.equalTo(@12);
    }];
    
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(topLineView);
        make.top.equalTo(limitRangeTitleLabel.mas_bottom).offset(10);
    }];
}

- (void)setProduct:(ProductModel *)product
{
    _product = product;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:product.cloanLogo] placeholderImage:[UIImage imageNamed:@"logo"] options:SDWebImageRetryFailed];
    self.productNameLabel.text = product.cloanName;
    self.descLabel.text = @"测试测试测试放得开见风使舵雷锋精神的雷锋精神的老骥伏枥是大家发圣诞快乐飞机数量达到了房间里大煞风景的是离开";
    self.limitRangeLabel.text = @"500-5000元";
    self.interestRateLabel.text = [NSString stringWithFormat:@"%.2f%%", product.dayRate];
    
    [self layoutIfNeeded];
    [self setNeedsLayout];
}

- (CGFloat)getCellHeightWithProduct:(ProductModel *)product
{
    self.product = product;
    return self.interestRateLabel.bottom + 10 + 10;
}

@end

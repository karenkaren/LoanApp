//
//  ProductDetailHeaderView.m
//  Loan
//
//  Created by 王安帮 on 2017/6/25.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "ProductDetailHeaderView.h"
#import "UIImageView+WebCache.h"

@implementation ProductDetailHeaderView

- (instancetype)initWithProduct:(ProductModel *)product
{
    self = [super init];
    if (self) {
        self.product = product;
        self.backgroundColor = kWhiteColor;
        [self addAllSubviews];
    }
    return self;
}

- (void)addAllSubviews
{
    UIImageView * iconImageVIew = [[UIImageView alloc] init];
    [iconImageVIew sd_setImageWithURL:[NSURL URLWithString:self.product.cloanLogo] placeholderImage:[UIImage imageNamed:@"logo"] options:SDWebImageRetryFailed];
    [self addSubview:iconImageVIew];
    
    UILabel * productNameLabel = [[UILabel alloc] init];
    productNameLabel.text = self.product.cloanName;
    productNameLabel.font = kBoldFont(16);
    [self addSubview:productNameLabel];
    
    UILabel * applyNumLabel = [[UILabel alloc] init];
    applyNumLabel.text = [NSString stringWithFormat:@"申请人数：%ld", self.product.applyCustomer];
    applyNumLabel.font = kFont(12);
    [self addSubview:applyNumLabel];
    
    UILabel * loanRangeTitleLabel = [[UILabel alloc] init];
    loanRangeTitleLabel.font = kFont(13);
    loanRangeTitleLabel.textAlignment = NSTextAlignmentCenter;
    loanRangeTitleLabel.text = @"贷款范围";
    [self addSubview:loanRangeTitleLabel];
    
    UILabel * loanRangeLabel = [[UILabel alloc] init];
    loanRangeLabel.font = kFont(13);
    loanRangeLabel.textAlignment = NSTextAlignmentCenter;
    loanRangeLabel.text = self.product.loanRange;
    [self addSubview:loanRangeLabel];
    
    UILabel * deadlineRangeTitleLabel = [[UILabel alloc] init];
    deadlineRangeTitleLabel.font = kFont(13);
    deadlineRangeTitleLabel.textAlignment = NSTextAlignmentCenter;
    deadlineRangeTitleLabel.text = @"期限范围";
    [self addSubview:deadlineRangeTitleLabel];
    
    UILabel * deadlineRangeLabel = [[UILabel alloc] init];
    deadlineRangeLabel.font = kFont(13);
    deadlineRangeLabel.textAlignment = NSTextAlignmentCenter;
    deadlineRangeLabel.text = self.product.dateRange;
    [self addSubview:deadlineRangeLabel];
    
    UILabel * interestRateTitleLabel = [[UILabel alloc] init];
    interestRateTitleLabel.font = kFont(13);
    interestRateTitleLabel.textAlignment = NSTextAlignmentCenter;
    interestRateTitleLabel.text = @"利率范围";
    [self addSubview:interestRateTitleLabel];
    
    UILabel * interestRateLabel = [[UILabel alloc] init];
    interestRateLabel.font = kFont(13);
    interestRateLabel.textAlignment = NSTextAlignmentCenter;
    interestRateLabel.text = self.product.rateRange;
    [self addSubview:interestRateLabel];
    
    UIView * topLineView = [[UIView alloc] init];
    topLineView.backgroundColor = kLineColor;
    [self addSubview:topLineView];
    
    UIView * bottomLineView = [[UIView alloc] init];
    bottomLineView.backgroundColor = kLineColor;
    [self addSubview:bottomLineView];
    
    UIView * firstVertialLineView = [[UIView alloc] init];
    firstVertialLineView.backgroundColor = kLineColor;
    [self addSubview:firstVertialLineView];
    
    UIView * secondVertialLineView = [[UIView alloc] init];
    secondVertialLineView.backgroundColor = kLineColor;
    [self addSubview:secondVertialLineView];
    
    UIView * bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = kBackgroundColor;
    [self addSubview:bottomView];
    
    [iconImageVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(27);
        make.left.equalTo(self).offset(20);
        make.size.mas_offset(CGSizeMake(40, 40));
    }];
    
    [productNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImageVIew.mas_right).offset(29);
        make.top.equalTo(self).offset(28);
        make.width.lessThanOrEqualTo(self).offset(-2 * 20 - 28 - 40);
        make.height.equalTo(@16);
    }];
    
    [applyNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(productNameLabel);
        make.top.equalTo(productNameLabel.mas_bottom).offset(9);
        make.width.lessThanOrEqualTo(self).offset(-2 * 20 - 28 - 40);
        make.height.equalTo(@12);
    }];
    
    [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self);
        make.top.equalTo(iconImageVIew.mas_bottom).offset(27);
        make.height.equalTo(@(kLineThick));
    }];
    
    [loanRangeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(topLineView.mas_bottom).offset(14);
        make.width.equalTo(self).multipliedBy(1.0 / 3.0);
        make.height.equalTo(@13);
    }];
    
    [loanRangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(loanRangeTitleLabel);
        make.top.equalTo(loanRangeTitleLabel.mas_bottom).offset(8);
    }];
    
    [deadlineRangeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(loanRangeTitleLabel);
        make.left.equalTo(loanRangeTitleLabel.mas_right);
    }];
    
    [deadlineRangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(deadlineRangeTitleLabel);
        make.top.equalTo(deadlineRangeTitleLabel.mas_bottom).offset(8);
    }];
    
    [interestRateTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(deadlineRangeTitleLabel);
        make.left.equalTo(deadlineRangeTitleLabel.mas_right);
    }];
    
    [interestRateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(interestRateTitleLabel);
        make.top.equalTo(interestRateTitleLabel.mas_bottom).offset(8);
    }];
    
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(topLineView);
        make.top.equalTo(loanRangeLabel.mas_bottom).offset(14);
    }];
    
    [firstVertialLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(loanRangeTitleLabel.mas_right);
        make.top.equalTo(topLineView.mas_bottom);
        make.width.equalTo(@(kLineThick));
        make.height.equalTo(@(14 + 13 + 8 + 13 + 14));
    }];
    
    [secondVertialLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(firstVertialLineView);
        make.left.equalTo(deadlineRangeTitleLabel.mas_right);
    }];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self);
        make.top.equalTo(bottomLineView.mas_bottom);
        make.height.equalTo(@10);
    }];
}

- (CGFloat)getHeaderViewHeight
{
    [self layoutIfNeeded];
    [self setNeedsLayout];
    
    return self.subviews.lastObject.bottom;
}

@end

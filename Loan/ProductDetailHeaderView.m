//
//  ProductDetailHeaderView.m
//  Loan
//
//  Created by 王安帮 on 2017/6/25.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "ProductDetailHeaderView.h"

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
    UIImageView * iconImageVIew = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.product.cloanLogo]];
    [self addSubview:iconImageVIew];
    
    UILabel * productNameLabel = [[UILabel alloc] init];
    productNameLabel.text = self.product.cloanName;
    productNameLabel.font = kFont(18);
    [self addSubview:productNameLabel];
    
    UILabel * applyNumLabel = [[UILabel alloc] init];
    applyNumLabel.text = [NSString stringWithFormat:@"申请人数：%ld", self.product.applyCustomer];
    applyNumLabel.font = kFont(14);
    [self addSubview:applyNumLabel];
    
    UILabel * loanRangeTitleLabel = [[UILabel alloc] init];
    loanRangeTitleLabel.font = kFont(14);
    loanRangeTitleLabel.textAlignment = NSTextAlignmentCenter;
    loanRangeTitleLabel.text = @"贷款范围";
    [self addSubview:loanRangeTitleLabel];
    
    UILabel * loanRangeLabel = [[UILabel alloc] init];
    loanRangeLabel.font = kFont(14);
    loanRangeLabel.textAlignment = NSTextAlignmentCenter;
    loanRangeLabel.text = @"1000~3000元";
    [self addSubview:loanRangeLabel];
    
    UILabel * deadlineRangeTitleLabel = [[UILabel alloc] init];
    deadlineRangeTitleLabel.font = kFont(14);
    deadlineRangeTitleLabel.textAlignment = NSTextAlignmentCenter;
    deadlineRangeTitleLabel.text = @"期限范围";
    [self addSubview:deadlineRangeTitleLabel];
    
    UILabel * deadlineRangeLabel = [[UILabel alloc] init];
    deadlineRangeLabel.font = kFont(14);
    deadlineRangeLabel.textAlignment = NSTextAlignmentCenter;
    deadlineRangeLabel.text = @"7天";
    [self addSubview:deadlineRangeLabel];
    
    UILabel * interestRateTitleLabel = [[UILabel alloc] init];
    interestRateTitleLabel.font = kFont(14);
    interestRateTitleLabel.textAlignment = NSTextAlignmentCenter;
    interestRateTitleLabel.text = @"利率范围";
    [self addSubview:interestRateTitleLabel];
    
    UILabel * interestRateLabel = [[UILabel alloc] init];
    interestRateLabel.font = kFont(14);
    interestRateLabel.textAlignment = NSTextAlignmentCenter;
    interestRateLabel.text = [NSString stringWithFormat:@"%.2f%%", self.product.dayRate];
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
    bottomView.backgroundColor = kColorD8D8D8;
    [self addSubview:bottomView];
    
    [iconImageVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kCommonMargin);
        make.left.equalTo(self).offset(kCommonMargin);
        make.size.mas_offset(CGSizeMake(30, 30));
    }];
    
    [productNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImageVIew.mas_right).offset(kCommonMargin);
        make.bottom.equalTo(iconImageVIew.mas_centerY).offset(-5);
        make.width.lessThanOrEqualTo(self).offset(-2 * kCommonMargin - 50);
        make.height.equalTo(@18);
    }];
    
    [applyNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(productNameLabel);
        make.top.equalTo(iconImageVIew.mas_centerY).offset(5);
        make.width.lessThanOrEqualTo(self).offset(-2 * kCommonMargin - 50);
        make.height.equalTo(@14);
    }];
    
    [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self);
        make.top.equalTo(applyNumLabel.mas_bottom).offset(10);
        make.height.equalTo(@(kLineThick));
    }];
    
    [loanRangeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(topLineView.mas_bottom).offset(10);
        make.width.equalTo(self).multipliedBy(1.0 / 3.0);
        make.height.equalTo(@14);
    }];
    
    [loanRangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(loanRangeTitleLabel);
        make.top.equalTo(loanRangeTitleLabel.mas_bottom).offset(5);
    }];
    
    [deadlineRangeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(loanRangeTitleLabel);
        make.left.equalTo(loanRangeTitleLabel.mas_right);
    }];
    
    [deadlineRangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(deadlineRangeTitleLabel);
        make.top.equalTo(deadlineRangeTitleLabel.mas_bottom).offset(5);
    }];
    
    [interestRateTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(deadlineRangeTitleLabel);
        make.left.equalTo(deadlineRangeTitleLabel.mas_right);
    }];
    
    [interestRateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(interestRateTitleLabel);
        make.top.equalTo(interestRateTitleLabel.mas_bottom).offset(5);
    }];
    
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(topLineView);
        make.top.equalTo(loanRangeLabel.mas_bottom).offset(10);
    }];
    
    [firstVertialLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(loanRangeTitleLabel.mas_right);
        make.top.equalTo(topLineView.mas_bottom);
        make.width.equalTo(@(kLineThick));
        make.height.equalTo(@(10 + 14 + 5 + 14 + 10));
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

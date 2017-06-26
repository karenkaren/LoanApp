//
//  LoanRootCell.m
//  Loan
//
//  Created by 王安帮 on 2017/6/24.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "LoanRootCell.h"
#import "UIImageView+WebCache.h"

@interface LoanRootCell ()
{
    UIImageView * _iconImageView;
    UILabel * _productNameLabel;
    UILabel * _descLabel;
    UILabel * _applyNumLabel;
    UILabel * _interestRateLabel;
    UILabel * _interestRateTitleLabel;
}

@end

@implementation LoanRootCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addAllSubviews];
    }
    return self;
}

- (void)addAllSubviews
{
    _iconImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_iconImageView];
    
    _productNameLabel = [[UILabel alloc] init];
    _productNameLabel.font = kFont(14);
    [self.contentView addSubview:_productNameLabel];
    
    _descLabel = [[UILabel alloc] init];
    _descLabel.font = kFont(14);
    _descLabel.textColor = kColor999999;
    [self.contentView addSubview:_descLabel];
    
    UILabel * applyNumTitleLabel = [[UILabel alloc] init];
    applyNumTitleLabel.font = kFont(12);
    applyNumTitleLabel.textColor = kColor999999;
    applyNumTitleLabel.text = @"申请人数";
    [self.contentView addSubview:applyNumTitleLabel];
    
    _applyNumLabel = [[UILabel alloc] init];
    _applyNumLabel.font = kFont(12);
    _applyNumLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:_applyNumLabel];
    
    _interestRateTitleLabel = [[UILabel alloc] init];
    _interestRateTitleLabel.font = kFont(12);
    _interestRateTitleLabel.textColor = kColor999999;
    [self.contentView addSubview:_interestRateTitleLabel];
    
    _interestRateLabel = [[UILabel alloc] init];
    _interestRateLabel.font = kFont(12);
    _interestRateLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:_interestRateLabel];
    
    UIImageView * arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_arrow"]];
    [self.contentView addSubview:arrowImageView];
    
    UIView * bottomLineView = [[UIView alloc] init];
    bottomLineView.backgroundColor = kLineColor;
    [self.contentView addSubview:bottomLineView];
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kGeneralSize * 0.5);
        make.centerY.equalTo(self);
        make.width.height.equalTo(self.mas_height).multipliedBy(1.0 / 2.0);
    }];
    
    [_productNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImageView.mas_right).offset(kGeneralSize * 0.5);
        make.top.equalTo(self).offset(kCommonMargin);
        make.height.equalTo(@14);
        make.right.equalTo(self);
    }];
    
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_productNameLabel);
        make.top.equalTo(_productNameLabel.mas_bottom).offset(10);
        make.width.equalTo(_productNameLabel).offset(-kGeneralSize);
        make.height.equalTo(@14);
        
    }];
    
    [applyNumTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_descLabel);
        make.top.equalTo(_descLabel.mas_bottom).offset(10);
        make.width.equalTo(@50);
        make.height.equalTo(@12);
    }];
    
    [_applyNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(applyNumTitleLabel.mas_right).offset(5);
        make.top.equalTo(applyNumTitleLabel);
        make.width.equalTo(@80);
        make.height.equalTo(@12);
    }];
    
    [_interestRateTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_right).offset(-100);
        make.top.equalTo(_applyNumLabel);
        make.width.equalTo(@40);
        make.height.equalTo(@12);
    }];
    
    [_interestRateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_interestRateTitleLabel.mas_right).offset(5);
        make.top.equalTo(_interestRateTitleLabel);
        make.width.equalTo(@50);
        make.height.equalTo(@12);
    }];
    
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-kCommonMargin);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(8, 15));
    }];
    
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self);
        make.top.equalTo(self.mas_bottom).offset(-kLineThick);
        make.height.equalTo(@(kLineThick));
    }];
}

- (CGFloat)getCellHeightWithProduct:(ProductModel *)product
{
    self.product = product;
    
    return _interestRateLabel.bottom + kCommonMargin;
}

- (void)setProduct:(ProductModel *)product
{
    if (_product == product) {
        return;
    }
    _product = product;
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:product.cloanLogo] placeholderImage:[UIImage imageNamed:@"logo"] options:SDWebImageRetryFailed];
    _productNameLabel.text = product.cloanName;
    _descLabel.text = product.desc;
    _applyNumLabel.text = [NSString stringWithFormat:@"%ld人", product.applyCustomer];
    
    if (product.dayRate) {
        _interestRateTitleLabel.text = @"日利率";
        _interestRateLabel.text = [NSString stringWithFormat:@"%.2f%%", product.dayRate * 100];
    } else if (product.monthRate) {
        _interestRateTitleLabel.text = @"月利率";
        _interestRateLabel.text = [NSString stringWithFormat:@"%.2f%%", product.monthRate * 100];
    } else {
        _interestRateTitleLabel.text = @"年利率";
        _interestRateLabel.text = [NSString stringWithFormat:@"%.2f%%", product.yearRate * 100];
    }
    
    [self layoutIfNeeded];
    [self setNeedsLayout];
}

@end

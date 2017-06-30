//
//  ProductDetailCell.m
//  Loan
//
//  Created by 王安帮 on 2017/6/25.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "ProductDetailCell.h"

@interface ProductDetailCell ()

@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UIImageView * contentImageView;

@end

@implementation ProductDetailCell

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
    UIView * topLineView = [[UIView alloc] init];
    topLineView.backgroundColor = kLineColor;
    [self.contentView addSubview:topLineView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = kFont(16);
    [self.contentView addSubview:self.titleLabel];
    
    UIView * seperatorLineView = [[UIView alloc] init];
    seperatorLineView.backgroundColor = kLineColor;
    [self.contentView addSubview:seperatorLineView];
    
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.font = kFont(14);
    self.contentLabel.numberOfLines = 0;
    [self.contentView addSubview:self.contentLabel];
    
//    self.contentImageView = [[UIImageView alloc] init];
//    [self.contentView addSubview:self.contentImageView];
    
    UIView * bottomLineView = [[UIView alloc] init];
    bottomLineView.backgroundColor = kLineColor;
    [self.contentView addSubview:bottomLineView];
    
    [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.equalTo(self);
        make.height.equalTo(@(kLineThick));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topLineView.mas_bottom);
        make.left.equalTo(self).offset(kCommonMargin);
        make.width.equalTo(self).offset(-2 * kCommonMargin);
        make.height.equalTo(@(kGeneralSize));
    }];
    
    [seperatorLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self);
        make.height.equalTo(@(kLineThick));
        make.top.equalTo(self.titleLabel.mas_bottom);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.titleLabel);
        make.height.greaterThanOrEqualTo(@14);
        make.top.equalTo(seperatorLineView.mas_bottom).offset(10);
    }];
    
//    [self.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.width.equalTo(self.contentLabel);
//        make.top.equalTo(seperatorLineView.mas_bottom);
//        make.height.equalTo(@(kGeneralSize));
//    }];
    
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.height.equalTo(topLineView);
        if (!self.contentLabel.hidden) {
            make.top.equalTo(self.contentLabel.mas_bottom).offset(10);
        } else if (!self.contentImageView.hidden) {
            make.top.equalTo(self.contentImageView.mas_bottom);
        }
    }];
}

- (void)setDetailData:(NSDictionary *)detailData
{
    _detailData = detailData;
    
    self.titleLabel.text = detailData[@"title"];
    
    ProductDetailCellStyle style = [detailData[@"style"] integerValue];
    switch (style) {
        case ProductDetailCellStyleText:
            self.contentLabel.text = detailData[@"content"];
            self.contentLabel.hidden = NO;
            self.contentImageView.hidden = YES;
            break;
        case ProductDetailCellStyleImage:
            self.contentImageView.image = [UIImage imageNamed:detailData[@"content"]];
            self.contentLabel.hidden = YES;
            self.contentImageView.hidden = NO;
            break;
        default:
            break;
    }
    
    [self layoutIfNeeded];
    [self setNeedsLayout];
}

- (CGFloat)getCellHeightWithData:(NSDictionary *)data
{
    self.detailData = data;
    
    ProductDetailCellStyle style = [data[@"style"] integerValue];
    CGFloat height = 0.0;
    switch (style) {
        case ProductDetailCellStyleText:
            height = self.contentLabel.bottom + 10;
            break;
        case ProductDetailCellStyleImage:
            height = self.contentImageView.bottom;
            break;
        default:
            break;
    }
    return height;
}

@end

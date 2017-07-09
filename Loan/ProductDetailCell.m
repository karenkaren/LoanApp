//
//  ProductDetailCell.m
//  Loan
//
//  Created by 王安帮 on 2017/6/25.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "ProductDetailCell.h"

@interface ProductDetailCell ()
{
    UIView * _seperatorLineView;
}

@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UIView * applyProcessView;

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
    
    _seperatorLineView = [[UIView alloc] init];
    _seperatorLineView.backgroundColor = kLineColor;
    [self.contentView addSubview:_seperatorLineView];
    
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.font = kFont(14);
    self.contentLabel.numberOfLines = 0;
    [self.contentView addSubview:self.contentLabel];
    
    self.applyProcessView = [[UIView alloc] init];
    [self.contentView addSubview:self.applyProcessView];
    
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
    
    [_seperatorLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self);
        make.height.equalTo(@(kLineThick));
        make.top.equalTo(self.titleLabel.mas_bottom);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.titleLabel);
        make.height.greaterThanOrEqualTo(@14);
        make.top.equalTo(_seperatorLineView.mas_bottom).offset(10);
    }];
    
    [self.applyProcessView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self);
        make.top.equalTo(_seperatorLineView.mas_bottom);
        make.height.equalTo(@(kGeneralSize * 2));
    }];
    
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.height.equalTo(topLineView);
        if (!self.contentLabel.hidden) {
            make.top.equalTo(self.contentLabel.mas_bottom).offset(10);
        } else if (!self.applyProcessView.hidden) {
            make.top.equalTo(self.applyProcessView.mas_bottom);
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
            self.applyProcessView.hidden = YES;
            break;
        case ProductDetailCellStyleImage:
            [self modifyContentViewWithData:detailData[@"content"]];
            self.contentLabel.hidden = YES;
            self.applyProcessView.hidden = NO;
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
            height = self.applyProcessView.bottom;
            break;
        default:
            break;
    }
    return height;
}

- (void)modifyContentViewWithData:(NSArray *)data
{
    for (UIView * subview in self.applyProcessView.subviews) {
        [subview removeFromSuperview];
    }
    
    if (!isArray(data)) {
        return;
    }
    
    NSArray * applyStepArray = (NSArray *)data;
    
    CGFloat margin = kScreenWidth / 15;
    for (int i = 0; i < applyStepArray.count * 2 - 1; i++) {
        UIImageView * imageView = [[UIImageView alloc] init];
        NSString * imageName = i % 2 ? @"icon_yellow_arraw.png" : @"icon_smiling.png";
        imageView.image = [UIImage imageNamed:imageName];
        [self.applyProcessView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.applyProcessView).offset(margin + margin * i * 2);
            make.top.equalTo(self.applyProcessView).offset(15);
            make.size.mas_equalTo(CGSizeMake(margin, margin));
        }];
        
        if (i % 2 == 0) {
            NSDictionary * dic = applyStepArray[i / 2];
            UILabel * titleLabel = [[UILabel alloc] init];
            titleLabel.text = esString(dic[@"stepName"]);
            titleLabel.font = kFont(12);
            [titleLabel adjustsFontSizeToFitWidth];
            [titleLabel sizeToFit];
            [self.applyProcessView addSubview:titleLabel];
            
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(imageView.mas_bottom).offset(10);
                make.centerX.equalTo(imageView);
            }];
        }
    }
}

@end

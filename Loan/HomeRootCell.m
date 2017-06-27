//
//  HomeRootCell.m
//  Loan
//
//  Created by 王安帮 on 2017/6/24.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "HomeRootCell.h"
#import "UIImageView+WebCache.h"

@interface HomeRootCell ()
{
    UIImageView * _iconImageView;
    UILabel * _nameLabel;
    UIImageView * _markImageView;
}
@end

@implementation HomeRootCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderWidth = kLineThick;
        self.layer.borderColor = kLineColor.CGColor;
        [self addAllSubviews];
    }
    return self;
}

- (void)addAllSubviews
{
    _iconImageView = [[UIImageView alloc] init];
    [self addSubview:_iconImageView];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.font = kFont(18);
    [self addSubview:_nameLabel];
    
    _markImageView = [[UIImageView alloc] init];
    _markImageView.hidden = YES;
    [self addSubview:_markImageView];
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_centerY).offset(10);
        make.width.height.equalTo(self.mas_width).multipliedBy(1.0 / 3.0);
        make.centerX.equalTo(self);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.equalTo(self);
        make.height.equalTo(@18);
        make.top.equalTo(_iconImageView.mas_bottom).offset(20);
    }];
    
    [_markImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self);
        make.width.height.equalTo(self.mas_width).multipliedBy(1.0 / 5.0);
    }];
}

- (void)setProduct:(ProductModel *)product
{
    if (_product == product) {
        return;
    }
    _product = product;
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:product.cloanLogo] placeholderImage:[UIImage imageNamed:@"logo"] options:SDWebImageRetryFailed];
    _nameLabel.text = product.cloanName;
    
    NSString * markImageName = nil;
    
    if ([product.cloanTags isEqualToString:@"new"]) {
        markImageName = @"icon_note";
    } else if ([product.cloanTags isEqualToString:@"hot"]) {
        markImageName = @"icon_show";
    }

    _markImageView.hidden = [NSString isEmpty:markImageName] ? YES : NO;
    if (!_markImageView.hidden) {
        _markImageView.image = [UIImage imageNamed:markImageName];
    }
    
}

//- (void)setPlatformInfo:(PlatformModel *)platformInfo
//{
//    if (_platformInfo == platformInfo) {
//        return;
//    }
//    _platformInfo = platformInfo;
//    
//    _iconImageView.image = [UIImage imageNamed:platformInfo.plarformIconUrl];
//    _nameLabel.text = platformInfo.platformName;
//    
//    NSString * markImageName = nil;
//    switch (platformInfo.plarformType) {
//        case 1:
//            markImageName = @"icon_note";
//            break;
//        case 2:
//            markImageName = @"icon_show";
//            break;
//        default:
//            break;
//    }
//    _markImageView.hidden = [NSString isEmpty:markImageName] ? YES : NO;
//    if (!_markImageView.hidden) {
//        _markImageView.image = [UIImage imageNamed:markImageName];
//    }
//}

@end

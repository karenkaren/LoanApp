//
//  LoginHeaderView.m
//  Loan
//
//  Created by 王安帮 on 2017/6/24.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "LoginHeaderView.h"

@interface LoginHeaderView()
{
    NSString * _title;
}
@end

@implementation LoginHeaderView

- (instancetype)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        _title = title;
        [self addAllSubviews];
    }
    return self;
}

- (void)addAllSubviews
{
    UIImageView * logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    [self addSubview:logoImageView];
    
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.text = _title;
    titleLabel.font = kFont(30);
    [self addSubview:titleLabel];
    
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self);
        make.width.height.equalTo(@(60));
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(logoImageView);
        make.top.equalTo(logoImageView.mas_bottom).offset(15);
        make.height.equalTo(@30);
        make.width.equalTo(self);
    }];
}

@end

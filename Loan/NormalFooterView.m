//
//  NormalFooterView.m
//  Loan
//
//  Created by 王安帮 on 2017/7/1.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "NormalFooterView.h"

@interface NormalFooterView ()

{
    NSString * _title;
}

@end

@implementation NormalFooterView

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
    UIView * backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = kWhiteColor;
    backgroundView.layer.borderColor = kLineColor.CGColor;
    backgroundView.layer.borderWidth = kLineThick;
    [self addSubview:backgroundView];
    
    kWeakSelf
    UIButton * button = [UIButton createButtonWithTitle:_title color:kWhiteColor font:kFont(18) block:^(UIButton *button) {
        kStrongSelf
        if (strongSelf.buttonClickBlock) {
            strongSelf.buttonClickBlock(button);
        }
    }];
    [button setDisenableBackgroundColor:kDisabledColor enableBackgroundColor:[UIColor yellowColor]];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    button.backgroundColor = kLinkColor;
    [backgroundView addSubview:button];
    
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(backgroundView).offset(10);
        make.width.height.equalTo(backgroundView).offset(-20);
    }];
}

@end

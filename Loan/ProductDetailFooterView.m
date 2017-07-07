//
//  ProductDetailFooterView.m
//  Loan
//
//  Created by 王安帮 on 2017/6/25.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "ProductDetailFooterView.h"

@implementation ProductDetailFooterView

- (instancetype)init
{
    self = [super init];
    if (self) {
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
    UIButton * applyButton = [UIButton createButtonWithTitle:@"立即申请" color:kBlackColor font:kFont(18) block:^(UIButton *button) {
        kStrongSelf
        if (strongSelf.applyClickBlock) {
            strongSelf.applyClickBlock(button);
        }
    }];
    applyButton.layer.cornerRadius = 5;
    applyButton.layer.masksToBounds = YES;
    applyButton.backgroundColor = kMainColor;
    [backgroundView addSubview:applyButton];
    
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [applyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(backgroundView).offset(10);
        make.width.height.equalTo(backgroundView).offset(-20);
    }];
}

@end

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
    UIView * _lineView;
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
    [self addSubview:backgroundView];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = kLineColor;
    [self addSubview:_lineView];
    
    kWeakSelf
    UIButton * button = [UIButton createButtonWithTitle:_title color:kBlackColor font:kFont(18) block:^(UIButton *button) {
        kStrongSelf
        if (strongSelf.buttonClickBlock) {
            strongSelf.buttonClickBlock(button);
        }
    }];
    [button setDisenableBackgroundColor:kDisabledColor enableBackgroundColor:kMainColor];
    [button setTitleColor:kBlackColor forState:UIControlStateNormal];
    [button setTitleColor:kWhiteColor forState:UIControlStateDisabled];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [backgroundView addSubview:button];
    self.footerButton = button;
    
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.equalTo(backgroundView);
        make.height.equalTo(@(kLineThick));
    }];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backgroundView).offset(20);
        make.bottom.equalTo(backgroundView);
        make.width.equalTo(backgroundView).offset(-40);
        make.height.equalTo(backgroundView).offset(-20);
    }];
}

- (void)setHideTopLine:(BOOL)hideTopLine
{
    _hideTopLine = hideTopLine;
    _lineView.hidden = hideTopLine;
}

@end

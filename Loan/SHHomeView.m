//
//  SHHomeView.m
//  Loan
//
//  Created by 王安帮 on 2017/7/18.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "SHHomeView.h"

@interface SHHomeView ()
{
    UILabel * _explainLabel;
    UISlider * _sliderView;
    UILabel * _maxApplyLimitLable;
}

@end

@implementation SHHomeView

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
    UIView * headerView = [[UIView alloc] init];
    [self addSubview:headerView];
    
    UIImageView * headerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SHHomeHeaderBackImage"]];
    [headerView addSubview:headerImageView];
    
    UILabel * maxApplyLimitLable = [UILabel createLabelWithText:@"10000.00" font:kFont(60) color:kWhiteColor];
    maxApplyLimitLable.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:maxApplyLimitLable];
    _maxApplyLimitLable = maxApplyLimitLable;
    
    UILabel * maxApplyLimitTitleLabel = [UILabel createLabelWithText:@"最高借款额度（元）" font:kFont(14) color:kWhiteColor];
    maxApplyLimitTitleLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:maxApplyLimitTitleLabel];
    
    _sliderView = [[UISlider alloc] init];
    _sliderView.minimumTrackTintColor = kWhiteColor;
    _sliderView.maximumTrackTintColor = kDisabledColor;
    [_sliderView setThumbImage:[UIImage imageNamed:@"checked_single"] forState:UIControlStateNormal];
    _sliderView.minimumValue = 1000;
    _sliderView.maximumValue = 10000;
    [_sliderView setValue:10000];
    [_sliderView addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [headerView addSubview:_sliderView];

    
    UILabel * creditLimitTitleLabel = [UILabel createLabelWithText:@"信用额度（元）" font:kFont(13) color:kWhiteColor];
    creditLimitTitleLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:creditLimitTitleLabel];
    
    UILabel * creditLimitLabel = [UILabel createLabelWithText:@"0.00" font:kFont(15) color:kWhiteColor];
    creditLimitLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:creditLimitLabel];
    
    UILabel * loanDeadlineTitleLabel = [UILabel createLabelWithText:@"借款期限（天）" font:kFont(13) color:kWhiteColor];
    loanDeadlineTitleLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:loanDeadlineTitleLabel];
    
    UILabel * loanDeadlineLabel = [UILabel createLabelWithText:@"21" font:kFont(15) color:kWhiteColor];
    loanDeadlineLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:loanDeadlineLabel];
    
    UIView * vertialLineView = [[UIView alloc] init];
    vertialLineView.backgroundColor = kWhiteColor;
    [headerView addSubview:vertialLineView];
    
    kWeakSelf
    UIButton * applyButton = [UIButton createButtonWithTitle:@"开始申请" color:kBlackColor font:kFont(18) block:^(UIButton *button) {
        kStrongSelf
        if (strongSelf.applyClickBlock) {
            strongSelf.applyClickBlock(button);
        }
    }];
    applyButton.layer.cornerRadius = 5;
    applyButton.layer.masksToBounds = YES;
    applyButton.backgroundColor = kMainColor;
    [self addSubview:applyButton];
    
    UILabel * explainLabel = [UILabel createLabelWithText:@"神马贷款不向在校大学生提供借款服务" font:kFont(14) color:kColor666666];
    explainLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:explainLabel];
    _explainLabel = explainLabel;
    
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.equalTo(self);
        make.height.equalTo(@(kAdaptiveBaseIphone6(393)));
    }];
    
    [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(headerView);
    }];
    
    [maxApplyLimitLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@60);
        make.top.equalTo(headerView).offset(kAdaptiveBaseIphone6(108));
        make.width.left.equalTo(headerView);
    }];
    
    [maxApplyLimitTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(maxApplyLimitLable.mas_bottom).offset(kAdaptiveBaseIphone6(13));
        make.width.left.equalTo(headerView);
        make.height.equalTo(@14);
    }];
    
    [_sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(kCommonMargin);
        make.width.equalTo(headerView).offset(-2 * kCommonMargin);
        make.top.equalTo(maxApplyLimitTitleLabel.mas_bottom).offset(kAdaptiveBaseIphone6(35));
        make.height.equalTo(@20);
    }];
    
    [creditLimitTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(headerView).multipliedBy(0.5);
        make.top.equalTo(_sliderView.mas_bottom).offset(58);
        make.left.equalTo(self);
        make.height.equalTo(@13);
    }];
    
    [creditLimitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(headerView).multipliedBy(0.5);
        make.top.equalTo(creditLimitTitleLabel.mas_bottom).offset(10);
        make.left.equalTo(self);
        make.height.equalTo(@15);
    }];
    
    [loanDeadlineTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(headerView).multipliedBy(0.5);
        make.top.equalTo(_sliderView.mas_bottom).offset(58);
        make.left.equalTo(creditLimitTitleLabel.mas_right);
        make.height.equalTo(@13);
    }];
    
    [loanDeadlineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(headerView).multipliedBy(0.5);
        make.top.equalTo(loanDeadlineTitleLabel.mas_bottom).offset(10);
        make.left.equalTo(creditLimitLabel.mas_right);
        make.height.equalTo(@15);
    }];
    
    [vertialLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(kLineThick));
        make.bottom.equalTo(headerView).offset(-27);
        make.top.equalTo(creditLimitTitleLabel).offset(-9);
        make.left.equalTo(loanDeadlineTitleLabel);
    }];
    
    [applyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kCommonMargin);
        make.height.equalTo(@(kGeneralSize));
        make.width.equalTo(self).offset(-2 * kCommonMargin);
        make.top.equalTo(headerView.mas_bottom).offset(kAdaptiveBaseIphone6(90));
    }];
    
    [explainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self);
        make.top.equalTo(applyButton.mas_bottom).offset(kAdaptiveBaseIphone6(48));
        make.height.equalTo(@14);
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.contentSize = CGSizeMake(kScreenWidth, _explainLabel.bottom + 20);
}

- (void)sliderValueChanged:(UISlider *)slider
{
    NSInteger sliderValue = slider.value;
    _maxApplyLimitLable.text = [[NSString alloc] initWithFormat:@"%.2f", sliderValue * 1.0];
}

@end

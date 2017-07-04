//
//  FilterView.m
//  Loan
//
//  Created by 王安帮 on 2017/7/4.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "FilterView.h"

@interface FilterView ()
{
    NSArray * _titlesString;
    NSArray * _keysString;
    FilterType _defaultFilterType;
}
@property (nonatomic, strong) UIButton * selectButton;
@property (nonatomic, copy) void(^filterChangedBlock)(UIButton * button, NSString * keyString);

@end

@implementation FilterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titlesString = @[@"人气", @"大额", @"极速下款", @"不查征信", @"自由职业", @"全部"];
        _keysString = @[@"TAG_RENQI", @"TAG_DAE", @"TAG_JSXK", @"TAG_BCZX", @"TAG_ZYZY", @"TAG_ALL"];
        [self addAllSubviews];
    }
    return self;
}

- (void)setDefaultFilterType:(FilterType)defaultFilterType filterChangedBlock:(void (^)(UIButton *, NSString *))filterChangedBlock
{
    _defaultFilterType = defaultFilterType;
    self.filterChangedBlock = filterChangedBlock;
    UIButton * button = [self viewWithTag:defaultFilterType];
    [self changeSelectStatus:button];
}

- (void)addAllSubviews
{
    for (int i = 0; i < _titlesString.count; i++) {
        UIButton * button = [UIButton createButtonWithTitle:_titlesString[i] color:[UIColor grayColor] font:kFont(18) block:^(UIButton *button) {
            [self changeSelectStatus:button];
        }];
        button.layer.cornerRadius = 2.5;
        button.layer.masksToBounds = YES;
        button.layer.borderColor = kLineColor.CGColor;
        button.layer.borderWidth = kLineThick;
        [button setBackgroundColor:kWhiteColor forStatus:UIControlStateNormal];
        [button setBackgroundColor:kMainColor forStatus:UIControlStateSelected];
        CGFloat width = (kScreenWidth - 4 * 30) / 3.0;
        CGFloat height = 30;
        CGFloat x = 30 + (width + 30) * (i % 3);
        CGFloat y = 20 + (height + 20) * (i / 3);
        button.frame = CGRectMake(x, y, width, height);
        button.tag = i;
        [self addSubview:button];

//        if (i == _defaultFilterType) {
//            button.selected = YES;
//            button.layer.borderWidth = 0;
//            self.selectButton = button;
//        }
        if (i == _titlesString.count - 1) {
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, button.bottom + 20);
        }
    }
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bottom - kLineThick, self.width, kLineThick)];
    lineView.backgroundColor = kLineColor;
    [self addSubview:lineView];
}

- (void)changeSelectStatus:(UIButton *)button
{
    if (self.selectButton == button) {
        return;
    }
    self.selectButton.layer.borderWidth = kLineThick;
    self.selectButton.selected = NO;
    button.layer.borderWidth = 0;
    button.selected = YES;
    self.selectButton = button;
    if (self.filterChangedBlock) {
        self.filterChangedBlock(button, _keysString[button.tag]);
    }
}

@end

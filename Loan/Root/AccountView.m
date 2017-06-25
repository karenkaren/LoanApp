//
//  AccountView.m
//  XiChe
//
//  Created by LiuFeifei on 2017/4/11.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

#import "AccountView.h"

@interface AccountView ()

@property (nonatomic, strong) UILabel * goldLabel;  //金币
@property (nonatomic, strong) UILabel * integralLabel;  //积分
@property (nonatomic, strong) UILabel * invitationGoldLabel;    //邀请金

@end

@implementation AccountView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    UIView * goldView = [self createGoldView];
    [self addSubview:goldView];
    
    UIView * integralView = [self createIntegralView];
    [self addSubview:integralView];
    
    UIView * invitationGoldView = [self createInvitationGoldView];
    [self addSubview:invitationGoldView];
    
    UIView * lineView1 = [self createLinView];
    [self addSubview:lineView1];
    
    UIView * lineView2 = [self createLinView];
    [self addSubview:lineView2];
    
    [goldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
        make.width.equalTo(self).multipliedBy(1.0 / 3.0);
        make.height.equalTo(self);
    }];
    
    [integralView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(goldView.mas_right);
        make.top.equalTo(@[goldView, invitationGoldView, lineView1, lineView2]);
        make.width.height.equalTo(@[goldView, invitationGoldView]);
    }];
    
    [invitationGoldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(integralView.mas_right);
    }];
    
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(integralView);
        make.left.equalTo(goldView.mas_right);
        make.height.equalTo(goldView);
        make.width.equalTo(@(kLineThick));
    }];
    
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView1);
        make.left.equalTo(integralView.mas_right);
        make.width.height.equalTo(lineView1);
    }];
}

- (void)updateData
{
//    NSString * totalAsset = [CurrentUser mine].accountInfo.totalAsset > 10000000 ? [NSString stringWithFormat:locationString(@"amount_wan_decimal"), [CurrentUser mine].accountInfo.totalAsset / 10000.0] : [NSString stringWithFormat:@"%.2f", [CurrentUser mine].accountInfo.totalAsset];
//    NSString * usableBalanc = [CurrentUser mine].accountInfo.usableBalance > 10000000 ? [NSString stringWithFormat:locationString(@"amount_wan_decimal"), [CurrentUser mine].accountInfo.usableBalance / 10000.0] : [NSString stringWithFormat:@"%.2f", [CurrentUser mine].accountInfo.usableBalance];
//    NSString * birdCoin = [CurrentUser mine].accountInfo.birdCoin > 10000000 ? [NSString stringWithFormat:locationString(@"amount_wan_decimal"), [CurrentUser mine].accountInfo.birdCoin / 10000.0] : [NSString stringWithFormat:@"%.2f", [CurrentUser mine].accountInfo.birdCoin];
//    
//    self.usableBalanc = usableBalanc;
//    self.birdCoin = birdCoin;
//    self.totalAsset = totalAsset;
}
    
- (UIView *)createLinView
{
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = kLineColor;
    return lineView;
}

- (UIView *)createGoldView
{
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = kWhiteColor;
    
    self.goldLabel = [self createLabelWithText:@"0.00"];
    [view addSubview:self.goldLabel];
    
    UILabel * goldNameLabel = [self createLabelWithText:@"金币"];
    [view addSubview:goldNameLabel];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goldDetail)];
    [view addGestureRecognizer:tap];
    
    // 布局
    [self.goldLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.equalTo(@[view, goldNameLabel]);
        make.top.equalTo(view);
        make.height.equalTo(view).multipliedBy(1.0 / 2.0);

    }];

    [goldNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goldLabel.mas_bottom);
        make.height.equalTo(self.goldLabel);
    }];
    
    return view;
}

- (UIView *)createIntegralView
{
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = kWhiteColor;
    
    UILabel * integralNameLabel = [self createLabelWithText:@"积分"];
    [view addSubview:integralNameLabel];
    
    self.integralLabel = [self createLabelWithText:@"0.00"];
    [view addSubview:self.integralLabel];
    
    UIButton * integralButton = [UIButton createButtonWithIconName:@"icon_help" block:^(UIButton *button) {
        [self explainIntegral];
    }];
    [integralButton setEnlargeEdge:20];
    [view addSubview:integralButton];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(integralDetail)];
    [view addGestureRecognizer:tap];
    
    // 布局
    [self.integralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.equalTo(view);
        make.top.equalTo(view);
        make.height.equalTo(view).multipliedBy(1.0 / 2.0);
        
    }];
    
    [integralNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.integralLabel.mas_bottom);
        make.right.equalTo(view.mas_centerX);
        make.width.lessThanOrEqualTo(view).multipliedBy(1.0 / 2.0);
        make.height.equalTo(self.integralLabel);
    }];

    [integralButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(integralNameLabel.mas_right).offset(5);
        make.centerY.equalTo(integralNameLabel);
        make.height.lessThanOrEqualTo(integralNameLabel);
        make.width.lessThanOrEqualTo(view).multipliedBy(1.0 / 2.0);
    }];
    
    return view;
}

- (UIView *)createInvitationGoldView
{
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = kWhiteColor;
    
    self.invitationGoldLabel = [self createLabelWithText:@"1.00"];
    [view addSubview:self.invitationGoldLabel];
    
    UILabel * invitationGoldNameLabel = [self createLabelWithText:@"邀请金"];
    [view addSubview:invitationGoldNameLabel];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(invitationGoldDetail)];
    [view addGestureRecognizer:tap];
                                       
    // 布局
    [self.invitationGoldLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.equalTo(@[view, invitationGoldNameLabel]);
        make.top.equalTo(view);
        make.height.equalTo(view).multipliedBy(1.0 / 2.0);
    }];
    
    [invitationGoldNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.invitationGoldLabel.mas_bottom);
        make.height.equalTo(self.invitationGoldLabel);
    }];

    return view;
}

- (UILabel *)createLabelWithText:(NSString *)text
{
    UILabel * label = [[UILabel alloc] init];
    label.font = kFont(14);
    label.textColor = kTextColor;
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    return label;
}

#pragma mark - 通知delegate
#pragma mark 金币明细
- (void)goldDetail
{
//    if (self.delegate && [self.delegate respondsToSelector:@selector(accountCellWillShowUsableBalanceDetail)]) {
//        [self.delegate accountCellWillShowUsableBalanceDetail];
//    }
}

#pragma mark 积分明细
- (void)integralDetail
{
//    if (self.delegate && [self.delegate respondsToSelector:@selector(accountCellWillShowBirdCoinDetail)]) {
//        [self.delegate accountCellWillShowBirdCoinDetail];
//    }
}

#pragma mark 邀请金明细
- (void)invitationGoldDetail
{
//    if (self.delegate && [self.delegate respondsToSelector:@selector(accountCellWillShowTotalAssetDetail)]) {
//        [self.delegate accountCellWillShowTotalAssetDetail];
//    }
}

#pragma mark 积分解释
- (void)explainIntegral
{
//    LTNExplainBirdCoinView * explainView = [[LTNExplainBirdCoinView alloc] init];
//    [explainView show];
//    DLog(@"鸟币说明");
}

@end

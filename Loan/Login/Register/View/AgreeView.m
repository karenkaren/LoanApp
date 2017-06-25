//
//  AgreeView.m
//  LingTouNiaoLoan
//
//  Created by LiuFeifei on 17/3/28.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

#import "AgreeView.h"

@interface AgreeView()

@property (nonatomic, copy) NSString * protocol;
@property (nonatomic, copy) NSString * otherProtocol;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, assign) CGFloat fontSize;

@end

@implementation AgreeView

- (instancetype)initWithTitle:(NSString *)title protocol:(NSString *)protocol otherProtocol:(NSString *)otherProtocol fontSize:(CGFloat)fontSize target:(id)targer
{
    self = [super init];
    if (self) {
        self.title = title;
        self.protocol = protocol;
        self.otherProtocol = otherProtocol;
        self.fontSize = fontSize;
        self.delegate = targer;
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    if (!self.protocol || [self.protocol isEqualToString:@""]) {
        return;
    }
    
    kWeakSelf
    // 阅读并同意协议button
    UIButton * agreeButton = [UIButton createButtonWithNomalIconName:@"unchecked_single" selectedIconName:@"checked_single" block:^(UIButton *button) {
        kStrongSelf
        [strongSelf clickedAgreeButton:button];
    }];
    [self clickedAgreeButton:agreeButton];
    [self addSubview:agreeButton];
    agreeButton.size = CGSizeMake(24, 24);
    agreeButton.left = 0;

    
    // 阅读并同意协议label
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.font = kFont(self.fontSize);
    titleLabel.textColor = kWhiteColor;
    titleLabel.text = self.title;
    [titleLabel sizeToFit];
    [self addSubview:titleLabel];
    titleLabel.left = agreeButton.right;
    
    // 协议按钮
    UIButton * protocolButton = [UIButton createButtonWithTitle:self.protocol color:kHexColor(0xfff900) font:kFont(self.fontSize) block:^(UIButton *button) {
        kStrongSelf
        [strongSelf clickedProtocolButton:button];
    }];
    protocolButton.tag = 0;
    protocolButton.left = titleLabel.right;
    [self addSubview:protocolButton];
    
    UILabel * connectorLabel = nil;
    UIButton * otherProtocolButton = nil;
    if (self.otherProtocol && ![self.otherProtocol isEqualToString:@""]) {
        // 连接label
        connectorLabel = [[UILabel alloc] init];
        connectorLabel.font = kFont(self.fontSize);
        connectorLabel.textColor = kWhiteColor;
        connectorLabel.text = @"和";
        [connectorLabel sizeToFit];
        [self addSubview:connectorLabel];
        connectorLabel.left = protocolButton.right;
        
        // other protocol
        otherProtocolButton = [UIButton createButtonWithTitle:self.otherProtocol color:kHexColor(0xfff900) font:kFont(self.fontSize) block:^(UIButton *button) {
            kStrongSelf
            [strongSelf clickedProtocolButton:button];
        }];
        otherProtocolButton.tag = 1;
        otherProtocolButton.left = connectorLabel.right;
        [self addSubview:otherProtocolButton];
    }

    titleLabel.height = protocolButton.height = otherProtocolButton.height = connectorLabel.height = 24;
}

- (void)clickedAgreeButton:(UIButton *)agreeButton
{
    agreeButton.selected = !agreeButton.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(agreeViewWillAgreeProtocol:)]) {
        [self.delegate agreeViewWillAgreeProtocol:agreeButton.selected];
    }
}

- (void)clickedProtocolButton:(UIButton *)protocolButton
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(agreeViewWillShowProtocolWithIndex:)]) {
        [self.delegate agreeViewWillShowProtocolWithIndex:protocolButton.tag];
    }
}

@end

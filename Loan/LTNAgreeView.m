//
//  LTNAgreeView.m
//  lingtouniao
//
//  Created by LiuFeifei on 16/1/21.
//  Copyright © 2016年 lingtouniao. All rights reserved.
//

#import "LTNAgreeView.h"

@implementation LTNAgreeView

- (instancetype)initWithTitle:(NSString *)title protocol:(NSString *)protocol fontSize:(CGFloat)fontSize target:(id)targer
{
    self = [super init];
    if (self) {
        self.title = title;
        self.protocol = protocol;
        self.fontSize = fontSize;
        self.delegate = targer;
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    // 阅读并同意协议button
    UIImage * agreeImage = [UIImage imageNamed:@"checked_single"];
    UIImage * unagreeImage = [UIImage imageNamed:@"unchecked_single"];
    UIButton * agreeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, agreeImage.size.width, agreeImage.size.height)];
    [agreeButton setBackgroundImage:agreeImage forState:UIControlStateSelected];
    [agreeButton setBackgroundImage:unagreeImage forState:UIControlStateNormal];
    [agreeButton addTarget:self action:@selector(clickedAgreeButton:) forControlEvents:UIControlEventTouchUpInside];
    [self clickedAgreeButton:agreeButton];
    [self addSubview:agreeButton];
    
    // 阅读并同意协议label
    UILabel * titleLabel = [UILabel createLabelWithText:self.title font:kFont(self.fontSize) color:kBlackColor];
    titleLabel.left = agreeButton.right + 5;
    [self addSubview:titleLabel];
    
    UIButton * protocolButton = [UIButton createButtonWithTitle:self.protocol color:kMainColor font:kFont(self.fontSize) block:^(UIButton *btn) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(agreeViewWillShowProtocol:)]) {
            [self.delegate agreeViewWillShowProtocol:self];
        }
    }];
    [protocolButton sizeToFit];
    protocolButton.left = titleLabel.right;
    [self addSubview:protocolButton];
    
    self.width = protocolButton.right;
    self.height = MAX(agreeButton.height, titleLabel.height);
    titleLabel.centerY = protocolButton.centerY = agreeButton.centerY = self.height * 0.5;
}

- (void)clickedAgreeButton:(UIButton *)agreeButton
{
    agreeButton.selected = !agreeButton.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(agreeView:willAgreeProtocol:)]) {
        [self.delegate agreeView:self willAgreeProtocol:agreeButton.selected];
    }
}

@end

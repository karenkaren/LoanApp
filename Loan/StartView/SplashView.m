//
//  SplashView.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/10.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "SplashView.h"

static NSInteger seconds = 4;

@interface SplashView ()

@property(nonatomic, strong) UIButton * skipButton;
@property(nonatomic, strong) NSTimer * timer;

@end

@implementation SplashView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self buildUI];
    }
    return self;
}

- (void)buildUI
{
    // todo:判断是否需要显示
    // 可运营图片
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.image = [UIImage imageNamed:@"viewcontroller_data_empty"];
    [self addSubview:imageView];
    
    // 跳过按钮
    NSString * skipTitle = [NSString stringWithFormat:@"跳过\n%lds", seconds];
    self.skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.skipButton.backgroundColor = [UIColor redColor];
    [self.skipButton setTitle:skipTitle forState:UIControlStateNormal];
    [self.skipButton addTarget:self action:@selector(skip) forControlEvents:UIControlEventTouchUpInside];
    self.skipButton.size = CGSizeMake(40, 40);
    self.skipButton.top = 22;
    self.skipButton.right = self.width - 12;
    self.skipButton.backgroundColor = kRGBAColor(0, 0, 0, 0.6);
    self.skipButton.layer.cornerRadius = self.skipButton.width * 0.5;
    self.skipButton.layer.masksToBounds = YES;
    self.skipButton.titleLabel.numberOfLines = 0;
    self.skipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.skipButton];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCountdown) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    // 查看详情按钮
    UIButton * checkDetailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [checkDetailButton setTitle:@"查看详情" forState:UIControlStateNormal];
        checkDetailButton.backgroundColor = [UIColor grayColor];
        checkDetailButton.size = CGSizeMake(120, 40);
        checkDetailButton.bottom = self.height - kAdaptiveBaseIphone6(70);
        checkDetailButton.centerX = self.width * 0.5;
        checkDetailButton.backgroundColor = kHexColor(0xea5504);
        checkDetailButton.layer.cornerRadius = checkDetailButton.height * 0.5;
        checkDetailButton.layer.masksToBounds = YES;
        [checkDetailButton addTarget:self action:@selector(gotoDetail) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:checkDetailButton];
}

- (void)skip
{
    [self.timer invalidate];
    [self removeFromSuperview];
}

// 查看详情
- (void)gotoDetail
{
    [self skip];
    // todo:推出详情controller
}

- (void)updateCountdown
{
    seconds--;
    if (seconds) {
        NSString * skipTitle = [NSString stringWithFormat:@"跳过\n%lds", seconds];
        [self.skipButton setTitle:[NSString stringWithFormat:skipTitle, seconds] forState:UIControlStateNormal];
        return;
    }
    [self skip];
}

@end

//
//  StartPageManager.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/10.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "StartPageManager.h"
#import "IntroductionView.h"
#import "SplashView.h"

@implementation StartPageManager

singleton_implementation(StartPageManager)

- (instancetype)init
{
    self = [super init];
    if (self) {
        // todo:这个地方可能需要写获取splash的借口
    }
    return self;
}

- (void)showStartPage
{
#if kAlwaysShowIntroductionGuide
    [self showIntroductionPage];//引导页
#else
    if ([GlobalManager isFreshLaunch])
    {
        // 功能简介引导页
        [self showIntroductionPage];
    } else {
        // 闪屏页
//        [self showSplashPage];
    }
#endif
}

- (void)showIntroductionPage
{
    [[GlobalManager mainWindow] addSubview:[[IntroductionView alloc] init]];
}

- (void)showSplashPage
{
    [[GlobalManager mainWindow] addSubview:[[SplashView alloc] init]];
}

@end

//
//  BaseNavigationController.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/24.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationController+FinishBlock.h"

@interface BaseNavigationController : UINavigationController

@property (nonatomic, strong) UIColor * barBackgroundColor;
@property (nonatomic, strong) UIColor * borderColor;
#pragma mark 隐藏底部线条
- (void)hideBorder:(BOOL)hiden;

@end

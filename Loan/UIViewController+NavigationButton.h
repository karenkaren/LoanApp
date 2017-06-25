//
//  UIViewController+NavigationButton.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/28.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NavigationButton)

// 左侧按钮
- (void)showBackButton:(BOOL)willShow;
- (void)showCloseButton:(BOOL)willShow;
- (void)back;

@end

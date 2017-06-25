//
//  GlobalSize.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/24.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#ifndef GlobalSize_h
#define GlobalSize_h

//////////////////////////////////////////////////////
#pragma mark - 常用尺寸

// 通用尺寸 44
#define kGeneralSize 44
// 线粗
#define kLineThick (1.0 / kScreenScale)
// 左右边距
#define kCommonMargin kAdaptiveBaseIphone6(16)

#pragma mark - 屏幕尺寸
// 目标屏幕的宽
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
// 目标屏幕的高
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
// 目标屏幕尺寸
#define kScreenBounds [[UIScreen mainScreen] bounds]
// 状态栏高度
#define kStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height
// 导航栏高度
#define kNavigationBarHeight self.navigationController.navigationBar.height
// tabbar高度
#define kTabBarHeight self.tabBarController.tabBar.height

// 以iPhone6为基础适配
#define kAdaptiveBaseIphone6(height) (height * kScreenWidth / 375.0f)


#define kScreenScale [UIScreen mainScreen].scale

#pragma mark - 不同字体大小对应的行间距
#define kLineSpaceFont18 27
#define kLineSpaceFont16 23
#define kLineSpaceFont14 18
#define kLineSpaceFont12 16
#define kLineSpaceFont11 16

#endif /* GlobalSize_h */

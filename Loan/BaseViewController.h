//
//  BaseViewController.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/24.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+NetworkTips.h"
#import "UIViewController+NavigationButton.h"
#import "UIBarButtonItem+ClearBackground.h"
#import "BaseNavigationController.h"

@interface BaseViewController : UIViewController

@property (nonatomic, assign) BOOL showCloseButton;
@property (nonatomic, assign) BaseNavigationController * baseNavigationController;

@end

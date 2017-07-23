//
//  SHHomeView.h
//  Loan
//
//  Created by 王安帮 on 2017/7/18.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHHomeView : UIScrollView

@property (nonatomic, copy) void(^applyClickBlock)(UIButton * button);

@end

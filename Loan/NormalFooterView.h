//
//  NormalFooterView.h
//  Loan
//
//  Created by 王安帮 on 2017/7/1.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NormalFooterView : UIView

@property (nonatomic, copy) void(^buttonClickBlock)(UIButton * button);
- (instancetype)initWithTitle:(NSString *)title;

@end

//
//  FilterView.h
//  Loan
//
//  Created by 王安帮 on 2017/7/4.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    FilterTypeRenQi,// 人气
    FilterTypeDAE,  // 大额
    FilterTypeJSXK, // 极速下款
    FilterTypeBCZX, // 不查征信
    FilterTypeZYZY,  // 自由职业
    FilterTypeALL  // 全部
} FilterType;

@interface FilterView : UIView

//- (instancetype)initWithFrame:(CGRect)frame defaultFilterType:(FilterType)defaultFilterType;
//@property (nonatomic, copy) void(^filterChangedBlock)(UIButton * button, NSString * keyString);
- (void)setDefaultFilterType:(FilterType)defaultFilterType filterChangedBlock:(void(^)(UIButton * button, NSString * keyString))filterChangedBlock;

@end

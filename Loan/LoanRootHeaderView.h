//
//  LoanRootHeaderView.h
//  Loan
//
//  Created by 王安帮 on 2017/7/3.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    FilterTypeALL,  // 全部
    FilterTypeRenQi,// 人气
    FilterTypeDAE,  // 大额
    FilterTypeJSXK, // 极速下款
    FilterTypeBCZX, // 不查征信
    FilterTypeZYZY  // 自由职业
} FilterType;

@interface LoanRootHeaderView : UIView

@end

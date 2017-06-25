//
//  TableViewDevider.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/12/5.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableViewDevider : NSObject

+ (UIView *)getViewWithHeight:(CGFloat)height margin:(CGFloat)margin showTopLine:(BOOL)showTopLine showBottomLine:(BOOL)showBottomLine title:(NSString *)title;
+ (UIView *)getViewWithHeight:(CGFloat)height margin:(CGFloat)margin showTopLine:(BOOL)showTopLine showBottomLine:(BOOL)showBottomLine;

@end

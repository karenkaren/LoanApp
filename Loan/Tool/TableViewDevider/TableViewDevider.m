//
//  TableViewDevider.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/12/5.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "TableViewDevider.h"

@implementation TableViewDevider

+ (UIView *)getViewWithHeight:(CGFloat)height margin:(CGFloat)margin showTopLine:(BOOL)showTopLine showBottomLine:(BOOL)showBottomLine
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
    view.backgroundColor = [UIColor whiteColor];
    
    if (showTopLine) {
        UIView * topLineView = [[UIView alloc] init];
        topLineView.backgroundColor = kLineColor;
        [view addSubview:topLineView];
        
        [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(margin));
            make.width.equalTo(view).offset(-2 * margin);
            make.height.equalTo(@(kLineThick));
            make.top.equalTo(view);
        }];
    }
    
    if (showBottomLine) {
        UIView * bottomLineView = [[UIView alloc] init];
        bottomLineView.backgroundColor = kLineColor;
        [view addSubview:bottomLineView];
        
        [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(margin));
            make.width.equalTo(view).offset(-2 * margin);
            make.height.equalTo(@(kLineThick));
            make.bottom.equalTo(view);
        }];
    }
    
    return view;
}

+ (UIView *)getViewWithHeight:(CGFloat)height margin:(CGFloat)margin showTopLine:(BOOL)showTopLine showBottomLine:(BOOL)showBottomLine title:(NSString *)title
{
    UIView * view = [TableViewDevider getViewWithHeight:height margin:margin showTopLine:showTopLine showBottomLine:showBottomLine];
    
    UILabel * label = [[UILabel alloc] init];
    label.text = title;
    [label sizeToFit];
    label.font = kFont12;
    label.textColor = kHexColor(0x444444);
    [view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(margin);
        make.centerY.equalTo(view);
    }];

    return view;
}

@end

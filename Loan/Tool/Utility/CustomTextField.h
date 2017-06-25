//
//  CustomTextField.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/21.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTextField : UITextField

@property (nonatomic, assign) BOOL showSpecialClearButton;
@property (nonatomic, assign) BOOL drawLeftLine;
@property (nonatomic, assign) BOOL drawRightLine;
@property (nonatomic, assign) BOOL drawTopLine;
@property (nonatomic, assign) BOOL drawBottomLine;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, strong) UIColor * lineColor;
@property (nonatomic, assign) NSUInteger limitedCount;

@property (nonatomic, strong) UILabel * leftLabel;

- (instancetype)initWithPlaceholder:(NSString *)placeholder;
- (instancetype)initWithPlaceholder:(NSString *)placeholder insets:(UIEdgeInsets)insets;

- (instancetype)initWithFrame:(CGRect)frame leftTitle:(NSString *)leftTitle placeHolder:(NSString *)placeHolder;
- (instancetype)initWithFrame:(CGRect)frame leftIconName:(NSString *)iconName placeHolder:(NSString *)placeHolder;

- (instancetype)initWithLeftTitle:(NSString *)leftTitle placeHolder:(NSString *)placeHolder;
- (instancetype)initWithLeftIconName:(NSString *)iconName placeHolder:(NSString *)placeHolder;

@end

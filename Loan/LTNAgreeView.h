//
//  LTNAgreeView.h
//  lingtouniao
//
//  Created by LiuFeifei on 16/1/21.
//  Copyright © 2016年 lingtouniao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LTNAgreeView;

@protocol LTNAgreeViewDelegate <NSObject>

@optional
- (void)agreeViewWillShowProtocol:(LTNAgreeView *)agreeView;
- (void)agreeView:(LTNAgreeView *)agreeView willAgreeProtocol:(BOOL)agree;

@end

@interface LTNAgreeView : UIView

@property (nonatomic, copy) NSString * protocol;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, weak) id<LTNAgreeViewDelegate> delegate;

- (instancetype)initWithTitle:(NSString *)title protocol:(NSString *)protocol fontSize:(CGFloat)fontSize target:(id)targer;

@end

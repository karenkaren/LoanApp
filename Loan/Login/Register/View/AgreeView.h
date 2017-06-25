//
//  AgreeView.h
//  LingTouNiaoLoan
//
//  Created by LiuFeifei on 17/3/28.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AgreeViewDelegate <NSObject>

@optional
- (void)agreeViewWillShowProtocolWithIndex:(NSInteger)index;
- (void)agreeViewWillAgreeProtocol:(BOOL)agree;

@end

@interface AgreeView : UIView

@property (nonatomic, weak) id<AgreeViewDelegate> delegate;

- (instancetype)initWithTitle:(NSString *)title protocol:(NSString *)protocol otherProtocol:(NSString *)otherProtocol fontSize:(CGFloat)fontSize target:(id)targer;

@end

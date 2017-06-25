//
//  MessageBox.m
//  LingTouNiaoLoan
//
//  Created by LiuFeifei on 17/1/19.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

#import "MessageBox.h"

@implementation MessageBox

#pragma mark 提示框，定时消失
+ (void)boxShowWithMessage:(NSString *)message onView:(UIView *)view duration:(NSTimeInterval)duration
{
    [[view viewWithTag:2016] removeFromSuperview];
    CGSize size = [message boundingRectWithSize:CGSizeMake(view.bounds.size.width - 80, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:kFont(18)} context:nil].size;
    CGFloat width = size.width + 20;
    CGFloat height = size.height + 10;
    
    UIView * textView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    textView.tag = 2016;
    textView.backgroundColor = [UIColor blackColor];
    textView.alpha = 0.9;
    textView.layer.cornerRadius = 10;
    textView.layer.masksToBounds = YES;
    textView.center = CGPointMake(view.bounds.size.width * 0.5, view.bounds.size.height * 0.5);
    
    UILabel * messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, size.width, size.height)];
    messageLabel.font = kFont(18);
    messageLabel.textColor = [UIColor whiteColor];
    messageLabel.text = message;
    messageLabel.numberOfLines = 0;
    [textView addSubview:messageLabel];
    [view addSubview:textView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1.0f animations:^{
            textView.alpha = 0;
        } completion:^(BOOL finished) {
            [textView removeFromSuperview];
        }];
    });
}

+ (void)boxShowWithMessage:(NSString *)message duration:(NSTimeInterval)duration
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [self boxShowWithMessage:message onView:window duration:duration];
}

+ (void)boxShowWithMessage:(NSString *)message onView:(UIView *)view
{
    [self boxShowWithMessage:message onView:view duration:2.0f];
}

+ (void)boxShowWithMessage:(NSString *)message
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [self boxShowWithMessage:message onView:window duration:2.0f];
}

#pragma mark 提示框，网络访问时出现，访问成功消失
+ (void)boxShowLoadWithMessage:(NSString *)message onView:(UIView *)view
{
    UIView * boxView = [[UIView alloc] init];
    boxView.backgroundColor = [UIColor blackColor];
    boxView.alpha = 0.9;
    boxView.tag = 70000;
    CGSize size = CGSizeMake(60, 60);
    if (esString(message).length) {
        size = [message boundingRectWithSize:CGSizeMake(view.bounds.size.width - 80, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:kFont(18)} context:nil].size;
        size.width += 40;
        size.height += 30 + 60;
    }
//    CGFloat width = size.width + 40;
//    CGFloat height = size.height + 30 + 60;
    boxView.bounds = CGRectMake(0, 0, size.width, size.height);
    boxView.center = CGPointMake(view.bounds.size.width * 0.5, view.bounds.size.height * 0.5);
    boxView.layer.cornerRadius = 5;
    boxView.layer.masksToBounds = YES;
    [view addSubview:boxView];
    
    if (esString(message).length) {
        UILabel * messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, size.width + 20, size.height + 10)];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.text = message;
        messageLabel.numberOfLines = 0;
        messageLabel.font = kFont(18);
        [boxView addSubview:messageLabel];
    }
    
    UIActivityIndicatorView * activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((size.width - 40) / 2, (size.width - 40) / 2, 40, 40)];
    activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    activityView.tintColor = [UIColor whiteColor];
    [activityView startAnimating];
    [boxView addSubview:activityView];
}

+ (void)boxShowLoadWithMessage:(NSString *)message
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [self boxShowLoadWithMessage:message onView:window];
}

+ (void)removeLoadMessageBoxFromView:(UIView *)view
{
    UIView * boxView = [view viewWithTag:70000];
    [boxView removeFromSuperview];
}

+ (void)removeLoadMessageBox
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self removeLoadMessageBoxFromView:window];
}

@end

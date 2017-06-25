//
//  UIBarButtonItem+ClearBackground.h
//  Giglr
//
//  Created by Zhu Yuzhou on 9/19/12.
//  Copyright (c) 2012 Giglr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ClearBackground)
+ (UIBarButtonItem*)barItemWithImage:(UIImage*)image highlightImage:(UIImage *)highlightImage target:(id)target action:(SEL)action;
//+ (UIBarButtonItem*)barItemWithImage:(UIImage*)image disableImage:(UIImage *)disableImage target:(id)target action:(SEL)action;
    + (UIBarButtonItem*)barItemWithImage:(UIImage*)image target:(id)target action:(SEL)action;


+ (UIBarButtonItem*)barItemWithTitle:(NSString*)title target:(id)target action:(SEL)action;
+ (UIBarButtonItem*)barItemWithTitle:(NSString*)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action;
+ (UIBarButtonItem*)barItemWithTitle:(NSString*)title image:(UIImage *)image highlightImage:(UIImage *)highlightImage style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action;
+ (UIBarButtonItem*)backBarItemWithTitle:(NSString*)title target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)closeBarItemWithTitle:(NSString*)title target:(id)target action:(SEL)action;

+ (UIBarButtonItem*)barItemWithTitle:(NSString*)title target:(id)target action:(SEL)action andTextColor:(UIColor*)color;

+ (UIBarButtonItem*)barItemWithTitle:(NSString*)title target:(id)target action:(SEL)action andTextColor:(UIColor*)color andIsRight:(NSInteger)isflag;

+ (UIBarButtonItem*)barItemWithTitle:(NSString*)title image:(UIImage *)image highlightImage:(UIImage *)highlightImage style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action space:(CGFloat)space;

@end

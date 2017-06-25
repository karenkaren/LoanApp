//
//  UINavigationItem+NegativeSeperator.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/30.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "UINavigationItem+NegativeSeperator.h"

@implementation UINavigationItem (NegativeSeperator)

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
- (void)setLeftBarButtonItem:(UIBarButtonItem *)_leftBarButtonItem
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSeperator.width = -16;
        
        if (_leftBarButtonItem)
        {
            [self setLeftBarButtonItems:@[negativeSeperator, _leftBarButtonItem]];
        }
        else
        {
            [self setLeftBarButtonItems:@[negativeSeperator]];
        }
    }
    else
    {
        [self setLeftBarButtonItem:_leftBarButtonItem animated:NO];
    }
}

//- (void)setRightBarButtonItem:(UIBarButtonItem *)_rightBarButtonItem
//{
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
//    {
//        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//        negativeSeperator.width = -16;
//        if (_rightBarButtonItem)
//        {
//            [self setRightBarButtonItems:@[negativeSeperator, _rightBarButtonItem]];
//        }
//        else
//        {
//            [self setRightBarButtonItems:@[negativeSeperator]];
//        }
//    }
//    else
//    {
//        [self setRightBarButtonItem:_rightBarButtonItem animated:NO];
//    }
//}

#endif

@end

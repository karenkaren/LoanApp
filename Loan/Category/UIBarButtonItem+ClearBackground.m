//
//  UIBarButtonItem+ClearBackground.m
//  Giglr
//
//  Created by Zhu Yuzhou on 9/19/12.
//  Copyright (c) 2012 Giglr. All rights reserved.
//

#import "UIBarButtonItem+ClearBackground.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIBarButtonItem (ClearBackground)

+ (UIBarButtonItem*)barItemWithImage:(UIImage*)image target:(id)target action:(SEL)action{
    return [UIBarButtonItem barItemWithImage:image highlightImage:nil target:target action:action];
}

+ (UIBarButtonItem*)barItemWithImage:(UIImage*)image highlightImage:(UIImage *)highlightImage target:(id)target action:(SEL)action{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    double version = [[UIDevice currentDevice].systemVersion doubleValue];
    if(version < 7.0f) {
        button.frame = CGRectMake(0, 0, image.size.width + 24.0f, image.size.height);
    } else {
        button.frame = CGRectMake(0, 0, image.size.width + 20.0f, image.size.height);
    }

    [button setImage:image forState:UIControlStateNormal];
    if (!highlightImage) {
        [button setImage:highlightImage forState:UIControlStateHighlighted];
    }

    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return barButton;
}

+ (UIBarButtonItem*)barItemWithTitle:(NSString*)title target:(id)target action:(SEL)action
{
    return [self barItemWithTitle:title style:UIBarButtonItemStyleDone target:target action:action];
}

+ (UIBarButtonItem*)barItemWithTitle:(NSString*)title target:(id)target action:(SEL)action andTextColor:(UIColor*)color andIsRight:(NSInteger)isflag
{
    return [self barItemWithTitle:title style:UIBarButtonItemStyleDone target:target action:action andColor:color andIsRight:isflag];
}

+ (UIBarButtonItem*)barItemWithTitle:(NSString*)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action andColor:(UIColor*)color andIsRight:(NSInteger)isflag
{
     return [self barItemWithTitle:title image:nil highlightImage:nil style:style target:target action:action andColor:color andIsRight:isflag];
}

+ (UIBarButtonItem*)barItemWithTitle:(NSString*)title image:(UIImage *)image highlightImage:(UIImage *)highlightImage style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action andColor:(UIColor*)color andIsRight:(NSInteger)isflag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat width = 0;
    button.frame = CGRectMake(0, 0, width, 32);
    
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highlightImage forState:UIControlStateHighlighted];
    
     button.frame = CGRectMake(0, 0, width, 32);
    [button setTitle:title forState:UIControlStateNormal];
    if (color)
    {
        [button setTitleColor:color forState:UIControlStateNormal];
        [button setTitleColor:[color colorWithAlphaComponent:0.3]forState:UIControlStateHighlighted];
    }else
    {
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    
    button.titleLabel.font = kFont(16);
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [button sizeToFit];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return barButton;
}


+ (UIBarButtonItem*)barItemWithTitle:(NSString*)title target:(id)target action:(SEL)action andTextColor:(UIColor*)color
{
    return [self barItemWithTitle:title style:UIBarButtonItemStyleDone target:target action:action andColor:color];
}
+ (UIBarButtonItem*)barItemWithTitle:(NSString*)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action andColor:(UIColor*)color
{
      return [self barItemWithTitle:title image:nil highlightImage:nil style:style target:target action:action andColor:color];
}

+ (UIBarButtonItem*)barItemWithTitle:(NSString*)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action
{
    return [self barItemWithTitle:title image:nil highlightImage:nil style:style target:target action:action];
}

+ (UIBarButtonItem*)barItemWithTitle:(NSString*)title image:(UIImage *)image highlightImage:(UIImage *)highlightImage style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action andColor:(UIColor*)color
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highlightImage forState:UIControlStateHighlighted];
//    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    if (VERSION_7_0_EARLIER) {
//        [button setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    }
    //    [button setImageEdgeInsets:UIEdgeInsetsMake(0.0f, 35, 0.0f, 0.0f)];
    [button setTitle:title forState:UIControlStateNormal];
    [button sizeToFit];
//    button.width += 2 * kCommonMargin;
    if (color)
    {
       [button setTitleColor:color forState:UIControlStateNormal];
    
        [button setTitleColor:[color colorWithAlphaComponent:0.3]forState:UIControlStateHighlighted];
    }else
    {
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    
    button.titleLabel.font = kFont(16);
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return barButton;

}

+ (UIBarButtonItem*)barItemWithTitle:(NSString*)title image:(UIImage *)image highlightImage:(UIImage *)highlightImage style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat width = 0;
    button.frame = CGRectMake(0, 0, width, 32);
    
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highlightImage forState:UIControlStateHighlighted];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    if (VERSION_7_0_EARLIER) {
        [button setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    }
//    [button setImageEdgeInsets:UIEdgeInsetsMake(0.0f, 35, 0.0f, 0.0f)];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [button setTitleColor:COLOR_BUTTON_TITLE_HIGHLIGHT_PINK forState:UIControlStateHighlighted];
//    [button setTitleColor:COLOR_BUTTON_TITLE_HIGHLIGHT_PINK forState:UIControlStateDisabled];
    
    button.titleLabel.font = kFont(16);
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [button sizeToFit];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return barButton;
}

+ (UIBarButtonItem*)barItemWithTitle:(NSString*)title image:(UIImage *)image highlightImage:(UIImage *)highlightImage style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action space:(CGFloat)space
{
    UIView *buttonView = [[UIView alloc] init];

    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];

    UILabel *label = [[UILabel alloc] init];
    label.font = kFont(16);
    label.textColor = [UIColor blackColor];

    label.text = title;
    [label sizeToFit];

    [buttonView addSubview:imageView];
    [buttonView addSubview:label];
    if (imageView.width <= 1 || label.width <= 1) {
        space = 0;
    }
    buttonView.size = CGSizeMake(10 + imageView.width + space + label.width, MIN(kGeneralSize, MAX(imageView.height, label.height)));
    imageView.centerY = label.centerY = buttonView.width * 0.5;
    imageView.left = 10;
    label.left = imageView.right + space;

    [buttonView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:target action:action]];

    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:buttonView];

    return barButton;
}

+ (UIBarButtonItem *)closeBarItemWithTitle:(NSString*)title target:(id)target action:(SEL)action
{
    UIBarButtonItem *barItem = [self barItemWithTitle:title target:target action:action];
    
    UIButton *button = (UIButton *)barItem.customView;
    
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    return barItem;
}

+ (UIBarButtonItem*)backBarItemWithTitle:(NSString*)title target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    NSDictionary *ats = @{
                          NSFontAttributeName : kFont(14),
                          };
    CGSize stringsize = [title sizeWithAttributes:ats];
    button.frame = CGRectMake(0, 0, 28+stringsize.width, 40);
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 0.0)];
    UIImage *normalBG = [UIImage imageNamed:@"btn_nav_back"];
    normalBG = [normalBG stretchableImageWithLeftCapWidth:16 topCapHeight:8];
    UIImage *downBG = [UIImage imageNamed:@"btn_nav_back_down"];
    downBG = [downBG stretchableImageWithLeftCapWidth:16 topCapHeight:8];
    [button setBackgroundImage:normalBG forState:UIControlStateNormal];
    [button setBackgroundImage:downBG forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = kFont(14);
    button.titleLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
    button.titleLabel.layer.shadowOffset = CGSizeMake(0, 1);
    button.titleLabel.layer.shadowOpacity = 0.3f;
    button.titleLabel.layer.shadowRadius = 0;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return barButton;
}


@end

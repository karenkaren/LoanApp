//
//  BaseNavigationController.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/24.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@property (strong, nonatomic) UIView * navigationBottomLine;

@end

@implementation BaseNavigationController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // 透明度
    self.navigationBar.translucent = NO;
    // 背景色
    self.barBackgroundColor = kWhiteColor;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //藏旧
    [self hideBorderInView:self.navigationBar];
    //添新
    [self.navigationBar addSubview:self.navigationBottomLine];
}

#pragma mark - getter methods
#pragma mark -- 自定义的底部线条
- (UIView *)navigationBottomLine
{
    if (!_navigationBottomLine) {
        _navigationBottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, kGeneralSize, kScreenWidth, 1.0 / kScreenScale)];
        _navigationBottomLine.backgroundColor = kLineColor;
    }
    return _navigationBottomLine;
}

#pragma mark - private methods
#pragma mark -- 查找系统navigationbar底部线条并隐藏
- (void)hideBorderInView:(UIView *)view{

    if ([view isKindOfClass:[UIImageView class]]
        && view.frame.size.height <= 1) {
        view.hidden = YES;
    }
    for (UIView *subView in view.subviews) {
        [self hideBorderInView:subView];
    }
}

#pragma mark -- 隐藏自定义底部线条
- (void)hideBorder:(BOOL)hiden
{
    self.navigationBottomLine.hidden = hiden;
}

#pragma mark setter methods
- (void)setBarBackgroundColor:(UIColor *)barBackgroundColor
{
    _barBackgroundColor = barBackgroundColor;
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:barBackgroundColor] forBarMetrics:UIBarMetricsDefault];
}

- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    self.navigationBottomLine.backgroundColor = borderColor;
}

#pragma mark override
- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.topViewController;
}

//#pragma mark - 自定义导航栏
//- (void)setLeftBarButtonItem:(UIBarButtonItem *)barButtonItem
//{
//    //    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:barButtonItem.target action:barButtonItem.action];
//    //    negativeSpacer.width = 15;
//    
//    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:barButtonItem, nil];
//}
//
//- (void)setRightBarButtonItem:(UIBarButtonItem *)barButtonItem
//{
//    //    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:barButtonItem.target action:barButtonItem.action];
//    //    negativeSpacer.width = 15;
//    
//    self.navigationItem.rightBarButtonItem = barButtonItem;
//}
//
//- (UIView *)addNavigationBarButtons:(NSArray *)items spaceWidth:(CGFloat)spaceWidth
//{
//    if (items.count == 0) {
//        return nil;
//    }
//    //for adjust rightBarButtonItem's right position
//    CGFloat var = 0;
//    
//    CGFloat width = 0;
//    UIView *customView = [[UIView alloc] init];
//    customView.height = NavigationBarHeight;
//    
//    for (UIView *subItem in items) {
//        if (![subItem isKindOfClass:[UIView class]]) {
//            continue;
//        }
//        [customView addSubview:subItem];
//        subItem.centerY = customView.width * 0.5 - 1;  //adjust 1 point per UI request
//        subItem.left = width;
//        width += subItem.width + spaceWidth;
//    }
//    width -= spaceWidth;
//    
//    if (items.count > 1) {
//        customView.width = width - var;
//    } else {
//        customView.width = width;
//    }
//    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:customView];
//    self.navigationItem.rightBarButtonItem = item;
//    return customView;
//}
//
//- (void)setCustomTitle:(NSString *)title{
//    self.navigationItem.title = title;
//}
//
//- (void)setCustomTitleUntilAppear:(NSString *)title
//{
//    [self setCustomTitle:title untilViewAppear:YES];
//}
//
//
//- (void)setCustomTitle:(NSString *)title untilViewAppear:(BOOL)untilViewAppear
//{
//    if (_navLabel == nil) {
//        _navLabel = [[UINavTitleLabel alloc] initWithFrame:CGRectZero];
//        [_navLabel setClipsToBounds:YES];
//        [_navLabel setBackgroundColor:[UIColor clearColor]];
//    }
//    
//    self.navLabel.text = title;
//    [self.navLabel sizeToFit];
//    
//    if(!untilViewAppear || _didAppear){
//        self.navigationItem.titleView = nil;
//        self.navigationItem.titleView = self.navLabel;
//    }else{
//        //_titleWillBeSetted = title;
//        titleViewToSetWhenAppear = self.navLabel;
//    }
//}
//
//- (UINavTitleLabel *)navLabel{
//    if (_navLabel == nil) {
//        _navLabel = [[UINavTitleLabel alloc] initWithFrame:CGRectZero];
//        [_navLabel setClipsToBounds:YES];
//        [_navLabel setBackgroundColor:[UIColor clearColor]];
//    }
//    return _navLabel;
//}
//
//- (void)setCustomTitle:(NSString *)title iconName:(NSString *)iconName highlightIconName:(NSString *)highlightIconName target:(id)target action:(SEL)action{
//    
//    [self setCustomTitle:title
//                iconName:iconName
//       highlightIconName:highlightIconName
//                  target:target
//                  action:action
//         untilViewAppear:NO];
//    
//}
//
//
//- (void)setCustomTitle:(NSString *)title iconName:(NSString *)iconName highlightIconName:(NSString *)highlightIconName target:(id)target action:(SEL)action untilViewAppear:(BOOL)untilViewAppear
//{
//    _navLabel = [[UINavTitleLabel alloc] initWithFrame:CGRectZero];
//    [_navLabel setClipsToBounds:YES];
//    [_navLabel setBackgroundColor:[UIColor clearColor]];
//    
//    _navLabel.text = title;
//    [_navLabel sizeToFit];
//    
//    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
//    _navLabel.left = 0;
//    _navLabel.top = (titleView.height-_navLabel.height)/2;
//    [titleView addSubview:_navLabel];
//    
//    
//    UIImage *image = [UIImage imageNamed:iconName];
//    UIButton *titleButton = [Utility createButtonWithFrame:CGRectMake(_navLabel.right, 0, image.size.width+10, titleView.height) iconName:iconName target:target action:action];
//    [titleButton setImage:[UIImage imageNamed:highlightIconName] forState:UIControlStateHighlighted];
//    [titleView addSubview:titleButton];
//    [titleButton setEnlargeEdge:20];
//    titleView.width = titleButton.right;
//    
//    if (!untilViewAppear || _didAppear) {
//        titleViewToSetWhenAppear = nil;
//        self.navigationItem.titleView = nil;
//        self.navigationItem.titleView = titleView;
//    }else{
//        titleViewToSetWhenAppear = titleView;
//    }
//    
//}

@end

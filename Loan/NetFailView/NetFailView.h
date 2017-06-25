//
//  NetFailView.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/25.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TouchNetFailViewBlock)(UIView *view);

@interface NetFailView : UIView

@property (nonatomic, strong) UIImageView *failIm;
@property (nonatomic, strong) UILabel *remindeLabel;
@property (nonatomic, strong) UILabel *subRemindeLabel;
@property (nonatomic, retain) UIImage *iconImage;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *subMessage;
@property (nonatomic, copy) NSString *imName;

@property (nonatomic, strong) UIView *customView;

@property (nonatomic,copy) TouchNetFailViewBlock touchNetFailView;

@property (nonatomic, strong, readonly) UITapGestureRecognizer *tapGesture;

- (id)initWithFrame:(CGRect)frame;

@end

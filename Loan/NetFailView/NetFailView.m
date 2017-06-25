//
//  NetFailView.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/25.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "NetFailView.h"

#define REMINDELABEL_SIZE 60

@implementation NetFailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self setBackgroundColor:[UIColor clearColor]];
        [self setAlpha:0.6];
        _remindeLabel = [[UILabel alloc] init];
        [_remindeLabel setBackgroundColor:[UIColor clearColor]];
        _remindeLabel.textColor = [UIColor blackColor];
        //[UIColor colorWithHex:0xa6a6a6 alpha:1.];
        _remindeLabel.font = kFont(16);
        _remindeLabel.numberOfLines = 0;
        _remindeLabel.textAlignment = NSTextAlignmentCenter;
        _remindeLabel.frame = CGRectMake(20, 0, self.bounds.size.width-40, 16);
        _remindeLabel.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        [self addSubview:_remindeLabel];
        
        
        _subRemindeLabel = [[UILabel alloc] init];
        [_subRemindeLabel setBackgroundColor:[UIColor clearColor]];
        _subRemindeLabel.textColor = [UIColor colorWithHex:0xa6a6a6 alpha:1.];
        _subRemindeLabel.font = kFont(13);
        _subRemindeLabel.numberOfLines = 0;
        _subRemindeLabel.textAlignment = NSTextAlignmentCenter;
        _subRemindeLabel.frame = CGRectMake(20, 0, self.bounds.size.width-40, 13);
        _subRemindeLabel.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        [self addSubview:_subRemindeLabel];
        
        _failIm = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_failIm];
        
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:_tapGesture];
    }
    return self;
}

- (void)setImName:(NSString *)imName
{
    _imName = imName;
    
    UIImage *im = [UIImage imageNamed:imName];
    self.iconImage = im;
    
    [self setNeedsLayout];
}

- (void)setIconImage:(UIImage *)iconImage{
    _iconImage = iconImage;
    _failIm.image = _iconImage;
    [self setNeedsLayout];
}

- (void)setMessage:(NSString *)message{
    
    _message = message;
    _remindeLabel.text = message;
    
    [self setNeedsLayout];
}

- (void)setSubMessage:(NSString *)subMessage{
    if(!subMessage)
        subMessage=@"";
    _subMessage=subMessage;
    _subRemindeLabel.text=subMessage;
    [self setNeedsLayout];
}

- (void)setCustomView:(UIView *)customView{
    _customView = customView;
    if (_customView == nil) {
        _remindeLabel.hidden = NO;
        _subRemindeLabel.hidden=NO;
        _failIm.hidden = NO;
    }else{
        _remindeLabel.hidden = YES;
        _subRemindeLabel.hidden=YES;
        _failIm.hidden = YES;
        [self addSubview:_customView];
    }
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (_customView) {
        _customView.center = CGPointMake(_customView.bounds.size.width * 0.5, _customView.bounds.size.height * 0.5);
    }else{
        UIImage *im = _failIm.image;
        _failIm.frame = CGRectMake(0, 0,kAdaptiveBaseIphone6(im.size.width*750/1080), kAdaptiveBaseIphone6(im.size.height*750/1080));
        _failIm.center =CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2 -_failIm.frame.size.height/2.-kAdaptiveBaseIphone6(30));
        //[_remindeLabel sizeToFit];
        _remindeLabel.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        //[_subRemindeLabel sizeToFit];
        _subRemindeLabel.center =CGPointMake(_remindeLabel.center.x, _remindeLabel.center.y+kAdaptiveBaseIphone6(30));
    }
}

- (void)tapAction:(UITapGestureRecognizer *)aTapGesture{
    if (_touchNetFailView) {
        _touchNetFailView(self);
    }
}

@end

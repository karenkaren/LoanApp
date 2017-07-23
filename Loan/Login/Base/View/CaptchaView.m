//
//  CaptchaView.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/12/5.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "CaptchaView.h"

#define kTimeCount 60
static NSInteger timeCount = kTimeCount;

@interface CaptchaView ()
{
    UIColor * _textColor;
    NSInteger _fontSize;
    CGFloat _captchaButtonWidth;
}

@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic, assign) NSInteger limitedCount;
@property (nonatomic, assign, getter=isMessageCode) BOOL isMessageCode;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * iconName;
@property (nonatomic, copy) NSString * placeholder;

@end

@implementation CaptchaView

- (instancetype)initWithPlaceholder:(NSString *)placeholder messageCode:(BOOL)messageCode limitedCount:(NSInteger)limitedCount
{
    self = [super init];
    if (self) {
        self.isMessageCode = messageCode;
        self.limitedCount = limitedCount;
        self.placeholder = placeholder;
        _captchaButtonWidth = messageCode ? 110 : 50;
        _fontSize = 14;
        [self buildUI];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder messageCode:(BOOL)messageCode limitedCount:(NSInteger)limitedCount
{
    self = [super init];
    if (self) {
        self.title = title;
        self.isMessageCode = messageCode;
        self.limitedCount = limitedCount;
        self.placeholder = placeholder;
        _captchaButtonWidth = messageCode ? 110 : 50;
        _fontSize = 14;
        [self buildUI];
    }
    return self;
}

- (instancetype)initWithIconName:(NSString *)iconName placeholder:(NSString *)placeholder messageCode:(BOOL)messageCode limitedCount:(NSInteger)limitedCount
{
    self = [super init];
    if (self) {
        self.iconName = iconName;
        self.isMessageCode = messageCode;
        self.limitedCount = limitedCount;
        self.placeholder = placeholder;
        _captchaButtonWidth = messageCode ? 110 : 50;
        _fontSize = 14;
        [self buildUI];
    }
    return self;
}

- (void)buildUI
{
    [self addSubview:self.captchaTextField];
    self.captchaTextField.limitedCount = self.limitedCount;
    
    if (!self.isMessageCode) {
        self.captchaButton = [UIButton createButtonWithIconName:@"placeholder_refresh" block:^(UIButton *button) {
            if (self.getCaptchaClickBlock) {
                self.getCaptchaClickBlock(button);
            }
        }];
    } else {
        self.captchaButton = [UIButton createButtonWithTitle:@"获取短信验证码" color:kLinkColor font:kFont(_fontSize) block:^(UIButton * button) {
            if (self.getCaptchaClickBlock) {
                self.getCaptchaClickBlock(button);
            }
        }];
        [self.captchaButton setTitleColor:kColor999999 forState:UIControlStateDisabled];
    }
    [self addSubview:self.captchaButton];
    
    UIView * bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = kLineColor;
    [self addSubview:bottomLine];
    
    UIView * verticalLine = [[UIView alloc] init];
    verticalLine.backgroundColor = kLineColor;
    [self addSubview:verticalLine];
    
    [self.captchaTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self).offset(-_captchaButtonWidth);
        make.top.left.height.equalTo(self);
    }];
    [self.captchaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.captchaTextField);
        make.width.equalTo(@(_captchaButtonWidth));
        make.top.right.equalTo(self);
    }];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.bottom.equalTo(self.captchaButton);
        make.height.equalTo(@(kLineThick));
    }];
    [verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.equalTo(self.captchaButton);
        make.width.equalTo(@(kLineThick));
        make.height.equalTo(self).offset(-20);
    }];
}

- (CustomTextField *)captchaTextField
{
    if (!_captchaTextField) {
        if (![esString(self.iconName) isEqualToString:@""]) {
            _captchaTextField = [[CustomTextField alloc] initWithLeftIconName:self.iconName placeHolder:self.placeholder];
        } else if (![esString(self.title) isEqualToString:@""]) {
            _captchaTextField = [[CustomTextField alloc] initWithLeftTitle:self.title placeHolder:self.placeholder];
        } else {
            _captchaTextField = [[CustomTextField alloc] initWithPlaceholder:self.placeholder];
        }
        _captchaTextField.drawBottomLine = YES;
        _captchaTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _captchaTextField;
}

- (void)upateTimer
{
    NSString * timeString = [NSString stringWithFormat:@"%ld秒后重新获取", (long)timeCount--];
    [self.captchaButton setTitle:timeString forState:UIControlStateDisabled];
    if (timeCount < 0) {
        [self stopTimer];
    }
}

- (void)startTimer
{
    self.captchaButton.enabled = NO;
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(upateTimer) userInfo:nil repeats:YES];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resumeTimer) name:UIApplicationWillEnterForegroundNotification object:nil];
    }
    [self.timer fire];
}

- (void)stopTimer
{
    if(self.timer) {
        [self.timer invalidate];
        self.timer = nil;
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
        self.captchaButton.enabled = YES;
        if (timeCount != kTimeCount) {
            timeCount = kTimeCount;
            [self.captchaButton setTitle:@"重新获取" forState:UIControlStateNormal];
        }
    }
}

- (void)resumeTimer
{
    NSDate * date = [[NSUserDefaults standardUserDefaults] valueForKey:kEnterBackgroundDate];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kEnterBackgroundDate];
    if (date && self.timer) {
        NSTimeInterval enterBackgroundDate = [date timeIntervalSince1970];
        NSTimeInterval nowDate = [[NSDate date] timeIntervalSince1970];
        NSTimeInterval afterTime = nowDate - enterBackgroundDate;
        if (timeCount - afterTime > 0) {
            timeCount = timeCount - floor(afterTime);
            [self upateTimer];
        } else {
            [self stopTimer];
        }
    }
}

@end

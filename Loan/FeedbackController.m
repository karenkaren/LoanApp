//
//  FeedbackController.m
//  LingTouNiaoLoan
//
//  Created by LiuFeifei on 17/1/20.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

#import "FeedbackController.h"
#import "PlaceHolderTextView.h"

@interface FeedbackController ()<UITextViewDelegate>

@property (nonatomic, strong) PlaceHolderTextView *contentTextView;
@property (nonatomic, strong) CustomButton * commitButton;

@end

@implementation FeedbackController

-(void)back
{
    NSString *string = [NSString trimSpacesOfString:_contentTextView.text];
    if (string.length > 0)
    {
        kWeakSelf
        [NSObject showAlertTitle:@"温馨提示" msg:@"您的建议还未提及，是否返回？" cancelTitle:@"取消" commitBtnTitle:@"确定" handlerBlock:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } onVC:self];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//- (void)viewDidAppear:(BOOL)animated
//{
//    DLog(@"%.2f %.2f %.2f %.2f", self.commitButton.left, self.commitButton.top, self.commitButton.width, self.commitButton.height);
//    [super viewDidAppear:animated];
//    DLog(@"%.2f %.2f %.2f %.2f", self.commitButton.left, self.commitButton.top, self.commitButton.width, self.commitButton.height);
//    
//}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"意见反馈";
    [self buildUI];
    [self registerNotifications];
}

- (void)buildUI
{
    _contentTextView = [[PlaceHolderTextView alloc] initWithFrame:CGRectMake(kCommonMargin, kCommonMargin, kScreenWidth - 2 * kCommonMargin, kAdaptiveBaseIphone6(88))];
    _contentTextView.placeholder = @"如您的问题要马上反馈，请联系公众号 “加油花”";
    _contentTextView.delegate = self;
    _contentTextView.layer.borderWidth = kLineThick;
    _contentTextView.layer.borderColor = kLineColor.CGColor;
    _contentTextView.font = kFont14;
    _contentTextView.textColor = [UIColor blackColor];
    [self.view addSubview:_contentTextView];
    
    CustomButton * commitButton = [CustomButton createMiddleBGButtonWithTitle:@"提交" actionBolck:^(UIButton *button) {
        [self commitAdvice];
    }];
    commitButton.centerX = self.view.centerX;
    commitButton.top = _contentTextView.bottom + kAdaptiveBaseIphone6(32);
    commitButton.enabled = NO;
    [self.view addSubview:commitButton];
    self.commitButton = commitButton;
    
    [commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_contentTextView.mas_bottom).offset (kAdaptiveBaseIphone6(32));
    }];
    
//    DLog(@"%.2f %.2f %.2f %.2f", commitButton.left, commitButton.top, commitButton.width, commitButton.height);
}

- (void)registerNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChange:) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)commitAdvice
{
//    if (_loading) {
//        return;
//    }
    NSString *string = [NSString trimSpacesOfString:_contentTextView.text];
    if (string.length <= 0)
    {
        kTipAlert(@"建议内容不能为空");
        return;
    }
    
//    NSDictionary *dict = @{@"feedBack" : string};
//    kWeakSelf
//    [self apiForPath:kFeedbackUrl method:kPostMethod parameter:dict responseModelClass:nil onComplete:^(id response, id data, NSError *error) {
//        if (!error) {
//            [Utility showMessageFromServer:data defaultMsg:locationString(@"feed_back_success")];
//            [weakSelf.navigationController popViewControllerAnimated:YES];
//            
//            NSArray *piwikArr=@[
//                                @[@"",@""],
//                                @[@"result",@"1"],
//                                @[@"reason",@""],
//                                @[@"content",string],
//                                @[@"datepoint",timeForStatistics()],
//                                ];
//            piwikEvent(@"feedback",piwikArr);
//            
//        }else{
//            
//            NSArray *piwikArr=@[
//                                @[@"",@""],
//                                @[@"result",@"0"],
//                                @[@"reason",esString(error.description)],
//                                @[@"content",string],
//                                @[@"datepoint",timeForStatistics()],
//                                ];
//            piwikEvent(@"feedback",piwikArr);
//            
//        }
//    }];
}

#pragma mark -- textViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    [self.contentTextView scrollRangeToVisible:NSMakeRange(self.contentTextView.text.length - 1, 1)];
    return YES;
}

//ios 7 bug导致 输入汉字 最后 一行 截断、
- (void)textViewDidChange:(UITextView *)textView
{
//    DLog(@"%@",textView.text);
//    NSString *rangeStr = [textView textInRange:textView.markedTextRange];
//    if (textView.text.length > kCommentMaxInputLength && rangeStr.length == 0) {
//        [self performSelector:@selector(delayCutText) withObject:nil afterDelay:0];
//    }else
//    {
//        // 解决 中文输入，遮挡拼音的问题
//        [self.contentTextView scrollRangeToVisible:NSMakeRange(self.contentTextView.text.length - 1, 1)];
//        
//    }
//    
    self.commitButton.enabled = [self.contentTextView.text length];
}
//
//- (void)delayCutText
//{
//    NSString *origin = [self.contentTextView.text copy];
//    NSString *shouldText = [origin substringWithRange:NSMakeRange(0, kCommentMaxInputLength)];
//    self.contentTextView.text = shouldText;
//    if (self.contentTextView.text.length > 0) {
//        [self.contentTextView scrollRangeToVisible:NSMakeRange(self.contentTextView.text.length - 1, 1)];
//    }
//}

@end

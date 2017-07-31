//
//  ShareSnsUtils.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/24.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "ShareSnsUtils.h"
#import "SocialConstants.h"
#import <UShareUI/UShareUI.h>

#define kDefaultLogoUrl [NSString stringWithFormat:@"%@%@", API_BASE_URL, @"/logo/logo.png"]

@interface ShareSnsUtils ()

@property (nonatomic, strong) UIViewController * currentController;

@end

@implementation ShareSnsUtils

#pragma mark - 分享
//+ (void)shareSnsOnViewController:(UIViewController *)viewController delegate:(id<UMSocialUIDelegate>)delegeta
//{
//    NSString * shareTitle = @"分享名称";
//    NSString * shareText = @"分享内容";//分享内嵌文字
//    NSString * shareImage = kDefaultLogoUrl;
//    [self shareSnsOnViewController:viewController shareTitle:shareTitle shareText:shareText shareImage:shareImage shareUrl:defaultUrlForShare delegate:delegeta];
//}
//
//+ (void)shareSnsOnViewController:(UIViewController *)viewController shareTitle:(NSString *)shareTitle shareText:(NSString *)shareText shareImage:(NSString *)shareImage shareUrl:(NSString *)shareUrl delegate:(id<UMSocialUIDelegate>)delegate
//{
//    UIImage * shareImageResource = [UIImage imageNamed:@"defaultIcon"];
//    if ([shareImage hasPrefix:@"http"]) {
//        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:shareImage]];
//        NSError *error = nil;
//        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
//        if (!error && data.length) {
//            shareImageResource = [UIImage imageWithData:data] ? : [UIImage imageNamed:@"defaultIcon"];
//        }
//    }
//
//    [UMSocialData defaultData].extConfig.title = esString(shareTitle);
//    NSString * extConfigShareText = [NSString stringWithFormat:@"%@ %@", shareText, shareUrl ? : defaultUrlForShare];
//    [UMSocialData defaultData].extConfig.sinaData.shareText = extConfigShareText;
//    [UMSocialData defaultData].extConfig.smsData.shareText = extConfigShareText;
//    [UMSocialData defaultData].extConfig.smsData.shareImage = [UIImage new];
//    NSString * urlShare = esString(shareUrl ? : defaultUrlForShare);
//    [UMSocialData defaultData].extConfig.wechatSessionData.url = urlShare;
//    [UMSocialData defaultData].extConfig.wechatTimelineData.url = urlShare;
//    [UMSocialData defaultData].extConfig.qqData.url = urlShare;
//    [UMSocialSnsService presentSnsIconSheetView:viewController
//                                         appKey:UMENG_APP_KEY
//                                      shareText:esString(shareText)
//                                     shareImage:shareImageResource
//                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToSina,UMShareToSms]
//                                       delegate:delegate];
//}

- (void)shareOnViewController:(UIViewController *)viewController
{
    self.currentController = viewController;
    //加入copy的操作
    //@see http://dev.umeng.com/social/ios/进阶文档#6
    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_None;
    
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        
        //在回调里面获得点击的
        if (platformType == UMSocialPlatformType_UserDefine_Begin+2) {
            NSLog(@"点击演示添加Icon后该做的操作");
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"添加自定义icon"
                                                                message:@"具体操作方法请参考UShareUI内接口文档"
                                                               delegate:nil
                                                      cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                                      otherButtonTitles:nil];
                [alert show];
                
            });
        }
        else{
            [self runShareWithType:platformType];
        }
    }];
}
- (void)runShareWithType:(UMSocialPlatformType)type
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
//    NSString* thumbURL = @"logo";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"分享" descr:@"快速拿8000元" thumImage:[UIImage imageNamed:@"logo"]];
    //设置网页地址
    shareObject.webpageUrl = [GlobalManager appDownloadUrl];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;

    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:self.currentController completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
}

- (void)alertWithError:(NSError *)error
{
    NSString *result = nil;
    if (!error) {
        result = [NSString stringWithFormat:@"分享成功"];
    } else {
//        NSMutableString *str = [NSMutableString string];
//        if (error.userInfo) {
//            for (NSString *key in error.userInfo) {
//                [str appendFormat:@"%@ = %@\n", key, error.userInfo[key]];
//            }
//        }
//        if (error) {
//            result = [NSString stringWithFormat:@"Share fail with error code: %d\n%@",(int)error.code, str];
//        } else {
//            result = [NSString stringWithFormat:@"分享失败"];
//        }
        result = @"分享失败";
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:result
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

@end

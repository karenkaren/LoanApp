//
//  ShareSnsUtils.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/24.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "ShareSnsUtils.h"
#import "SocialConstants.h"

#define kDefaultLogoUrl [NSString stringWithFormat:@"%@%@", API_BASE_URL, @"/logo/logo.png"]

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

@end

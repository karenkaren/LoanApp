//
//  ShareSnsUtils.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/24.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMSocialCore/UMSocialCore.h>

@interface ShareSnsUtils : NSObject

#pragma mark - shareSns
//+ (void)shareSnsOnViewController:(UIViewController *)viewController delegate:(id<UMSocialUIDelegate>)delegeta;
//+ (void)shareSnsOnViewController:(UIViewController *)viewController shareTitle:(NSString *)shareTitle shareText:(NSString *)shareText shareImage:(NSString *)shareImage shareUrl:(NSString *)shareUrl delegate:(id<UMSocialUIDelegate>)delegate;
- (void)shareOnViewController:(UIViewController *)viewController;

@end

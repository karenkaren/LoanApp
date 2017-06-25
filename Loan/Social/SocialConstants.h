//
//  SocialConstants.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/24.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SocialConstants : NSObject

#pragma mark 分享
//umeng
extern NSString * const  UMENG_APP_KEY;

//wechat
extern NSString * const  WECHAT_APP_ID;
extern NSString * const  WECHAT_APP_KEY;
extern NSString * const  WECHAT_APP_SECRET;

//sina weibo
extern NSString * const  SINA_APP_KEY;
extern NSString * const  SINA_APP_SECRET;
extern NSString * const  SINA_APP_REDIRECT_URL;

//Tencent
extern NSString * const  QQ_APP_ID;
extern NSString * const  QQ_APP_KEY;

// 分享链接
extern NSString * const  defaultUrlForShare;

@end

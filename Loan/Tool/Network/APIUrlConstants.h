//
//  APIUrlConstants.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/24.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIUrlConstants : NSObject

+ (NSArray *)getCachePaths;

#pragma mark - url
#pragma mark -- 用户服务
extern NSString * const kGetBackPasswordSendMobileCodeUrl;    // 找回密码发送短信验证码
extern NSString * const kVerifyMobileCodeUrl; // 找回密码验证短信验证码和身份证
extern NSString * const kRetrievePasswordUrl;    // 找回密码提交

extern NSString * const kUserRegisterSendMobileCodeUrl;   // 发送注册短信验证码
extern NSString * const kUserRegisterUrl;  // 注册提交

extern NSString * const kUserLoginUrl; // 登录
extern NSString * const kGetPictureCaptchaUrl;   // 获取图形验证码
extern NSString * const kUserLogoutUrl;    // 退出登录
extern NSString * const kUserLocationUrl;   // 上传用户位置

#pragma mark -- 业务服务
extern NSString * const kBannerList;    // 首页banners
extern NSString * const kLoanList;    // 贷款列表
extern NSString * const kLoanQueryList;    // 贷款筛选列表
extern NSString * const kRecordList;    // 浏览/申请列表
extern NSString * const kAddApplyRecord;    // 新增申请记录
extern NSString * const kAddVisitRecord;    // 新增浏览记录
extern NSString * const kLoanApplyStep;     // 申请流程
extern NSString * const kGetUserProfile; // 获取个人信息
extern NSString * const kUpdateUserProfile;  // 修改个人信息

#pragma mark -- 审核专用
extern NSString * const kSHIosCheck;   // 查询iOS状态，审核或政策
extern NSString * const kSHUserAuth;   // 用户实名
extern NSString * const kSHGetUserInfoStatus;    // 获取用户信息
extern NSString * const kSHUserApply; // 用户申请
extern NSString * const kSHUpdateUserInfo;   // 修改用户信息
extern NSString * const kSHGetUserInfo; // 获取用户信息
extern NSString * const kSHGetApplyList;    // 获取申请记录

#pragma mark - h5
//// 帮助
//extern NSString * const helpH5Url;
//// 用户注册协议
//extern NSString * const registerProtocolH5Url;
//// 隐私条款
//extern NSString * const registerPrivacyH5Url;
//// 关于花无忧
//extern NSString * const aboutH5Url;

@end

//
//  APIUrlConstants.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/24.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "APIUrlConstants.h"

#pragma mark - url
// 注册发送短信验证码
NSString * const kUserRegisterSendMobileCodeUrl = @"/mobile/mobilecode/getMobileCode";
// 注册
NSString * const kUserRegisterUrl = @"/user/register/registerUser";

// 找回密码发送验证码
NSString * const kGetBackPasswordSendMobileCodeUrl = @"/mobile/mobilecode/getMobileCode";
// 找回密码验证
NSString * const kVerifyMobileCodeUrl = @"/mobile/mobilecode/verifyMobileCode";
// 找回密码提交
NSString * const kRetrievePasswordUrl = @"/user/login/retrievePwd";

// 登录
NSString * const kUserLoginUrl = @"/user/login/login";
// 图片验证码
NSString * const kGetPictureCaptchaUrl = @"/user/register/pictureCode";
// 退出登录
NSString * const kUserLogoutUrl = @"/user/login/logout";
//// 上传用户位置
NSString * const kUserLocationUrl = @"/user/location";

#pragma mark -- 业务服务
NSString * const kBannerList = @"/banner/list"; // 首页banners
NSString * const kLoanList = @"/cloan/list";    // 贷款列表
NSString * const kLoanQueryList = @"/cloan/tag/list";    // 贷款筛选列表
NSString * const kRecordList = @"/cloan/record/list";    // 浏览/申请列表
NSString * const kAddApplyRecord = @"/cloan/record/add";    // 新增申请记录
NSString * const kAddVisitRecord = @"/cloan/record/add";    // 新增浏览记录
NSString * const kLoanApplyStep = @"/cloan/step/list";     // 申请流程
NSString * const kGetUserProfile = @"/user/profile/get"; // 获取个人信息
NSString * const kUpdateUserProfile = @"/user/profile/update";  // 修改个人信息

#pragma mark -- 审核专用
NSString * const kSHIosCheck = @"/ios/check";   // 查询iOS状态，审核或政策
NSString * const kSHUserAuth = @"/user/userAuth";   // 用户实名
NSString * const kSHGetUserInfoStatus = @"/user/account/userInfo";    // 获取用户信息
NSString * const kSHUserApply = @"/user/apply"; // 用户申请
NSString * const kSHUpdateUserInfo = @"/user/tempprofile/update";   // 修改用户信息
NSString * const kSHGetUserInfo = @"/user/tempprofile/get"; // 获取用户信息
NSString * const kSHGetApplyList = @"/user/apply/list";    // 获取申请记录

#pragma mark - h5
//// 帮助
//NSString * const helpH5Url = @"/#/common-problem-app";
//// 用户注册协议
//NSString * const registerProtocolH5Url = @"/#/user-service-agreement";
//// 隐私条款
//NSString * const registerPrivacyH5Url = @"/#/privacy-agreement";
//// 关于花无忧
//NSString * const aboutH5Url = @"http://percy.legendh5.com/h5/abouthwy.html";

@implementation APIUrlConstants

+ (NSArray *)getCachePaths
{
    NSArray * cachePaths = @[@""];
    return cachePaths;
}

@end

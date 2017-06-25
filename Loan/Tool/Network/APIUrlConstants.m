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
// 上传用户位置
NSString * const kUserLocationUrl = @"/user/location";

#pragma mark -- 业务服务
NSString * const kHomepageRecommend = @"/homepage/recommend";   // 首页
NSString * const kShopListsDefault = @"/shop/lists"; // 默认洗车店列表
NSString * const kShopListsWithDistance = @"/shop/lists/distance"; // 根据距离获取店铺列表
NSString * const kShopProductList = @"/shop/product/list";    // 洗车店内服务
NSString * const kShopReserveAdd = @"/reserve/add"; // 提交订单
NSString * const kUserAddCar = @"/car/add";     // 添加用户车辆
NSString * const kUserCarList = @"/car/list";   // 用户车辆列表

NSString * const kBannerList = @"/banner/list";
//// 绑卡
//NSString * const pay_bankList = @"/v1/bank-cards";
//NSString * const usr_checkIdCard = @"/v1/accounts/id-cards";
////NSString * const usr_checkIdCard = @"http://10.20.1.226:8082/v1/accounts/id-cards";
//NSString * const usr_checkBindCard = @"/v1/accounts/bank-cards";
//NSString * const usr_notificateBindCardResult = @"/v1/accounts/bank-cards";
//
//// 上传图片
//NSString * const loanApply_upload = @"/v1/loanApply/upload";

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

//
//  BannerModel.h
//  lingtouniao
//
//  Created by LiuFeifei on 15/12/14.
//  Copyright © 2015年 lingtouniao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BannerModel : BaseModel

// banner id
@property (nonatomic, copy) NSString * bannerId;
// banner名字
@property (nonatomic, copy) NSString * bannerName;
// Banner状态
@property (nonatomic, assign) BOOL bannerState;
// banner跳转地址
@property (nonatomic, copy) NSString * linkUrl;
// banner图片地址
@property (nonatomic, copy) NSString * bannerUrl;


//// banner内容
//@property (nonatomic, copy) NSString * bannerContent;
//// banner标题
//@property (nonatomic, copy) NSString * bannerTitle;
//// banner类型
//@property (nonatomic ,copy) NSString * forModel;
//
//
//// 是否分享 1表示分享，0表示不分享
//@property (nonatomic, assign) BOOL isShare;
//// 分享名字
//@property (nonatomic, copy) NSString * shareTitle;
//// 分享内容
//@property (nonatomic, copy) NSString * shareContent;
//// 分享图片
//@property (nonatomic, copy) NSString * sharePic;
//// 分享链接
//@property (nonatomic, copy) NSString * shareUrl;

+ (void)getBannerListWithBlock:(APIResultDataBlock)block;

@end

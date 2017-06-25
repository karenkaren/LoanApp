//
//  PlatformModel.h
//  Loan
//
//  Created by 王安帮 on 2017/6/24.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "BaseModel.h"

@interface PlatformModel : BaseModel

@property (nonatomic, copy) NSString * platformName;    // 平台名称
@property (nonatomic, copy) NSString * plarformIconUrl; // 平台图标url
@property (nonatomic, assign) NSInteger plarformType;   // 标签，如热门，最新

@end

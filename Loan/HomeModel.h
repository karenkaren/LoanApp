//
//  HomeModel.h
//  XiChe
//
//  Created by LiuFeifei on 2017/4/21.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

#import "BaseModel.h"

@interface HomeModel : BaseModel

//@property (nonatomic, strong) NSArray * platformList;

+ (void)getHomeInfo:(NSDictionary *)params block:(APIResultDataBlock)block;

@end

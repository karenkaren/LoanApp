//
//  KeyValueStoreManager.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/25.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YTKKeyValueStore.h"

@interface KeyValueStoreManager : NSObject

singleton_interface(KeyValueStoreManager)

@property (nonatomic,strong) YTKKeyValueStore * store;

@end

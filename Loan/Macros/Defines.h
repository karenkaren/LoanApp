//
//  Defines.h
//  LingTouNiao
//
//  Created by LiuFeifei on 16/10/24.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import <Foundation/Foundation.h>

//====================测试宏
#define kAlwaysShowIntroductionGuide 0 // 是否总是显示引导页

//////////////////////////////////////////////////////
#pragma mark - 版本相关
#pragma mark -- 版本比较
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#pragma mark -- 版本判断
#define VERSION_9_0_LATER [[UIDevice currentDevice].systemVersion doubleValue] > 8.9
#define VERSION_8_0_LATER [[UIDevice currentDevice].systemVersion doubleValue] >= 8.0
#define VERSION_7_0_EARLIER ([[UIDevice currentDevice].systemVersion doubleValue] < 7.0f)

//////////////////////////////////////////////////////
#pragma mark - weakSelf、kStrongSelf
#define kWeakSelf __weak typeof (self) weakSelf = self;
#define kStrongSelf __strong __typeof(&*weakSelf)strongSelf = weakSelf;


//////////////////////////////////////////////////////
#pragma mark - 常用变量
// 日志输出宏定义
#if (ADHOC > 0 || DEBUG > 0)
#	define DLog(fmt, ...) NSLog((@"%s #%d " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#	define DLog(...)
#endif

// 默认弹框宏定义
#define kTipAlert(_S_, ...)     [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:(_S_), ##__VA_ARGS__] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show]

//////////////////////////////////////////////////////
#pragma mark - appStore地址
#define kAppStoreUrl  @"http://itunes.apple.com/app/id923676989"

#pragma mark - Block
typedef void (^VoidBlock)(void);
typedef void (^ErrorBlock)(NSError *error);
typedef void (^HandlerBlock)(id sender);
typedef void (^APIResultBlock)(id response, NSError *error);
typedef void (^APIResultDataBlock)(id response, id data, NSError *error);

#pragma mark - Dispatch
extern void DispatchSyncOnMainThread(dispatch_block_t block);
extern void DispatchAsyncOnMainThread(dispatch_block_t block);
extern void DispatchOnGlobalQueue(dispatch_queue_priority_t priority, dispatch_block_t block);
extern void DispatchOnDefaultQueue(dispatch_block_t block);
extern void DispatchOnHighQueue(dispatch_block_t block);
extern void DispatchOnLowQueue(dispatch_block_t block);
extern void DispatchOnBackgroundQueue(dispatch_block_t block);
/** After `delayTime`, dispatch `block` on the main thread. */
extern void DispatchAfter(NSTimeInterval delayTime, dispatch_block_t block);

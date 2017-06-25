//
//  Defines.m
//  LingTouNiao
//
//  Created by LiuFeifei on 16/11/23.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "Defines.h"

#pragma mark - Dispatch
void DispatchSyncOnMainThread(dispatch_block_t block)
{
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

void DispatchAsyncOnMainThread(dispatch_block_t block)
{
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

void DispatchOnGlobalQueue(dispatch_queue_priority_t priority, dispatch_block_t block)
{
    dispatch_async(dispatch_get_global_queue(priority, 0), block);
}

void DispatchOnDefaultQueue(dispatch_block_t block)
{
    DispatchOnGlobalQueue(DISPATCH_QUEUE_PRIORITY_DEFAULT, block);
}
void DispatchOnHighQueue(dispatch_block_t block)
{
    DispatchOnGlobalQueue(DISPATCH_QUEUE_PRIORITY_HIGH, block);
}
void DispatchOnLowQueue(dispatch_block_t block)
{
    DispatchOnGlobalQueue(DISPATCH_QUEUE_PRIORITY_LOW, block);
}
void DispatchOnBackgroundQueue(dispatch_block_t block)
{
    DispatchOnGlobalQueue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, block);
}

void DispatchAfter(NSTimeInterval delayTime, dispatch_block_t block)
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)),
                   dispatch_get_main_queue(),
                   block);
}


//
//  UIAlertView+Block.h
//  mmbang
//
//  Created by lihuaming on 14-10-10.
//  Copyright (c) 2014年 iyaya. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CompleteBlock) (NSInteger buttonIndex);
@interface UIAlertView (Block)

// 用Block的方式回调，这时候会默认用self作为Delegate
- (void)showAlertViewWithCompleteBlock:(CompleteBlock) block;

- (void)showAlertViewWithDismissCompleteBlock:(CompleteBlock)block;

@end

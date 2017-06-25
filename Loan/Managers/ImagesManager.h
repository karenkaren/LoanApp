//
//  ImagesManager.h
//  LingTouNiaoLoan
//
//  Created by LiuFeifei on 17/3/27.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImagesManager : NSObject

singleton_interface(ImagesManager)

+ (void)uploadImageInController:(UIViewController *)controller block:(HandlerBlock)block;

@end

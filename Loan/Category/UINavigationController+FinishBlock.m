//
//  UINavigationController+FinishBlock.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/15.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "UINavigationController+FinishBlock.h"
#import <objc/runtime.h>

@implementation UINavigationController (FinishBlock)

- (VoidBlock)finishBlock {
    return objc_getAssociatedObject(self, @selector(finishBlock));
}

- (void)setFinishBlock:(VoidBlock)aFinishBlock{
    objc_setAssociatedObject(self, @selector(finishBlock), aFinishBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

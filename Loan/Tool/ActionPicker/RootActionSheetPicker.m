//
//  RootActionSheetPicker.m
//  lingtouniao
//
//  Created by zhangtongke on 16/4/5.
//  Copyright © 2016年 lingtouniao. All rights reserved.
//

#import "RootActionSheetPicker.h"

@implementation RootActionSheetPicker

- (instancetype)initWithTarget:(id)target successAction:(SEL)successAction cancelAction:(SEL)cancelActionOrNil origin:(id)origin
{
    self = [super initWithTarget:nil successAction:NULL cancelAction:NULL origin:origin];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissPickerProgrammatically) name:kLogoutSuccessNotification object:nil];
    }
    return self;
}

-(void)dismissPickerProgrammatically{
    [self hidePickerWithCancelAction];
}

@end

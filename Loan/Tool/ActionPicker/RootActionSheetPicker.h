//
//  RootActionSheetPicker.h
//  lingtouniao
//
//  Created by zhangtongke on 16/4/5.
//  Copyright © 2016年 lingtouniao. All rights reserved.
//
#import "AbstractActionSheetPicker.h"
//#import <ActionSheetPicker-3.0/ActionSheetPicker-3.0.h>
@class RootActionSheetPicker;
typedef void (^ActionPickerDoneBlock)(RootActionSheetPicker *picker, NSDictionary *selectedDic);

@interface RootActionSheetPicker : AbstractActionSheetPicker
@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic,strong)NSArray *dataArray;
@property (nonatomic, copy) ActionPickerDoneBlock doneBlock;
@end

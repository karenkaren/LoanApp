//
//  SingleActionSheetPicker.h
//  lingtouniao
//
//  Created by zhangtongke on 16/4/5.
//  Copyright © 2016年 lingtouniao. All rights reserved.
//

#import "RootActionSheetPicker.h"

@interface SingleActionSheetPicker : RootActionSheetPicker<UIPickerViewDelegate, UIPickerViewDataSource>

+ (instancetype)showWithTitle:(NSString *)title
                  selectArray:(NSArray*)array
           initialSelectedDic:(NSDictionary *)selectedDic
                         done:(ActionPickerDoneBlock)doneBlock
                       origin:(id)origin;

- (instancetype)initWithTitle:(NSString *)title
                  selectArray:(NSArray*)array
           initialSelectedDic:(NSDictionary *)selectedCity
                         done:(ActionPickerDoneBlock)doneBlock
                       origin:(id)origin;


@end

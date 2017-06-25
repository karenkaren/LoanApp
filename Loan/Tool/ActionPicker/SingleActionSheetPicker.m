//
//  SingleActionSheetPicker.m
//  lingtouniao
//
//  Created by zhangtongke on 16/4/5.
//  Copyright © 2016年 lingtouniao. All rights reserved.
//

#import "SingleActionSheetPicker.h"

@implementation SingleActionSheetPicker
+ (instancetype)showWithTitle:(NSString *)title
                  selectArray:(NSArray *)array
           initialSelectedDic:(NSDictionary *)selectedDic
                         done:(ActionPickerDoneBlock)doneBlock
                       origin:(id)origin
{
    SingleActionSheetPicker *picker = [[self alloc] initWithTitle:title
                                                      selectArray:array
                                               initialSelectedDic:selectedDic
                                                             done:doneBlock
                                                           origin:origin];
    [picker showActionSheetPicker];
    return picker;
}


- (instancetype)initWithTitle:(NSString *)title
                  selectArray:(NSArray*)array
           initialSelectedDic:(NSDictionary *)selectedDic
                         done:(ActionPickerDoneBlock)doneBlock
                       origin:(id)origin
{
    self = [super initWithTarget:nil successAction:NULL cancelAction:NULL origin:origin];
    if (self) {
        self.title = title;
        self.dataArray = array;
        [self configuredPickerView];
        [self performSelector:@selector(showCurrentSelect:) withObject:selectedDic afterDelay:0.5];
        self.doneBlock = doneBlock;
    }
    return self;
}



- (UIView *)configuredPickerView
{
    CGRect pickerFrame = CGRectMake(0, 40, self.viewSize.width, 216);
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.showsSelectionIndicator = YES;
    self.picker = pickerView;
    return pickerView;
}

- (void)notifyTarget:(id)target didSucceedWithAction:(SEL)successAction origin:(id)origin
{
    if (self.doneBlock) {
        self.doneBlock(self, [self getSelectDic]);
    }
}

-(NSDictionary *)getSelectDic
{
    NSInteger selectIndex = [self.picker selectedRowInComponent:0];
    NSDictionary *selectDic = self.dataArray[selectIndex];
    return selectDic;
}

- (void)notifyTarget:(id)target didCancelWithAction:(SEL)cancelAction origin:(id)origin
{
    
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)showCurrentSelect:(NSDictionary *)selectDic
{
    if(!isDictionary(selectDic))
        return;
    for(int i=0;i<[self.dataArray count];i++)
    {
        if([esString(self.dataArray[i][@"key"]) isEqualToString:esString(selectDic[@"key"])])
        {
            [self.picker selectRow:i inComponent:0 animated: NO];
            break;
        }
    }
    
}


// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..`
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.dataArray count];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component;
{
    return self.pickerView.width;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 60.0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel * label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.font = kFont(16);
    label.textAlignment = NSTextAlignmentCenter;
    NSString * value = esString(self.dataArray[row][@"value"]);
    NSString * description = esString(self.dataArray[row][@"description"]);
    value = [value stringByAppendingFormat:@"\n%@", description];
    label.attributedText = [value configAttributesWithFontSize:12 forString:description];
    return label;
}

@end

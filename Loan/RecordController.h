//
//  RecordController.h
//  Loan
//
//  Created by 王安帮 on 2017/6/25.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "BaseTableViewController.h"

typedef enum : NSUInteger {
    RecordTypeOfVisit,
    RecordTypeOfApply
} RecordType;

@interface RecordController : BaseTableViewController

- (instancetype)initWithRecordType:(RecordType)recordType;

@end

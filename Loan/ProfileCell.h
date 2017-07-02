//
//  ProfileCell.h
//  Loan
//
//  Created by 王安帮 on 2017/7/1.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileViewModel.h"

@interface ProfileCell : UITableViewCell

@property (nonatomic, strong) NSDictionary * cellData;
- (instancetype)initWithProfileType:(ProfileType)type reuseIdentifier:(NSString *)reuseIdentifier;

@property (nonatomic, copy) void(^selectBlock)();
@property (nonatomic, copy) void(^switchStatusChangedBlock)(BOOL on);

@end

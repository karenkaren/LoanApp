//
//  ProfileController.m
//  Loan
//
//  Created by 王安帮 on 2017/7/1.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "ProfileController.h"
#import "NormalFooterView.h"
#import "ProfileCell.h"

@interface ProfileController ()

@property (nonatomic, strong) NSArray * cellData;
@property (nonatomic, strong) NormalFooterView * footerView;

@end

@implementation ProfileController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人资料";
    
//    [self registerCell];
    _footerView = [[NormalFooterView alloc] initWithTitle:@"确定"];
    _footerView.height = 60;
    _footerView.width = self.tableView.width;
    self.tableView.tableFooterView = _footerView;
    self.cellData = [ProfileViewModel getCellDataWithData:nil];
    
}

//- (void)registerCell
//{
//    [self.tableView registerClass:[ProfileCell class] forCellReuseIdentifier:@"ProfileCellInput"];
//    [self.tableView registerClass:[ProfileCell class] forCellReuseIdentifier:@"ProfileCellSelect"];
//    [self.tableView registerClass:[ProfileCell class] forCellReuseIdentifier:@"ProfileCellSwitch"];
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileCell * cell = nil;
    NSString * reuseIdentifier = nil;
    NSDictionary * cellData = self.cellData[indexPath.row];
    ProfileType cellType = [cellData[kProfileType] integerValue];
    switch (cellType) {
        case ProfileTypeInput:
            cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileCellInput"];
            reuseIdentifier = @"ProfileCellInput";
            break;
        case ProfileTypeSelect:
            cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileCellSelect"];
            reuseIdentifier = @"ProfileCellSelect";
            break;
        case ProfileTypeSwitch:
            cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileCellSwitch"];
            reuseIdentifier = @"ProfileCellSwitch";
            break;
        default:
            break;
    }
    
    if (cell == nil) {
        cell = [[ProfileCell alloc] initWithProfileType:cellType reuseIdentifier:reuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.cellData = cellData;
    if (cellType == ProfileTypeSelect) {
        cell.selectBlock = ^{
            NSLog(@"选择");
        };
    } else if (cellType == ProfileTypeSwitch) {
        cell.switchStatusChangedBlock = ^(BOOL on) {
            NSLog(@"开关：%d", on);
        };
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * cellDic = self.cellData[indexPath.row];
    SEL action = NSSelectorFromString(cellDic[@"sel"]);
    if ([self respondsToSelector:action]) {
        [self performSelector:action withObject:nil afterDelay:0.0f];
    }
}

@end

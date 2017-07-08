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
#import "ActionSheetStringPicker.h"
#import "ProfileModel.h"

@interface ProfileController ()

@property (nonatomic, strong) NSArray * cellData;
@property (nonatomic, strong) NormalFooterView * footerView;
@property (nonatomic, strong) NSMutableDictionary * profileData;

@end

@implementation ProfileController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人资料";

    _footerView = [[NormalFooterView alloc] initWithTitle:@"确定"];
    _footerView.height = 60;
    _footerView.width = self.tableView.width;
    _footerView.footerButton.enabled = NO;
    kWeakSelf
    _footerView.buttonClickBlock = ^(UIButton *button) {
        kStrongSelf
        [strongSelf updateProfileInfo];
    };
    self.tableView.tableFooterView = _footerView;
    self.cellData = [ProfileViewModel getCellDataWithData:nil];
    self.profileData = [NSMutableDictionary dictionary];
    [self.profileData setValue:@NO forKey:kProfileKeyOfCredit];
    
    [ProfileModel getProfileInfoWithBlock:^(id response, id data, NSError *error) {
        self.cellData = [ProfileViewModel getCellDataWithData:data];
        [self.profileData removeAllObjects];
        for (NSDictionary * dic in self.cellData) {
            if (![NSString isEmpty:esString(dic[kProfileValue])]) {
                [self.profileData setValue:esString(dic[kProfileValue]) forKey:dic[kProfileKey]];
            }
        }
        [self changeButtonStatus];
        [self.tableView reloadData];
    }];
}

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
        cell.selectBlock = ^(UITextField * textField){
            NSLog(@"选择");
            [self.view endEditing:YES];
            [self selectAtIndexPath:indexPath forTextField:textField];
        };
    } else if (cellType == ProfileTypeSwitch) {
        cell.switchStatusChangedBlock = ^(BOOL on) {
            NSLog(@"开关：%d", on);
            [self.profileData setValue:@(on) forKey:kProfileKeyOfCredit];
            [self changeButtonStatus];
        };
    }
    
    cell.textChangedBlock = ^(NSString *key, NSString *text) {
        if (text.length) {
            [self.profileData setValue:text forKey:key];
            [self changeButtonStatus];
        } else {
            [self.profileData removeObjectForKey:key];
            [self changeButtonStatus];
        }
    };
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

- (void)selectAtIndexPath:(NSIndexPath *)indexPath forTextField:(UITextField *)textField
{
    NSArray * rows = nil;
    NSString * title = nil;
    NSString * key = self.cellData[indexPath.row][kProfileKey];
    if ([key isEqualToString:kProfileKeyOfIncome]) {
        rows = @[@"5000以下", @"5000～10000", @"10000～20000", @"20000～30000", @"30000～50000", @"50000以上"];
        title = @"请选择收入";
    } else if ([key isEqualToString:kProfileKeyOfProfession]) {
        rows = @[@"自由职业", @"工薪阶层", @"私营业主", @"网店卖家", @"学生"];
        title = @"请选择文化程度";
    } else if ([key isEqualToString:kProfileKeyOfEdition]) {
        rows = @[@"初中", @"高中／中专", @"大专", @"本科", @"硕士及以上"];
        title = @"请选择职业";
    }

    [ActionSheetStringPicker showPickerWithTitle:title
                                            rows:rows
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           textField.text = selectedValue;
                                           [self.profileData setValue:selectedValue forKey:self.cellData[indexPath.row][kProfileKey]];
                                           [self changeButtonStatus];
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:textField];
}

- (void)changeButtonStatus
{
    self.footerView.footerButton.enabled = self.profileData.count == self.cellData.count;
}

- (void)updateProfileInfo
{
    [ProfileModel updateProfileInfoWithParams:self.profileData block:^(id response, NSError *error) {
        NSLog(@"个人资料修改成功");
        [[NSUserDefaults standardUserDefaults] setValue:self.profileData[kProfileKeyOfName] forKey:kUserName];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"userInfoChangedNotification" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

@end

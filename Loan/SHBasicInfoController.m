//
//  SHBasicInfoController.m
//  Loan
//
//  Created by 王安帮 on 2017/7/19.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "SHBasicInfoController.h"
#import "SHProgressController.h"
#import "ProfileViewModel.h"
#import "ProfileCell.h"
#import "TableViewDevider.h"
#import "ActionSheetStringPicker.h"
#import "NormalFooterView.h"
#import "LTNAgreeView.h"
#import "SHBaseModel.h"

@interface SHBasicInfoController ()<LTNAgreeViewDelegate>

@property (nonatomic, strong) NSMutableDictionary * basicInfoData;
@property (nonatomic, strong) NSArray * cellData;
@property (nonatomic, strong) NormalFooterView * footerView;

@end

@implementation SHBasicInfoController

- (void)back
{
    NSString * userName = [[NSUserDefaults standardUserDefaults] valueForKey:kUserName];
    if (![NSString isEmpty:userName]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        [super back];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"基本信息";
    
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kAdaptiveBaseIphone6(50 + 36))];
    headerView.backgroundColor = kWhiteColor;
    
    UIImageView * headerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"step1"]];
    headerImageView.width = headerView.width - kAdaptiveBaseIphone6(41);
    headerImageView.height = kAdaptiveBaseIphone6(50);
    headerImageView.center = headerView.center;
    [headerView addSubview:headerImageView];
    
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kStatusBarHeight - kNavigationBarHeight);
    self.tableView.tableHeaderView = headerView;
    [self setFooterView];
    self.enableRefresh = NO;

    self.basicInfoData = [NSMutableDictionary dictionary];
    [self loadCellDataWithData:self.basicInfoData];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"hasUserAuth"]) {
        [SHBaseModel getUserInfoWithBlock:^(id response, id data, NSError *error) {
            if (error) {
                return;
            }
            [self loadCellDataWithData:data];
            [self.basicInfoData removeAllObjects];
            for (NSArray * arr in self.cellData) {
                for (NSDictionary * dic in arr) {
                    if (![NSString isEmpty:esString(dic[kProfileValue])]) {
                        [self.basicInfoData setValue:esString(dic[kProfileValue]) forKey:dic[kProfileKey]];
                    }
                }
            }
            [self changeButtonStatus];
            [self.tableView reloadData];
        }];
    }
}

- (void)loadCellDataWithData:(NSDictionary *)data
{
    self.cellData = @[@[@{kProfileTitle : @"收入来源",
                          kProfileValue : esString(data[@"incomeType"]),
                          kProfilePlaceholder : @"请选择您的收入来源",
                          kProfileLimitCount : @30,
                          kProfileType : @(ProfileTypeSelect),
                          kProfileKey : @"incomeType",
                          kProfileKeyboardType : @(UIKeyboardTypeDefault)},
                        @{kProfileTitle : @"居住地址",
                          kProfileValue : esString(data[@"address"]),
                          kProfilePlaceholder : @"请输入居住地址",
                          kProfileLimitCount : @100,
                          kProfileType : @(ProfileTypeInput),
                          kProfileKey : @"address",
                          kProfileKeyboardType : @(UIKeyboardTypeDefault)},
                        @{kProfileTitle : @"邮箱地址",
                          kProfileValue : esString(data[@"email"]),
                          kProfilePlaceholder : @"请输入邮箱地址",
                          kProfileLimitCount : @30,
                          kProfileType : @(ProfileTypeInput),
                          kProfileKey : @"email",
                          kProfileKeyboardType : @(UIKeyboardTypeEmailAddress)}],
                      @[@{kProfileTitle : @"紧急联系人",
                          kProfileValue : esString(data[@"contactUser"]),
                          kProfilePlaceholder : @"请填写紧急联系人",
                          kProfileLimitCount : @30,
                          kProfileType : @(ProfileTypeInput),
                          kProfileKey : @"contactUser",
                          kProfileKeyboardType : @(UIKeyboardTypeDefault)},
                        @{kProfileTitle : @"手机号",
                          kProfileValue : esString(data[@"contactPhone"]),
                          kProfilePlaceholder : @"请填写手机号",
                          kProfileLimitCount : @11,
                          kProfileType : @(ProfileTypeInput),
                          kProfileKey : @"contactPhone",
                          kProfileKeyboardType : @(UIKeyboardTypeNumberPad)}]];
}

- (void)setFooterView
{
    UIView * tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 170)];
    
    UIView * topFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)];
    [tableFooterView addSubview:topFooterView];
    
    UIView * topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kLineThick)];
    topLineView.backgroundColor = kLineColor;
    [topFooterView addSubview:topLineView];
    
    LTNAgreeView * agreeView1 = [[LTNAgreeView alloc] initWithTitle:@"我已阅读并同意" protocol:@"《第三方网贷平台服务协议》" fontSize:14 target:self];
    agreeView1.tag = 100;
    agreeView1.left = kAdaptiveBaseIphone6(kCommonMargin);
    agreeView1.top = kAdaptiveBaseIphone6(17);
    [topFooterView addSubview:agreeView1];
    
    LTNAgreeView * agreeView2 = [[LTNAgreeView alloc] initWithTitle:@"我已阅读并同意" protocol:@"《咨询服务协议》" fontSize:14 target:self];
    agreeView2.tag = 101;
    agreeView2.left = kAdaptiveBaseIphone6(kCommonMargin);
    agreeView2.top = agreeView1.bottom + kAdaptiveBaseIphone6(5);
    [topFooterView addSubview:agreeView2];
    
    _footerView = [[NormalFooterView alloc] initWithTitle:@"提交"];
    _footerView.height = 80;
    _footerView.width = self.tableView.width;
    _footerView.top = topFooterView.bottom;
    _footerView.hideTopLine = YES;
    _footerView.footerButton.enabled = NO;
    kWeakSelf
    _footerView.buttonClickBlock = ^(UIButton *button) {
        kStrongSelf
        [strongSelf applySubmit];
    };
    [tableFooterView addSubview:_footerView];
    self.tableView.tableFooterView = tableFooterView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cellData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * rows = self.cellData[section];
    return rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileCell * cell = nil;
    NSString * reuseIdentifier = nil;
    NSDictionary * cellData = self.cellData[indexPath.section][indexPath.row];
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
            DLog(@"选择");
            [self.view endEditing:YES];
            [self selectAtIndexPath:indexPath forTextField:textField];
        };
    } else if (cellType == ProfileTypeSwitch) {
        cell.switchStatusChangedBlock = ^(BOOL on) {
            NSLog(@"开关：%d", on);
            [self.basicInfoData setValue:@(on) forKey:kProfileKeyOfCredit];
            [self changeButtonStatus];
            [self loadCellDataWithData:self.basicInfoData];
        };
    }
    
    cell.textChangedBlock = ^(NSString *key, NSString *text) {
        if (text.length) {
            [self.basicInfoData setValue:text forKey:key];
            [self changeButtonStatus];
        } else {
            [self.basicInfoData removeObjectForKey:key];
            [self changeButtonStatus];
        }
        [self loadCellDataWithData:self.basicInfoData];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section) {
        return 10;
    } else {
        return kGeneralSize;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section) {
        return [TableViewDevider getViewWithHeight:10 margin:0 showTopLine:YES showBottomLine:YES];
    } else {
        UIView * sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kGeneralSize)];
        sectionHeaderView.backgroundColor = kBackgroundColor;
        UILabel * titleLabel = [UILabel createLabelWithText:@"请填写真实有效信息" font:kFont(14) color:kBlackColor];
        titleLabel.width = kScreenWidth - 2 * kCommonMargin;
        titleLabel.left = kCommonMargin;
        titleLabel.center = sectionHeaderView.center;
        [sectionHeaderView addSubview:titleLabel];
        
        UIView * topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kLineThick)];
        topLineView.backgroundColor = kLineColor;
        [sectionHeaderView addSubview:topLineView];
        
        UIView * bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, kGeneralSize - kLineThick, kScreenWidth, kLineThick)];
        bottomLineView.backgroundColor = kLineColor;
        [sectionHeaderView addSubview:bottomLineView];
        
        return sectionHeaderView;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * cellDic = self.cellData[indexPath.section][indexPath.row];
    SEL action = NSSelectorFromString(cellDic[@"sel"]);
    if ([self respondsToSelector:action]) {
        [self performSelector:action withObject:nil afterDelay:0.0f];
    }
}

- (void)selectAtIndexPath:(NSIndexPath *)indexPath forTextField:(UITextField *)textField
{
    NSArray * rows = nil;
    NSString * title = nil;
    NSString * key = self.cellData[indexPath.section][indexPath.row][kProfileKey];
    if ([key isEqualToString:@"incomeType"]) {
        rows = @[@"工资收入", @"经营收入", @"其他收入", @"无收入"];
        title = @"请选择收入来源";
    }
    
    [ActionSheetStringPicker showPickerWithTitle:title
                                            rows:rows
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           textField.text = selectedValue;
                                           [self.basicInfoData setValue:selectedValue forKey:self.cellData[indexPath.section][indexPath.row][kProfileKey]];
                                           [self loadCellDataWithData:self.basicInfoData];
                                           [self changeButtonStatus];
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         DLog(@"Block Picker Canceled");
                                     }
                                          origin:textField];
}

- (void)changeButtonStatus
{
    NSInteger totalCount = 0;
    for (NSArray * rows in self.cellData) {
        totalCount += rows.count;
    }
    self.footerView.footerButton.enabled = self.basicInfoData.count == totalCount;
}

- (void)applySubmit
{
    [self.view endEditing:YES];
    if (![NSString isValidEmail:self.basicInfoData[@"email"]]) {
        [NSObject showMessage:@"邮箱输入错误，请重新输入"];
        return;
    }
    
    if (![NSString isPhoneNumber:self.basicInfoData[@"contactPhone"]]) {
        [NSObject showMessage:@"手机号输入错误，请重新输入"];
        return;
    }
    
    [self showWaitingIcon];
    [SHBaseModel updateUserInfoWithParams:self.basicInfoData block:^(id response, NSError *error) {
        [self dismissWaitingIcon];
        if (!error) {
            [self showWaitingIcon];
            [SHBaseModel applySubmitWithBlock:^(id response, NSError *error) {
                [self dismissWaitingIcon];
                if (!error) {
                    DLog(@"申请提交成功");
                    [self showWaitingIcon];
                    [SHBaseModel getApplyListWithBlock:^(id response, id data, NSError *error) {
                        [self dismissWaitingIcon];
                        if (!error) {
                            SHProgressController * progressController = [[SHProgressController alloc] init];
                            [self.navigationController pushViewController:progressController animated:YES];
                        }
                    }];
                }
            }];
        }
    }];
}

-(void)agreeView:(LTNAgreeView *)agreeView willAgreeProtocol:(BOOL)agree
{
    
}

@end

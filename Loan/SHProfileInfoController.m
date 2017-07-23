//
//  SHProfileInfoController.m
//  Loan
//
//  Created by 王安帮 on 2017/7/19.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "SHProfileInfoController.h"
#import "ProfileViewModel.h"
#import "ProfileCell.h"
#import "NormalFooterView.h"
#import "TableViewDevider.h"
#import "SHBaseModel.h"
#import "SHBasicInfoController.h"

@interface SHProfileInfoController ()

@property (nonatomic, strong) NSArray * cellData;
@property (nonatomic, strong) NSMutableDictionary * profileData;
@property (nonatomic, strong) NormalFooterView * footerView;

@end

@implementation SHProfileInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"信息确认";
    
    _footerView = [[NormalFooterView alloc] initWithTitle:@"提交"];
    _footerView.height = 60;
    _footerView.width = self.tableView.width;
    _footerView.footerButton.enabled = NO;
    kWeakSelf
    _footerView.buttonClickBlock = ^(UIButton *button) {
        kStrongSelf
        [strongSelf updateProfileInfo];
    };
    self.tableView.tableFooterView = _footerView;
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kStatusBarHeight - kNavigationBarHeight);
    self.enableRefresh = NO;
    
    self.profileData = [NSMutableDictionary dictionary];
    NSString * mobileNo = [[NSUserDefaults standardUserDefaults] valueForKey:kMobileNo];
    [self.profileData setValue:[NSString isEmpty:mobileNo] ? @"" : mobileNo forKey:@"phoneNo"];
    [self loadCellData];
}

- (void)loadCellData
{
    self.cellData = @[@{kProfileTitle : @"真实姓名",
                        kProfileValue : esString(self.profileData[@"userName"]),
                        kProfilePlaceholder : @"请输入您的姓名",
                        kProfileLimitCount : @100,
                        kProfileType : @(ProfileTypeInput),
                        kProfileKey : @"userName",
                        kProfileKeyboardType : @(UIKeyboardTypeNamePhonePad)},
                      @{kProfileTitle : @"身份证号",
                        kProfileValue : esString(self.profileData[@"identityCode"]),
                        kProfilePlaceholder : @"请输入身份证号码",
                        kProfileLimitCount : @18,
                        kProfileType : @(ProfileTypeInput),
                        kProfileKey : @"identityCode",
                        kProfileKeyboardType : @(UIKeyboardTypeNumbersAndPunctuation)},
                      @{kProfileTitle : @"手机号码",
                        kProfileValue : esString(self.profileData[@"phoneNo"]),
                        kProfilePlaceholder : @"请选择手机号码",
                        kProfileLimitCount : @11,
                        kProfileType : @(ProfileTypeInput),
                        kProfileKey : @"phoneNo",
                        kProfileKeyboardType : @(UIKeyboardTypeNumberPad)}];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileCellInput"];
    
    if (!cell) {
        cell = [[ProfileCell alloc] initWithProfileType:ProfileTypeInput reuseIdentifier:@"ProfileCellInput"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary * cellData = self.cellData[indexPath.row];
    cell.cellData = cellData;
    cell.textChangedBlock = ^(NSString *key, NSString *text) {
        if (text.length) {
            [self.profileData setValue:text forKey:key];
            [self changeButtonStatus];
        } else {
            [self.profileData removeObjectForKey:key];
            [self changeButtonStatus];
        }
        [self loadCellData];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 41;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 41)];
    view.backgroundColor = kHexColor(0xFFF6E9);
    
    UILabel * label = [UILabel createLabelWithText:@"请先进行身份认证，一经提交，不可更改" font:kFont(14) color:kHexColor(0xFF8800)];
    label.center = view.center;
    [view addSubview:label];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 41 - kLineThick, kScreenWidth, kLineThick)];
    lineView.backgroundColor = kLineColor;
    [view addSubview:lineView];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * cellDic = self.cellData[indexPath.row];
    SEL action = NSSelectorFromString(cellDic[@"sel"]);
    if ([self respondsToSelector:action]) {
        [self performSelector:action withObject:nil afterDelay:0.0f];
    }
}

- (void)changeButtonStatus
{
    self.footerView.footerButton.enabled = self.profileData.count == self.cellData.count;
}

- (void)updateProfileInfo
{
    [self.view endEditing:YES];
    if (![NSString isValidIDCardNumber:self.profileData[@"identityCode"]]) {
        [NSObject showMessage:@"身份证号输入错误，请重新输入"];
        return;
    }
    
    if (![NSString isPhoneNumber:self.profileData[@"phoneNo"]]) {
        [NSObject showMessage:@"手机号输入错误，请重新输入"];
        return;
    }
    
    [self showWaitingIcon];
    [SHBaseModel userAuthWithParams:self.profileData block:^(id response, NSError *error) {
        DLog(@"个人资料修改成功");
        [self dismissWaitingIcon];
        [[NSUserDefaults standardUserDefaults] setValue:self.profileData[@"userName"] forKey:kUserName];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"userInfoChangedNotification" object:nil];
        SHBasicInfoController * basicInfoController = [[SHBasicInfoController alloc] init];
        [self.navigationController pushViewController:basicInfoController animated:YES];
    }];
}

@end

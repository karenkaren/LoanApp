//
//  NetAddressSettingController.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/26.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "NetAddressSettingController.h"
#import "BaseWebViewController.h"

@interface NetAddressSettingController ()<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) UITextField *apiAddressField;
@property (nonatomic) UITextField *webAddressField;
@property (nonatomic) UITableView *apiTableView;
@property (nonatomic) UITableView *webTableView;
@property (nonatomic) NSArray * apiAddresses;
@property (nonatomic) NSArray * webAddresses;

@end

@implementation NetAddressSettingController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.baseNavigationController.barBackgroundColor = kWhiteColor;
}

- (void)viewDidLoad
{
    _apiAddresses = @[@"http://192.168.18.194:8080/v3", @"http://192.168.18.233/api",@"http://120.55.184.234/api", @"https://www.51huawuyou.com/api"];
    _webAddresses =  @[@"http://192.168.18.233:9000", @"http://192.168.18.233",@"http://120.55.184.234",@"https://www.51huawuyou.com/h5/v1"];
    [super viewDidLoad];
    self.title = @"设置HOST";
    
    CGFloat x = 10;
    UILabel * apiAddressLabel = [UILabel createLabelWithText:@"api地址" font:kFont(18) color:[UIColor blackColor]];
    apiAddressLabel.x = x;
    apiAddressLabel.y = 0;
    [self.view addSubview:apiAddressLabel];
    
    self.apiAddressField = [self createTextField];
    self.apiAddressField.placeholder = @"api地址";
    self.apiAddressField.tag = 1000;
    self.apiAddressField.frame = CGRectMake(x, CGRectGetMaxY(apiAddressLabel.frame) + 20, kScreenWidth-x*2, 35);
    [self.view addSubview:self.apiAddressField];
    
    UILabel * webAddressLabel = [UILabel createLabelWithText:@"web地址暂可忽略" font:kFont(18) color:[UIColor blackColor]];
    webAddressLabel.x = x;
    webAddressLabel.y = CGRectGetMaxY(self.apiAddressField.frame) + 20;
    [self.view addSubview:webAddressLabel];
    
    self.webAddressField = [self createTextField];
    self.apiAddressField.placeholder = @"web地址";
    self.webAddressField.tag = 2000;
    self.webAddressField.frame = CGRectMake(x, CGRectGetMaxY(webAddressLabel.frame) + 20, kScreenWidth-x*2, 35);
    [self.view addSubview:self.webAddressField];
    
    // footer button
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(self.webAddressField.frame) + 20, kScreenWidth - x*2, kGeneralSize)];
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
    button.titleLabel.font = kFont(18);
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(saveAddress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    // 设置默认值
    self.apiAddressField.text = API_BASE_URL;
    self.webAddressField.text = WEB_BASE_URL;
}

- (void)clearAddress {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kDefaults_NetAddress];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [NSObject showHudTipStr:@"清除成功"];
    [self exit];
}

- (UITextField *)createTextField
{
    UITextField *titleField = [[UITextField alloc] initWithFrame:CGRectZero];
    titleField.layer.borderColor = [[UIColor colorWithHex:0xd5d5d5 alpha:1.0] CGColor];
    titleField.layer.cornerRadius = 0;
    titleField.layer.borderWidth = 1.0;
    titleField.delegate = self;
    titleField.backgroundColor = [UIColor colorWithHex:0xf4f4f4 alpha:1.0];
    titleField.textColor = [UIColor colorWithHex:0x4b4b4b alpha:1.0];
    titleField.font = kFont(15);
    titleField.background = nil;
    return titleField;
}

#pragma mark - UITextField
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self.apiTableView removeFromSuperview];
    [self.webTableView removeFromSuperview];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.tag == 1000) {
        if (!_apiTableView) {
            _apiTableView = [[UITableView alloc] initWithFrame:CGRectMake(textField.left, textField.bottom, kScreenWidth, 88)];
            _apiTableView.dataSource = self;
            _apiTableView.delegate = self;
        }
        [self.view addSubview:_apiTableView];
    } else if (textField.tag == 2000) {
        if (!_webTableView) {
            _webTableView = [[UITableView alloc] initWithFrame:CGRectMake(textField.left, textField.bottom, kScreenWidth, 88)];
            _webTableView.dataSource = self;
            _webTableView.delegate = self;
        }
        [self.view addSubview:_webTableView];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField.tag == 1000) {
        if (![_apiAddresses containsObject:textField.text]) {
            [self.apiTableView removeFromSuperview];
        }
    } else if (textField.tag == 2000) {
        if (![_webAddresses containsObject:textField.text]) {
            [self.webTableView removeFromSuperview];
        }
    }
}

#pragma mark - 保存
- (void)saveAddress:(UIButton *)button
{
    // 用户信息清空
    [[CurrentUser mine] reset];
    
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:kDefaults_NetAddress];
    NSMutableDictionary *mdic;
    if (dic == nil) {
        mdic = [[NSMutableDictionary alloc] initWithCapacity:0];
    } else {
        mdic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    }
    
    if (![NSString isEmpty:self.apiAddressField.text] && ![NSString isEmpty:self.webAddressField.text]) {
        mdic[kDefaults_POST_ADDR] = self.apiAddressField.text;
        mdic[kDefaults_WEB_ADDR] = self.webAddressField.text;
    } else {
        [NSObject showHudTipStr:@"WebService 为空"];
        return;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:mdic forKey:kDefaults_NetAddress];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.view endEditing:YES];
    [self exit];
}



- (void)exit {
    
#if (defined(DEBUG) || defined(ADHOC))
    exit(0);
#endif
    
}

#pragma mark - tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.apiAddresses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (tableView == self.apiTableView) {
        cell.textLabel.text = _apiAddresses[indexPath.row];
    } else if (tableView == self.webTableView) {
        cell.textLabel.text = _webAddresses[indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.apiAddressField.text = _apiAddresses[indexPath.row];
    self.webAddressField.text = _webAddresses[indexPath.row];
    [self.view endEditing:YES];
    [tableView removeFromSuperview];
}

@end

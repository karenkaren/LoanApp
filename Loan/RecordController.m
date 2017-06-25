//
//  RecordController.m
//  Loan
//
//  Created by 王安帮 on 2017/6/25.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "RecordController.h"
#import "RecordCell.h"
#import "ProductDetailController.h"

@interface RecordController ()

@property (nonatomic, assign) RecordType recordType;
@property (nonatomic, strong) NSArray * recordList;

@end

@implementation RecordController
- (instancetype)initWithRecordType:(RecordType)recordType
{
    self = [super init];
    if (self) {
        self.recordType = recordType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    switch (self.recordType) {
        case RecordTypeOfApply:
            self.title = @"申请记录";
            break;
        case RecordTypeOfVisit:
            self.title = @"浏览记录";
            break;
        default:
            break;
    }
    
    [self createTableViewWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight - kStatusBarHeight) style:UITableViewStyleGrouped];
    self.tableView.sectionFooterHeight = CGFLOAT_MIN;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[RecordCell class] forCellReuseIdentifier:@"Cell"];
    
    NSMutableArray * recordList = [NSMutableArray arrayWithCapacity:3];
    for (int i = 0 ; i < 3; i++) {
        NSMutableDictionary * sectionDic = [NSMutableDictionary dictionaryWithCapacity:2];
        [sectionDic setValue:[NSString stringWithFormat:@"6月%u日", arc4random_uniform(30) + 1] forKey:@"title"];
        NSInteger rows = arc4random_uniform(20) + 1;
        NSMutableArray * rowArray = [NSMutableArray arrayWithCapacity:rows];
        for (int j = 0; j < rows; j++) {
            ProductModel * record = [[ProductModel alloc] init];
            [rowArray addObject:record];
        }
        [sectionDic setValue:rowArray forKey:@"value"];
        [recordList addObject:sectionDic];
    }
    self.recordList = recordList;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.recordList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * rows = self.recordList[section][@"value"];
    return rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecordCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray * rows = self.recordList[indexPath.section][@"value"];
    cell.product = rows[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecordCell * cell = [[RecordCell alloc] init];
    NSArray * rows = self.recordList[indexPath.section][@"value"];
    ProductModel * product = rows[indexPath.row];
    return [cell getCellHeightWithProduct:product];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel * sectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    sectionLabel.backgroundColor = kColorD8D8D8;
    sectionLabel.textAlignment = NSTextAlignmentCenter;
    sectionLabel.text = self.recordList[section][@"title"];
    return sectionLabel;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return CGFLOAT_MIN;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * rows = self.recordList[indexPath.section][@"value"];
    ProductModel * product = rows[indexPath.row];
    ProductDetailController * productDetailController = [[ProductDetailController alloc] initWithProduct:product];
    productDetailController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:productDetailController animated:YES];
}



@end

//
//  LoanRootController.m
//  Loan
//
//  Created by 王安帮 on 2017/6/24.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "LoanRootController.h"
#import "LoanRootCell.h"
#import "ProductDetailController.h"

@interface LoanRootController ()

@property (nonatomic, strong) NSArray * productList;

@end

@implementation LoanRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"贷款";
    [self.tableView registerClass:[LoanRootCell class] forCellReuseIdentifier:@"Cell"];
    
    NSMutableArray * productList = [NSMutableArray arrayWithCapacity:20];
    for (int i = 0 ; i < 20; i++) {
        ProductModel * product = [[ProductModel alloc] init];
        [productList addObject:product];
    }
    self.productList = productList;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.productList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoanRootCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.product = self.productList[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoanRootCell * cell = [[LoanRootCell alloc] init];
    return [cell getCellHeightWithProduct:self.productList[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductDetailController * productDetailController = [[ProductDetailController alloc] initWithProduct:self.productList[indexPath.row]];
    productDetailController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:productDetailController animated:YES];
}

@end

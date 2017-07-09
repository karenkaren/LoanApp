//
//  ProductDetailController.m
//  Loan
//
//  Created by 王安帮 on 2017/6/25.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "ProductDetailController.h"
#import "ProductDetailHeaderView.h"
#import "ProductDetailFooterView.h"
#import "ProductDetailCell.h"
#import "BaseWebViewController.h"

@interface ProductDetailController ()

@property (nonatomic, strong) NSMutableArray * cellData;

@end

@implementation ProductDetailController

- (instancetype)initWithProduct:(ProductModel *)product
{
    self = [super init];
    if (self) {
        self.product = product;
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([[CurrentUser mine] hasLogged]) {
        [ProductModel addVisitRecordWithProduct:self.product block:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.product.cloanName;
    
    [self createTableViewWithStyle:UITableViewStyleGrouped];
    self.enableFooterRefresh = NO;
    self.tableView.sectionHeaderHeight = 10;
    self.tableView.sectionFooterHeight = CGFLOAT_MIN;
    [self.tableView registerClass:[ProductDetailCell class] forCellReuseIdentifier:@"Cell"];
    
    ProductDetailHeaderView * headerView = [[ProductDetailHeaderView alloc] initWithProduct:self.product];
    headerView.height = [headerView getHeaderViewHeight];
    self.tableView.tableHeaderView = headerView;
    
    ProductDetailFooterView * footerView = [[ProductDetailFooterView alloc] init];
    [self.view addSubview:footerView];
    [footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.width.equalTo(self.view);
        make.height.equalTo(@60);
    }];
    
    footerView.applyClickBlock = ^(UIButton *button) {
        [ControllersManager actionWhenLogin:^{
            [ProductModel addApplyRecordWithProduct:self.product block:nil];
            BaseWebViewController * webController = [[BaseWebViewController alloc] initWithURL:self.product.h5link];
            [self.navigationController pushViewController:webController animated:YES];
        }];
        
    };
    
    self.cellData = @[@[@{@"title" : @"申请条件",
                        @"content" : esString(self.product.applyCondition),
                        @"style" : @(ProductDetailCellStyleText)}],
                      @[@{@"title" : @"审核说明",
                        @"content" : esString(self.product.applyDescription),
                        @"style" : @(ProductDetailCellStyleText)}],
                      @[@{@"title" : @"产品介绍",
                        @"content" : esString(self.product.desc),
                        @"style" : @(ProductDetailCellStyleText)}]].mutableCopy;
    [self refreshAction];

}

- (void)refreshAction
{
    [ProductModel getLoanApplyStepWithProduct:self.product block:^(id response, NSArray *loanStepList, NSError *error) {
        [self stopRefresh];
        if (!error && loanStepList.count) {
            NSArray * stepList = @[@{@"title" : @"申请流程",
                                     @"content" : loanStepList,
                                     @"style" : @(ProductDetailCellStyleImage)}];
            if (self.cellData.count < 4) {
                [self.cellData insertObject:stepList atIndex:0];
            }
            [self.tableView reloadData];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cellData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * array = self.cellData[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.detailData = self.cellData[indexPath.section][indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductDetailCell * cell = [[ProductDetailCell alloc] init];
    return [cell getCellHeightWithData:self.cellData[indexPath.section][indexPath.row]];
}

@end

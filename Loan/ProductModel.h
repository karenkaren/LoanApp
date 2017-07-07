//
//  ProductModel.h
//  Loan
//
//  Created by 王安帮 on 2017/6/24.
//  Copyright © 2017年 FangRongTech. All rights reserved.
//

#import "BaseModel.h"

//// todo:
//typedef NS_ENUM(NSUInteger, LoanSortType) {
//    LoanSortTypeOfDefault, // 默认
//    LoanSortTypeOfPrice,    // 根据价格排序
//    LoanSortTypeOfWaitingTime,  // 根据等待时间排序
//    LoanSortTypeOfDistance, // 根据距离排序
//    LoanSortTypeOfEstimate  // 根据评价排序
//};

typedef NS_ENUM(NSUInteger, RecordListType) {
    RecordListTypeOfVisit, // 默认
    RecordListTypeOfApply    // 根据价格排序
};


@interface ProductModel : BaseModel

@property (nonatomic, copy) NSString * applyCondition;  // 申请条件
@property (nonatomic, copy) NSString * applyDescription;    // 申请说明
@property (nonatomic, copy) NSString * cloanName;//'贷款名字'
@property (nonatomic, copy) NSString * cloanLogo;//'图标URL'
@property (nonatomic, assign) NSInteger company;//公司ID， 待确认
@property (nonatomic, copy) NSString * desc;//描述
@property (nonatomic, assign) NSInteger applyCustomer;//''申请人数''
@property (nonatomic, assign) double monthRate;//月利率
@property (nonatomic, assign) double dayRate;//日利率
@property (nonatomic, assign) double yearRate;//年利率

@property (nonatomic, copy) NSString * loanRange;//'贷款范围'
@property (nonatomic, copy) NSString * rateRange;//'利率范围'
@property (nonatomic, copy) NSString * dateRange;//'借款时间范围'

@property (nonatomic, assign) NSInteger loanMax;//'最多借款'
@property (nonatomic, assign) NSInteger loanMin;//'最少借款'
@property (nonatomic, copy) NSString * passRate;//''PH:通过率高；PM：通过率中； PL：通过率低','

@property (nonatomic, assign) NSInteger status;//''1:有效   2:新建   0:撤出','

@property (nonatomic, copy) NSString * cloanTags;// 产品标签

@property (nonatomic, copy) NSString * cloanNo;// 产品标签
@property (nonatomic, copy) NSString * cloanType;// '备用字段：产品类型'

@property (nonatomic, copy) NSString * createDate;//创建时间,原类型为Date
@property (nonatomic, copy) NSString * createBy;//创建人
@property (nonatomic, copy) NSString * remark;//备注

@property (nonatomic, assign) NSInteger dateRangeMin;//'最少借款天数'
@property (nonatomic, assign) NSInteger dateRangeMax;//'最长借款天数'

@property (nonatomic, assign) double rateRangeMin;//''利率最低''

@property (nonatomic, assign) double rateRangeMax;//''利率最高''

@property (nonatomic, copy) NSString * h5link; // 链接

/**
 获取贷款列表
 
 @param params 请求参数
 @param block 回调block
 */
+ (void)getLoanListWithParams:(NSDictionary *)params block:(void (^)(id response, NSArray * productList, NSInteger totalCount, NSError *error))block;
/**
 获取贷款筛选列表
 
 @param params 请求参数
 @param block 回调block
 */
+ (void)getLoanQueryListWithParams:(NSDictionary *)params block:(void (^)(id response, NSArray * loanList, NSInteger totalCount, NSError * error))block;
/**
 增加浏览记录
 
 @param product 浏览的产品
 @param block 回调block
 */
+ (void)addVisitRecordWithProduct:(ProductModel *)product block:(void (^)(id respons, NSError * error))block;
/**
 增加申请记录
 
 @param product 申请的产品
 @param block 回调block
 */
+ (void)addApplyRecordWithProduct:(ProductModel *)product block:(void (^)(id respons, NSError * error))block;
/**
 获取浏览/申请记录列表
 
 @param block 回调block
 */
+ (void)getRecordListWithType:(RecordListType)type params:(NSDictionary *)params block:(void (^)(id response, NSArray * recordList, NSInteger totalCount, NSError * error))block;
/**
 获取贷款步骤
 
 @param product 需获取步骤的产品
 @param block 回调block
 */
+ (void)getLoanApplyStepWithProduct:(ProductModel *)product block:(void (^)(id response, NSArray * loanStepList, NSError * error))block;

@end

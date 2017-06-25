//
//  KeyValueStoreManager.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/25.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "KeyValueStoreManager.h"

#define KeyValueName @"LingTouNiaoZF.db"

@implementation KeyValueStoreManager

singleton_implementation(KeyValueStoreManager)

-(instancetype)init
{
    if(self=[super init])
    {
        _store = [[YTKKeyValueStore alloc] initDBWithName:KeyValueName];
//        [_store createTableWithName:TipsTable];
//        [_store createTableWithName:StaticStringsTable];
    }
    return self;
    
}

//- (NSArray *)getProducts
//{
//    NSArray * array = [self.store getAllItemsFromTable:ProductsTable];
//    NSMutableArray * arrayM = [NSMutableArray arrayWithCapacity:array.count];
//    for (YTKKeyValueItem * item in array) {
//        LTNProduct * product = [LTNProduct mj_objectWithKeyValues:item.itemObject];
//        [arrayM addObject:product];
//    }
//    return arrayM;
//}
//- (void)putProduct:(NSDictionary *)product
//{
//    if ([product isKindOfClass:[LTNProduct class]]) {
//        product = product.mj_keyValues;
//    }
//    if ([product[@"productId"] integerValue]) {
//        [self.store putObject:product withId:product[@"productId"] intoTable:ProductsTable];
//    }
//}
//
//- (void)putProducts:(NSArray *)products
//{
//    if (isArray(products) && products.count) {
//        for (LTNProduct * product in products) {
//            [self putProduct:product.mj_keyValues];
//        }
//    }
//}
//
//- (void)deleteAllProducts
//{
//    [self.store clearTable:ProductsTable];
//}
//
//- (void)deleteProducts:(NSArray *)products
//{
//    if (isArray(products) && products.count) {
//        NSMutableArray * idArray = [NSMutableArray arrayWithCapacity:products.count];
//        for (LTNProduct * product in products) {
//            [idArray addObject:@(product.productId)];
//        }
//        [self.store deleteObjectsByIdArray:idArray fromTable:ProductsTable];
//    }
//    
//}
//
//- (void)deleteProduct:(NSDictionary *)product
//{
//    if ([product isKindOfClass:[LTNProduct class]]) {
//        product = product.mj_keyValues;
//    }
//    [self.store deleteObjectById:product[@"productId"] fromTable:ProductsTable];
//}

@end

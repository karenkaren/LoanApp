//
//  NetAPIManager.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/26.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

typedef NS_ENUM(NSUInteger, NetworkMethod) {
    Get = 0,
    Post,
    Patch,
    Delete
};

@interface NetAPIManager : AFHTTPSessionManager

singleton_interface(NetAPIManager)

- (void)requestWithPath:(NSString *)path
                 params:(NSDictionary *)params
             methodType:(NetworkMethod)methodType
                  block:(APIResultBlock)block;
- (void)requestWithPath:(NSString *)path
                 params:(NSDictionary *)params
             methodType:(NetworkMethod)methodType
          autoShowError:(BOOL)autoShowError
                  block:(APIResultBlock)block;
- (void)uploadFileWithData:(NSData *)data
                  fileName:(NSString *)fileName
                  mimeType:(NSString *)mimeType
                      path:(NSString *)path
                    params:(NSDictionary *)params
                methodType:(NetworkMethod)methodType
             autoShowError:(BOOL)autoShowError
                     block:(APIResultBlock)block;
- (void)customRequestWithPath:(NSString *)path
                       params:(NSDictionary *)params
                         body:(id)body
                   methodType:(NetworkMethod)methodType
                autoShowError:(BOOL)autoShowError
                        block:(APIResultBlock)block;

@end

//
//  NetAPIManager.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/26.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "NetAPIManager.h"
#import "UIDevice+Info.h"

#define kNetworkMethodName @[@"Get", @"Post", @"Patch", @"Delete"]
#define private_key @"ltn$%^qpdhTH18"

static NetAPIManager * _shareManager;

@interface NetAPIManager ()

@end

@implementation NetAPIManager

static NSString * pathKey(NSString *path, NSDictionary *parameters){
    if(parameters){
        return [path stringByAppendingFormat:@"?%@", AFQueryStringFromParameters(parameters)];
    }
    return path;
}

+ (instancetype)sharedNetAPIManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareManager = [[NetAPIManager alloc] init];
        _shareManager.requestSerializer.timeoutInterval = 10;
        _shareManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", @"multipart/form-data", @"image/jpeg", @"image/png", nil];
    });
    return _shareManager;
}

- (void)requestWithPath:(NSString *)path
                 params:(NSDictionary *)params
             methodType:(NetworkMethod)methodType
                  block:(APIResultBlock)block
{
    [self requestWithPath:path params:params methodType:methodType autoShowError:YES block:block];
}

- (void)requestWithPath:(NSString *)path
                 params:(NSDictionary *)params
             methodType:(NetworkMethod)methodType
          autoShowError:(BOOL)autoShowError
                  block:(APIResultBlock)block
{
    path = esString(path);
    if (!path || path.length <= 0) {
        return;
    }
    // log请求数据
    DLog(@"\n===========request===========\n%@\n%@:\n%@", kNetworkMethodName[methodType], path, params);
    
    // 封装基础参数
    params = [self configParameters:params.mutableCopy];
    
    // 发起请求
    switch (methodType) {
        case Get:
        {
            // 根据需求，部分Get请求需要增加缓存机制
            NSMutableString * localPath;
            NSArray * cachePaths = [APIUrlConstants getCachePaths];
            if ([cachePaths containsObject:path]) {
                localPath = [NSString netAbsolutePath:path].mutableCopy;
                if (params) {
                    [localPath appendString:params.description];
                }
            }
            [self GET:[NSString netAbsolutePath:path] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                DLog(@"\n===========response===========\n%@:\n%@", [NSString netAbsolutePath:path], responseObject);
                NSError * error = [self handleResponse:responseObject autoShowError:autoShowError];
                if (error) {
                    responseObject = [NSObject loadResponseWithPath:pathKey(localPath, params)];
                    if (block) {
                        block(responseObject, error);
                    }
                } else {
                    // 如果需要缓存，则缓存
                    if ([responseObject isKindOfClass:[NSDictionary class]]) {
                        [NSObject saveResponseData:responseObject toPath:pathKey(localPath, params)];
                    }
                    if (block) {
                        block(responseObject, nil);
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DLog(@"\n===========response===========\n%@:\n%@", [NSString netAbsolutePath:path], error.localizedDescription);
                if (autoShowError) {
                    [NSObject showError:error];
                }
                id responseObject = [NSObject loadResponseWithPath:pathKey(localPath, params)];
                if (block) {
                    block(responseObject, error);
                }
            }];
        }
            break;
        case Post:
        {
                [self POST:[NSString netAbsolutePath:path] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    DLog(@"\n===========response===========\n%@:\n%@", [NSString netAbsolutePath:path], responseObject);
                    id error = [self handleResponse:responseObject autoShowError:autoShowError];
                    if (block) {
                        if (error) {
                            block(nil, error);
                        } else {
                            block(responseObject, nil);
                        }
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    DLog(@"\n===========response===========\n%@:\n%@", [NSString netAbsolutePath:path], error.localizedDescription);
                    if (autoShowError) {
                        [NSObject showError:error];
                    }
                    if (block) {
                        block(nil, error);
                    }
            }];
        }
            break;
        default:
            break;
    }
}

- (void)uploadFileWithData:(NSData *)data
                  fileName:(NSString *)fileName
                  mimeType:(NSString *)mimeType
                      path:(NSString *)path
                    params:(NSDictionary *)params
                methodType:(NetworkMethod)methodType
             autoShowError:(BOOL)autoShowError
                     block:(APIResultBlock)block
{
    path = esString(path);
    if (!path || path.length <= 0) {
        return;
    }
    // log请求数据
    DLog(@"\n===========request===========\n%@\n%@:\n%@", kNetworkMethodName[methodType], path, params);
    
    // 封装基础参数
    params = [self configParameters:params.mutableCopy];
    
    [self POST:[NSString netAbsolutePath:path] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //按照表单格式把二进制文件写入formData表单
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        DLog(@"%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (block) {
            block(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (autoShowError) {
            [NSObject showError:error];
        }
        if (block) {
            block(nil, error);
        }
    }];
}

- (NSMutableDictionary *)configParameters:(NSMutableDictionary *)parameters
{
    if (!parameters) {
        parameters = [NSMutableDictionary dictionary];
    }
    
    // 基础参数
    [parameters setValue:[GlobalManager appVersion] forKey:@"appVersion"];
    [parameters setValue:@"I" forKey:@"clientType"];
    [parameters setValue:@"ltn" forKey:@"businessLine"];
    NSString * sessionKey = [[NSUserDefaults standardUserDefaults] stringForKey:kSessionKey];
    if (![esString(sessionKey) isEqualToString:@""]) {
        [parameters setValue:esString(sessionKey) forKey:kSessionKey];
    }
    
    // 加密头部
    NSMutableDictionary * signParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [signParameters setValue:private_key forKey:@"private_key"];
    NSString * signString = [NSString serialize:signParameters];
    signString = [NSString md5:signString];
    [self.requestSerializer setValue:signString forHTTPHeaderField:@"header_sign"];
    
    return parameters;
}

- (void)customRequestWithPath:(NSString *)path
                       params:(NSDictionary *)params
                         body:(id)body
                   methodType:(NetworkMethod)methodType
                autoShowError:(BOOL)autoShowError
                        block:(APIResultBlock)block
{
    NSParameterAssert(methodType);
    NSParameterAssert(methodType != Get);
    
    path = esString(path);
    if (!path || path.length <= 0) {
        return;
    }
    // log请求数据
    DLog(@"\n===========request===========\n%@\n%@:\n%@", kNetworkMethodName[methodType], path, params);
    
    // 封装基础参数
    params = [self configParameters:params.mutableCopy];
    path = [path stringByAppendingFormat:@"?%@", AFQueryStringFromParameters(params)];
    
    NSMutableURLRequest * request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:[NSString netAbsolutePath:path] parameters:nil error:nil];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSString * bodyString = [NSObject jsonStringWithObject:body];
    // 设置postBody
    NSData * postBody = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:postBody];
    
    [[[NetAPIManager sharedNetAPIManager] dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            if (autoShowError) {
                [NSObject showError:error];
            }
            if (block) {
                block(nil, error);
            }
        } else {
            error = [self handleResponse:responseObject autoShowError:autoShowError];
            if (block) {
                if (error) {
                    block(nil, error);
                } else {
                    block(responseObject, nil);
                }
            }
        }
    }] resume];
}

@end

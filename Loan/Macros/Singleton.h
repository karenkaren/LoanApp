//
//  Singleton.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/24.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#ifndef Singleton_h
#define Singleton_h

/**
 *  在.h文件中定义的宏，arc
 *
 *  singleton_interface(className) 这个是宏
 *  + (instancetype)shared##className;这个是被代替的方法， ##代表着shared+name 高度定制化
 *  在外边我们使用 “singleton_interface(gege)” 那么在.h文件中，定义了一个方法"+ (instancetype)sharedgege",所以，第一个字母要大写
 *
 *  @return 一个搞定好的方法名
 */
#define singleton_interface(className) + (className *)shared##className;


/**
 *  在.m文件中处理好的宏 arc
 *
 *  singleton_implementation(className) 这个是宏,因为是多行的东西，所以每行后面都有一个"\",最后一行除外，
 * 之所以还要传递一个“className”,是因为有个方法要命名"+ (instancetype)shared##className"
 *  @return 单例
 */
#define singleton_implementation(className) \
static id _instance;  \
+ (id)shared##className  \
{   \
if (_instance == nil) { \
_instance = [[self alloc] init];    \
}   \
return _instance;   \
}   \
+ (id)allocWithZone:(struct _NSZone *)zone  \
{   \
static dispatch_once_t once;    \
dispatch_once(&once, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance;   \
}   \
- (id)copyWithZone:(NSZone *)zone{  \
return _instance;   \
}

#endif /* Singleton_h */

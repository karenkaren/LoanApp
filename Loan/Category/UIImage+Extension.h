//
//  UIImage+Extension.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/24.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

#pragma mark - 颜色相关
#pragma mark -- 生成带纯色的图片
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

- (UIImage *)imageWithTintColor:(UIColor *)tintColor;
- (UIImage *)imageWithGradientTintColor:(UIColor *)tintColor;

#pragma mark - 生成圆角图片
+ (UIImage *)createRoundedRectImageWithImageName:(NSString *)imageName size:(CGSize)size radius:(CGFloat)radius;
- (UIImage *)imageWithCornerRadius:(CGFloat)radius;

#pragma mark - 生成二维码
#pragma mark -- 生成黑白色二维码
+ (UIImage *)imageOfQRFromString:(NSString *)string codeSize:(CGFloat)codeSize;
#pragma mark -- 生成自定义颜色的二维码
+ (UIImage *)imageOfQRFromString:(NSString *)string codeSize:(CGFloat)codeSize red:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue;
#pragma mark -- 生成自定义颜色、中间带圆角图片的二维码
+ (UIImage *)imageOfQRFromString:(NSString *)string codeSize:(CGFloat)codeSize red:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue insertImage:(UIImage *)insertImage roundRadius:(CGFloat)roundRadius;
#pragma mark -- 生成黑白色、中间带圆角图片的二维码
+ (UIImage *)imageOfQRFromString:(NSString *)string codeSize:(CGFloat)codeSize insertImage:(UIImage *)insertImage roundRadius:(CGFloat)roundRadius;
#pragma mark -- 生成黑白色、中间带圆角图片(圆角为5)的二维码
+ (UIImage *)imageOfQRFromString:(NSString *)string codeSize:(CGFloat)codeSize insertImage:(UIImage *)insertImage;
#pragma mark -- 生成自定义颜色、中间带圆角图片(圆角为5)的二维码
+ (UIImage *)imageOfQRFromString:(NSString *)string codeSize:(CGFloat)codeSize red:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue  insertImage:(UIImage *)insertImage;

@end

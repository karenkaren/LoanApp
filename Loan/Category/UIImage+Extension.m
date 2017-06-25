//
//  UIImage+Extension.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/24.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

#pragma mark - 颜色相关
#pragma mark -- 生成带纯色的图片
+ (UIImage *)imageWithColor:(UIColor *)color
{
    return [UIImage imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *) imageWithTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}

- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
}

- (UIImage *) imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode
{
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    
    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

#pragma mark - 生成圆角图片
+ (UIImage *)createRoundedRectImageWithImageName:(NSString *)imageName size:(CGSize)size radius:(CGFloat)radius
{
    UIImage * image = [UIImage imageNamed:imageName];
    radius = MIN(radius, MIN(size.width, size.height) * 0.5);
    return [image imageWithCornerRadius:radius];
}

- (UIImage *)imageWithCornerRadius:(CGFloat)radius
{
    CGRect rect = (CGRect){0.f, 0.f, self.size};
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(), [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    [self drawInRect:rect];
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    return image;
}

#pragma mark - 二维码生成
/**
 *  生成黑白色的二维码
 */
+ (UIImage *)imageOfQRFromString:(NSString *)string codeSize:(CGFloat)codeSize
{
    return [self imageOfQRFromString:string codeSize:codeSize red:0 green:0 blue:0];
}

/**
 *  自定义二维码颜色
 *  思路：遍历生成的二维码的像素点，将其中为白色的像素点填充为透明色，非白色则填充为我们自定义的颜色。但是，这里的白色并不单单指纯白色，rgb值高于一定数值的灰色我们也可以视作白色处理。在这里我对白色的定义为rgb值高于0xd0d0d0的颜色值为白色，这个值并不是确定的，大家可以自己设置。
 */
+ (UIImage *)imageOfQRFromString:(NSString *)string codeSize:(CGFloat)codeSize red:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue
{
    return [self imageOfQRFromString:string codeSize:codeSize red:red green:green blue:blue insertImage:nil roundRadius:0];
}

/**
 *  生成黑白色、中间带圆角图片的二维码
 */
+ (UIImage *)imageOfQRFromString:(NSString *)string codeSize:(CGFloat)codeSize insertImage:(UIImage *)insertImage roundRadius:(CGFloat)roundRadius
{
    return [self imageOfQRFromString:string codeSize:codeSize red:0 green:0 blue:0 insertImage:insertImage roundRadius:roundRadius];
}

/**
 *  生成黑白色、中间带圆角图片(圆角为5)的二维码
 */
+ (UIImage *)imageOfQRFromString:(NSString *)string codeSize:(CGFloat)codeSize insertImage: (UIImage *)insertImage
{
    return [self imageOfQRFromString:string codeSize:codeSize red:0 green:0 blue:0 insertImage:insertImage roundRadius:5];
}

/**
 *  生成自定义颜色、中间带圆角图片(圆角为5)的二维码
 */
+ (UIImage *)imageOfQRFromString:(NSString *)string codeSize:(CGFloat)codeSize red:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue  insertImage:(UIImage *)insertImage
{
    return [self imageOfQRFromString:string codeSize:codeSize red:red green:green blue:blue insertImage:insertImage roundRadius:5];
}

/**
 *  生成带颜色、中间插有圆角图片的二维码
 */
+ (UIImage *)imageOfQRFromString:(NSString *)string codeSize:(CGFloat)codeSize red: (NSUInteger)red green: (NSUInteger)green blue:(NSUInteger)blue insertImage:(UIImage *)insertImage roundRadius:(CGFloat)roundRadius
{
    
    if (!string || (NSNull *)string == [NSNull null]) { return nil; }
    
    /** 颜色不可以太接近白色*/
    NSUInteger rgb = (red << 16) + (green << 8) + blue;
    NSAssert((rgb & 0xffffff00) <= 0xd0d0d000, @"The color of QR code is two close to white color than it will diffculty to scan");
    
    codeSize = [self validateCodeSize:codeSize];
    CIImage * originImage = [self createQRFromString:string];
    
    UIImage * progressImage = [self excludeFuzzyImageFromCIImage:originImage size: codeSize];//到了这里二维码已经可以进行扫描了
    
    UIImage * effectiveImage = [self imageFillBlackColorAndTransparent:progressImage red:red green:green blue:blue];//进行颜色渲染后的二维码
    
    return [self imageInsertedImage:effectiveImage insertImage:insertImage radius:roundRadius];
}

/**
 *  在二维码原图中心位置插入圆角图像
 *  对中心位置的头像限制尺寸为二维码的四分之一，这个尺寸下的头像不失清晰度，而且图片尺寸也不至于遮盖了二维码的存储数据。
 */
+ (UIImage *)imageInsertedImage:(UIImage *)originImage insertImage:(UIImage *)insertImage radius:(CGFloat)radius
{
    
    if (!insertImage)
        return originImage;
    radius = MAX(5.f, radius);
    radius = MIN(10.f, radius);
    insertImage = [insertImage imageWithCornerRadius:radius];
    UIImage * whiteBG = [self imageWithColor:[UIColor whiteColor] size:CGSizeMake(200, 200)];
    whiteBG = [whiteBG imageWithCornerRadius:radius];
    //白色边缘宽度
    const CGFloat whiteSize = 2.f;
    CGSize brinkSize = CGSizeMake(originImage.size.width / 4, originImage.size.height / 4);
    CGFloat brinkX = (originImage.size.width - brinkSize.width) * 0.5;
    CGFloat brinkY = (originImage.size.height - brinkSize.height) * 0.5;
    CGSize imageSize = CGSizeMake(brinkSize.width - 2 * whiteSize, brinkSize.height - 2 * whiteSize);
    CGFloat imageX = brinkX + whiteSize;
    CGFloat imageY = brinkY + whiteSize;
    UIGraphicsBeginImageContextWithOptions(originImage.size, NO, 0);
    [originImage drawInRect:(CGRect){0, 0, (originImage.size)}];
    [whiteBG drawInRect:(CGRect){brinkX, brinkY, (brinkSize)}];
    [insertImage drawInRect: (CGRect){imageX, imageY, (imageSize)}];
    UIImage * resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

/**
 *  验证二维码尺寸的有效性
 */
+ (CGFloat)validateCodeSize:(CGFloat)codeSize
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    // 二维码图片为正方形，边长最小为屏幕宽度 * 0.5，最大为屏幕宽度
    codeSize = MAX(screenWidth * 0.5, codeSize);
    codeSize = MIN(screenWidth, codeSize);
    return codeSize;
}

/**
 *  利用系统滤镜生成二维码图
 */
+ (CIImage *)createQRFromString:(NSString *)string
{
    NSData * stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    CIFilter * qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    //设置纠错等级越高；即识别越容易，值可设置为L(Low) |  M(Medium) | Q | H(High)
    [qrFilter setValue:@"H" forKey:@"inputCorrectionLevel"];
    return qrFilter.outputImage;
}

/**
 *  对图像进行清晰化处理
 */
+ (UIImage *)excludeFuzzyImageFromCIImage:(CIImage *)image size: (CGFloat)size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size / CGRectGetWidth(extent), size / CGRectGetHeight(extent));
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    
    //创建灰度色调空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext * context = [CIContext contextWithOptions: nil];
    CGImageRef bitmapImage = [context createCGImage: image fromRect: extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    //Release
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    CGColorSpaceRelease(colorSpace);
    
    return [UIImage imageWithCGImage:scaledImage];
}

/**
 *  对生成二维码图像进行颜色填充
 *  步骤：判断rgb的有效值；对二维码进行颜色渲染。颜色渲染的过程包括获取图像的位图上下文、像素替换、二进制图像转换等操作
 */
+ (UIImage *)imageFillBlackColorAndTransparent: (UIImage *)image red:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue
{
    
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t bytesPerRow = imageWidth * 4;
    uint32_t * rgbImageBuf = (uint32_t *)malloc(bytesPerRow * imageHeight);
    //Create context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, (CGRect){(CGPointZero), (image.size)}, image.CGImage);
    
    //遍历像素
    int pixelNumber = imageHeight * imageWidth;
    [self fillWhiteToTransparentOnPixel: rgbImageBuf pixelNum: pixelNumber red: red green: green blue: blue];
    //Convert to image
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace, kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider, NULL, true, kCGRenderingIntentDefault);
    UIImage * resultImage = [UIImage imageWithCGImage: imageRef];
    CGImageRelease(imageRef);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    return resultImage;
}

/**
 *  遍历所有像素点进行颜色替换
 */
+ (void)fillWhiteToTransparentOnPixel:(uint32_t *)rgbImageBuf pixelNum:(int)pixelNum red:(NSUInteger)red green: (NSUInteger)green blue:(NSUInteger)blue
{
    uint32_t * pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++) {
        if ((*pCurPtr & 0xffffff00) < 0xd0d0d000) {
            uint8_t * ptr = (uint8_t *)pCurPtr;
            ptr[3] = red;
            ptr[2] = green;
            ptr[1] = blue;
        } else {
            //将白色变成透明色
            uint8_t * ptr = (uint8_t *)pCurPtr;
            ptr[0] = 0;
        }
    }
}

/*
 * @function ProviderReleaseData
 *
 * @abstract
 * 回调函数
 */
void ProviderReleaseData(void * info, const void * data, size_t size) {
    
    free((void *)data);
}

@end

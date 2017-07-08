//
//  GlobalAppearance.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/24.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#ifndef GlobalAppearance_h
#define GlobalAppearance_h

#pragma mark - 字体

#define kFont(size)  [CustomFont heiti:size]
#define kStringSize(string, fontSize) [string sizeWithAttributes:@{NSFontAttributeName : kFont(fontSize)}]

#pragma mark 常用字体大小

#define kFont36 kFont(36)
#define kFont18 kFont(18)
#define kFont14 kFont(14)
#define kFont12 kFont(12)

#pragma mark - 颜色

#define kHexColor(hexColor) [UIColor colorWithHex:hexColor]
#define kHexStringColor(hexStringColor) [UIColor colorWithHexString:hexStringColor]
#define kRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define kRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]
#define kRandomColor [UIColor colorWithRed:arc4random_uniform(255) / 255.0 green:arc4random_uniform(255) / 255.0 blue:arc4random_uniform(255) / 255.0 alpha:arc4random_uniform(10) / 10.0]

#pragma mark 常用颜色

#define kColorFF6600 kHexColor(0xFF6600)
#define kColor156FBB kHexColor(0x156FBB)
#define kColorFF0000 kHexColor(0xFF0000)
#define kColor2CB628 kHexColor(0x2CB628)
#define kColor333333 kHexColor(0x333333)
#define kColor999999 kHexColor(0x999999)
#define kColorD8D8D8 kHexColor(0xD8D8D8)

#define kMainColor kHexColor(0xFDD952)
#define kBackgroundColor kHexColor(0xF9F9F9)
#define kLineColor kColorD8D8D8
#define kTextColor kColor333333
#define kLinkColor kColor156FBB
#define kDisabledColor kColorD8D8D8
#define kWhiteColor [UIColor whiteColor]
#define kBlackColor [UIColor blackColor]

#endif /* GlobalAppearance_h */

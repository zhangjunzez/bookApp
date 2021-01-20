//
//  DYColorHelper.h
//  XILAIBANG
//
//  Created by ff on 2019/11/25.
//  Copyright © 2019 大點哥. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DYColorHelper : NSObject

// 是否暗黑模式
+(BOOL)isDarkSystemMode;

// 背景色-非黑即白(默认白)
+ (UIColor *)sysBGColor;

// 背景色-非黑即白(默认白)
+ (UIColor *)BGColor;

// 背景色-gray
+ (UIColor *)sysGrayColor:(int)gray lightColor:(nullable UIColor *)lightColor;

// 字体颜色- 51-221(默认51);
+ (UIColor *)default_51_221_Color;

// 字体颜色- 51-153(默认51)
+ (UIColor *)default_51_153_Color;

// 字体颜色- 51-242(默认51)
+ (UIColor *)default_51_242_Color;

// 背景色自定义
+(UIColor *)customDefaultColor:(UIColor *)defaultColor darkColor:(UIColor *)darkColor;

@end

NS_ASSUME_NONNULL_END

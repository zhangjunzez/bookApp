//
//  UIImage+Extension.h
//  WeiLv
//
//  Created by James on 16/5/30.
//  Copyright © 2016年 WeiLv Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *) imageFromURLString: (NSString *) urlstring;


+(NSString*)encodeToBase64String:(UIImage*)image;


+(NSData *)compressImageQuality:(UIImage *)image withMaxByte:(NSUInteger)maxByte;
+ (UIImage *)compressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength;
-(UIImage*)imageChangeColor:(UIColor*)color;

@end

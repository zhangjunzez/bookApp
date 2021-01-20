//
//  UIImage+RoundedRectImage.h
//
//  Created by LS on 16/4/29.
//  Copyright © 2016年 mifengkong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (RoundedRectImage)
/**   生成一个圆角图片 */
+ (id)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)r;
/**   生成一个圆角图片 */
- (UIImage *)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)r;
/**   生成一个带白边的圆角图片 */
- (UIImage *)imageWithBorderW:(CGFloat)borderWH borderColor:(UIColor *)color image:(UIImage *)image;

+ (NSString *)imageChangeToBase64:(UIImage *)image;

// 加载原始图片
+ (instancetype)imageWithOriginalName:(NSString *)imageName;

//根据颜色返回图片
+ (UIImage *)createImageWithColor:(UIColor *)color;

@end

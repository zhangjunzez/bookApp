//
//  TDMediaManager.h
//  TuDianEducation
//
//  Created by zpz on 2020/4/25.
//  Copyright © 2020 郑州大點哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDImageDataModel.h"
#import "TDMediaModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TDMediaManager : NSObject

///根据图片数据缓存图片
+ (TDMediaModel *)saveImageDataWith:(TDImageDataModel *)model;

///根据url获取本地缓存的图片数据
+ (TDMediaModel *)getImageDataWithUrl:(NSString *)url;

///根据链接返回图片数据
+ (TDMediaModel *)getImageDataWithLink:(NSString *)link;

///根据路径获取本地缓存的图片
+ (UIImage *)getImageWithPath:(NSString *)path;

///根据url缓存图片
+ (TDMediaModel *)saveImageWithURL:(NSString *)url image:(UIImage *)img;

///根据url获取本地缓存的图片
+ (UIImage *)getImageWithURL:(NSString *)url;

@end

NS_ASSUME_NONNULL_END

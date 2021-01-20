//
//  ImageDefine.h
//  TuDianEducation
//
//  Created by zpz on 2020/5/19.
//  Copyright © 2020 郑州大點哥. All rights reserved.
//


#define BUNDLE_PNGIMG(bundleName,name) [UIImage pz_imageNamed:name bundle:[NSBundle bundleWithPath:DYBundlePath(bundleName)]]
//#define BUNDLE_PNGIMG(bundleName,name) [UIImage imageWithContentsOfFile:[[NSBundle bundleWithPath:DYBundlePath(bundleName)] pathForResource:name ofType:@"png"]]
#define BUNDLE_JPEGIMG(bundleName,name) [UIImage imageWithContentsOfFile:[[NSBundle bundleWithPath:DYBundlePath(bundleName)] pathForResource:name ofType:@"jpeg"]]
#define BUNDLE_JPGIMG(bundleName,name) [UIImage imageWithContentsOfFile:[[NSBundle bundleWithPath:DYBundlePath(bundleName)] pathForResource:name ofType:@"jpg"]]

#pragma mark -Assets 取图片
#define UIImageNamed(name) [UIImage pz_imageNamed:name]
#define UIImageContentsOfFile(name) [UIImage pz_imageContentsOfFile:name]

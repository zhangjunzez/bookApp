//
//  UIImage+direction.h
//  JiLogistics
//
//  Created by zzzzz on 16/4/28.
//  Copyright © 2016年 zzzzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (direction)
- (UIImage *)changeDirection;

-(UIImage *)grayImage;

+(instancetype)pz_imageNamed:(NSString *)name bundle:(NSBundle *)bundle;

+(instancetype)pz_imageNamed:(NSString *)name;

+(instancetype)pz_imageContentsOfFile:(NSString *)name;

@end

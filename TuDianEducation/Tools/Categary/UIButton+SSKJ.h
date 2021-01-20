//
//  UIButton+SSKJ.h
//  SSKJ
//
//  Created by zpz on 2019/9/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (SSKJ)

+ (UIButton *)createWithTitle:( NSString * _Nullable)title titleColor:(UIColor * _Nullable)color font:(UIFont * _Nullable)font target:(id)target action:(SEL)action;

+ (UIButton *)createWithTitle:(NSString * _Nullable)title titleColor:(UIColor * _Nullable)color font:(UIFont * _Nullable)font frame:(CGRect)frame target:(id)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END

//
//  UILabel+SSKJ.h
//  SSKJ
//
//  Created by zpz on 2019/9/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (SSKJ)

+ (UILabel *)createWithText:(NSString *)text textColor:(UIColor *)color font:(UIFont *)font;
+ (UILabel *)createWithText:(NSString *)text textColor:(UIColor *)color font:(UIFont *)font frame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END

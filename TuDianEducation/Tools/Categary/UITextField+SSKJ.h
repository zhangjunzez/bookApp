//
//  UITextField+SSKJ.h
//  SSKJ
//
//  Created by zpz on 2019/9/23.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (SSKJ)

+ (UITextField *)createWithTextColor:(UIColor *)color font:(UIFont *)font placeholder:(NSString *)placeholder placeholderColor:(UIColor * _Nullable)pColor;

@end

NS_ASSUME_NONNULL_END

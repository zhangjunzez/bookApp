//
//  UILabel+SSKJ.m
//  SSKJ
//
//  Created by zpz on 2019/9/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "UILabel+SSKJ.h"

@implementation UILabel (SSKJ)

+ (UILabel *)createWithText:(NSString *)text textColor:(UIColor *)color font:(UIFont *)font{
    return [self createWithText:text textColor:color font:font frame:CGRectZero];
}


+ (UILabel *)createWithText:(NSString *)text textColor:(UIColor *)color font:(UIFont *)font frame:(CGRect)frame{
    
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    if (color) {
        label.textColor = color;
    }
    if (font) {
        label.font = font;
    }
    label.text = text;
    label.adjustsFontSizeToFitWidth = YES;
    return label;
}

@end

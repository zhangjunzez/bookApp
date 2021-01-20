//
//  UITextField+SSKJ.m
//  SSKJ
//
//  Created by zpz on 2019/9/23.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "UITextField+SSKJ.h"

@implementation UITextField (SSKJ)

+ (UITextField *)createWithTextColor:(UIColor *)color font:(UIFont *)font placeholder:(NSString *)placeholder placeholderColor:(UIColor *)pColor{
    UITextField *label = [[UITextField alloc]init];
    label.textColor = color;
    label.font = font;
    if (pColor) {
        label.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName:pColor}];
    }else{
        label.placeholder = placeholder;
    }
    return label;
}


@end

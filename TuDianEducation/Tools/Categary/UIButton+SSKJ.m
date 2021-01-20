//
//  UIButton+SSKJ.m
//  SSKJ
//
//  Created by zpz on 2019/9/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "UIButton+SSKJ.h"

@implementation UIButton (SSKJ)

+ (UIButton *)createWithTitle:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font target:(id)target action:(SEL)action{
    return [self createWithTitle:title titleColor:color font:font frame:CGRectZero target:target action:action];
}


+ (UIButton *)createWithTitle:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font frame:(CGRect)frame target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.titleLabel.font = font;
    if (target) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return button;
}
@end

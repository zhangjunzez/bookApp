//
//  UITextField+sets.m
//  XILAIBANG
//
//  Created by ff on 2019/10/5.
//  Copyright © 2019 大點哥. All rights reserved.
//

#import "UITextField+sets.h"

@implementation UITextField (sets)

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    
    if (self.tag%2 == 1) {
        //此处我们选择打开粘贴功能、其他功能都禁用
        if (action == @selector(paste:))
            return NO;
    }else {
        //此处我们选择打开选择、全选、复制功能、其他功能都禁用
        if (action == @selector(cut:) || action == @selector(paste:) || action == @selector(copy:) || action == @selector(select:) || action == @selector(selectAll:))
            return YES;
    }
    
    return NO;
}

@end

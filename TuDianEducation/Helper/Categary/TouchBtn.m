//
//  TouchBtn.m
//  XILAIBANG
//
//  Created by ff on 2019/9/9.
//  Copyright © 2019 大點哥. All rights reserved.
//

#import "TouchBtn.h"

@implementation TouchBtn

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    UITouch*touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (self.pointBlock) {
        self.pointBlock(point);
    }
//    DYLog(@"=======%@",NSStringFromCGPoint(point));
}

@end

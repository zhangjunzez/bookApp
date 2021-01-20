//
//  UIView+Shake.m
//  XILAIBANG
//
//  Created by ff on 2019/9/9.
//  Copyright © 2019 大點哥. All rights reserved.
//

#import "UIView+Shake.h"

@implementation UIView (Shake)

-(void)shake{
    
    // 创建关键帧动画对象
    
    CAKeyframeAnimation *shake = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    
    CGFloat x1 = self.center.x;
    
    CGFloat x2 = self.center.x-5;
    
    CGFloat x3 = self.center.x+5;
    
    shake.values = @[@(x1),@(x2),@(x1),@(x3),@(x1)];
    
    shake.duration = 0.1;
    
    shake.repeatCount = 3;
    
    [self.layer addAnimation:shake forKey:nil];
    
}

@end

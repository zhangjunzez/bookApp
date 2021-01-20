//
//  UIButton+Extension.m
//  TuDianEducation
//
//  Created by 张本超 on 2020/4/15.
//  Copyright © 2020 郑州大點哥. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)
/**
 上部分是图片，下部分是文字
 
 @param space 间距
 */
- (void)setUpImageAndDownLableWithSpace:(CGFloat)space isCollect:(BOOL)collect;{
    
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    // 测试的时候发现titleLabel的宽度不正确，这里进行判断处理
    CGFloat labelWidth = self.titleLabel.intrinsicContentSize.width;
    if (titleSize.width < labelWidth) {
        titleSize.width = labelWidth;
    }
    
    // 文字距上边框的距离增加imageView的高度+间距，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [self setTitleEdgeInsets:UIEdgeInsetsMake(imageSize.height+space, -imageSize.width, -space, 0.0)];
    
    // 图片距右边框的距离减少图片的宽度，距离上面的间隔，其它不变
    if (collect) {
        [self setImageEdgeInsets:UIEdgeInsetsMake(-space, 0.0,0.0,-titleSize.width- space/2.f+1)];
    }else{
       [self setImageEdgeInsets:UIEdgeInsetsMake(-space, 0.0,0.0,-titleSize.width)];
    }
    
}

@end

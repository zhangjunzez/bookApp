//
//  LXTitleImgView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/29.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXTitleImgView : UIView
-(instancetype)initWithTop:(CGFloat)top title:(NSString *)title imageArray:(NSArray *)imgArray imgeWidth:(CGFloat)imgwidth;
@property (nonatomic,strong) NSArray *imgArray;
@end

NS_ASSUME_NONNULL_END

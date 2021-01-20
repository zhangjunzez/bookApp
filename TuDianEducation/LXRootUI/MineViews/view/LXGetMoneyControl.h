//
//  LXGetMoneyControl.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/28.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXGetMoneyControl : UIView

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, copy) void(^btnClickedBlock)(NSInteger index);

-(instancetype)initWithTop:(CGFloat)top titleArray:(NSArray *)titleArray;

-(instancetype)initWithTop:(CGFloat)top titleArray:(NSArray *)titleArray width:(CGFloat)width;

@end
NS_ASSUME_NONNULL_END

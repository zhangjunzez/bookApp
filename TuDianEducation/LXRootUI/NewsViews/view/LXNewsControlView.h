//
//  LXNewsControlView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/30.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXNewsControlView : UIView

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, strong) NSArray *bttonsArray;

@property (nonatomic, copy) void(^btnClickedBlock)(NSInteger index);

-(instancetype)initWithTop:(CGFloat)top titleArray:(NSArray *)titleArray;

-(instancetype)initWithTop:(CGFloat)top titleArray:(NSArray *)titleArray width:(CGFloat)width;

@end
NS_ASSUME_NONNULL_END

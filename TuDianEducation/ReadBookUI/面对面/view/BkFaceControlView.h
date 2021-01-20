//
//  BkFaceControlView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/11.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BkFaceControlView : UIView
@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, copy) void(^btnClickedBlock)(NSInteger index);

-(instancetype)initWithTop:(CGFloat)top titleArray:(NSArray *)titleArray;

-(instancetype)initWithTop:(CGFloat)top titleArray:(NSArray *)titleArray width:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END

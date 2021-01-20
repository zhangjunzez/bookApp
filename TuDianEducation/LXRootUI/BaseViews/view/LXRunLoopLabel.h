//
//  LXRunLoopLabel.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/30.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LXRunLoopLabel;

typedef NS_ENUM(NSInteger, RunDirectionType) {
    LeftType = 0,
    RightType = 1,
};

@protocol LXRunLoopLabelDelegate <NSObject>

@optional
- (void)operateLabel: (LXRunLoopLabel *)autoLabel animationDidStopFinished: (BOOL)finished;

@end

@interface LXRunLoopLabel : UIView

@property (nonatomic, weak) id <LXRunLoopLabelDelegate> delegate;
@property (nonatomic, assign) CGFloat speed;
@property (nonatomic, assign) RunDirectionType directionType;

- (void)addContentView: (UIView *)view;
- (void)startAnimation;
- (void)stopAnimation;
@end
NS_ASSUME_NONNULL_END

//
//  OrderDetailBottomOctionView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/9.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailBottomOctionView : UIView
@property (nonatomic,copy) void(^payBlock)(void);
@property (nonatomic,copy) void(^cancellBlock)(void);
@end

NS_ASSUME_NONNULL_END

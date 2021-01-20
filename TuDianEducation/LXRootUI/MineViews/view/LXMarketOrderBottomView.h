//
//  LXMarketOrderBottomView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/29.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXMarketOrderDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LXMarketOrderBottomView : UIView
@property (nonatomic,copy) void(^confirmDoneBlock)(void);
@property (nonatomic,copy) void(^seeFlowsBlock)(void);
@property (nonatomic,copy) void(^rightBtnBlock)(void);
@property (nonatomic,copy) void(^deleteBlock)(void);
@property (nonatomic,strong) LXMarketOrderDetailModel *model;
@end

NS_ASSUME_NONNULL_END

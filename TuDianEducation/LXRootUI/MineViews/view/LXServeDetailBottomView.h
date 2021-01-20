//
//  LXServeDetailBottomView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/29.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXServerOrderDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LXServeDetailBottomView : UIView
@property (nonatomic,copy) void(^payBlock)(void);
///确认完成
@property (nonatomic,copy) void(^confirmDoneBlock)(void);
///删除订单
@property (nonatomic,copy) void(^deleteOrderBlock)(void);
///btn事件Blcok
@property (nonatomic,copy) void(^ensureBtnBlock)(void);

@property (nonatomic,strong) LXServerOrderDetailModel *model;
@end

NS_ASSUME_NONNULL_END

//
//  LXMineHeader.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/23.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,MineStatusType) {
    MineStatusTypeLogin,
    MineStatusTypeLoginOut,
};
@class LXUserInforModel;
@interface LXMineHeader : UIView
///个人信息
@property (nonatomic,copy) void(^userInforBlock)(void);

///需求订单
@property (nonatomic,copy) void(^requstOrderBlock)(void);
///服务订单
@property (nonatomic,copy) void(^serverOrderBlock)(void);
///积分订单
@property (nonatomic,copy) void(^scoreOrderBlock)(void);
///签到
@property (nonatomic,copy) void(^signActionBlock)(void);
///积分商城
@property (nonatomic,copy) void(^scoreMarketBlock)(void);
///头部类型
@property (nonatomic,assign) MineStatusType statusType;

@property (nonatomic,strong) LXUserInforModel *model;


@end

NS_ASSUME_NONNULL_END

//
//  LXRequstOrderTableViewCell.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/28.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXMineRequstOrderListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LXRequstOrderTableViewCell : UITableViewCell
///确认完成
@property (nonatomic,copy) void(^confirmDoneBlock)(void);
///删除订单
@property (nonatomic,copy) void(^deleteOrderBlock)(void);
///btn事件Blcok
@property (nonatomic,copy) void(^ensureBtnBlock)(void);

///btn事件Blcok
@property (nonatomic,copy) void(^cancellBlock)(void);

@property (nonatomic,strong) LXMineRequstOrderListModel *model;
@end

NS_ASSUME_NONNULL_END

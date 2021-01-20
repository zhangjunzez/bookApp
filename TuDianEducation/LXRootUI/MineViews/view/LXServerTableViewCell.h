//
//  LXServerTableViewCell.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/29.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXMineRequstOrderListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LXServerTableViewCell : UITableViewCell
@property (nonatomic,strong) LXMineRequstOrderListModel *model;
///确认完成
@property (nonatomic,copy) void(^confirmDoneBlock)(void);
///删除订单
@property (nonatomic,copy) void(^deleteOrderBlock)(void);
///btn事件Blcok
@property (nonatomic,copy) void(^ensureBtnBlock)(void);
@end

NS_ASSUME_NONNULL_END

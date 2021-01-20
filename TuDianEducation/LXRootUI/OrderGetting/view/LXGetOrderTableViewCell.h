//
//  LXGetOrderTableViewCell.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/30.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXGetOrderListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LXGetOrderTableViewCell : UITableViewCell
@property (nonatomic,copy) void(^getOrderBlock)(void);
@property (nonatomic,strong) LXGetOrderListModel *model;
@end

NS_ASSUME_NONNULL_END

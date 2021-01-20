//
//  LXScoreOrderTableViewCell.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/29.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXScoreOrderListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LXScoreOrderTableViewCell : UITableViewCell
@property (nonatomic,copy) void(^confirmDoneBlock)(void);
@property (nonatomic,copy) void(^seeFlowsBlock)(void);
@property (nonatomic,copy) void(^deleteBlock)(void);
@property (nonatomic,copy) void(^rightBtnBlock)(void);
@property (nonatomic,strong) LXScoreOrderListModel *model;
@end

NS_ASSUME_NONNULL_END

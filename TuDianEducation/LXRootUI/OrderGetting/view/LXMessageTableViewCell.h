//
//  LXMessageTableViewCell.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/30.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXMessageModel;
NS_ASSUME_NONNULL_BEGIN

@interface LXMessageTableViewCell : UITableViewCell
@property (nonatomic,strong) LXMessageModel *model;
@end

NS_ASSUME_NONNULL_END

//
//  LXNewsTableViewCell.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/30.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class LXNewsModel;
@interface LXNewsTableViewCell : UITableViewCell
@property (nonatomic,strong) LXNewsModel *model;
@end

NS_ASSUME_NONNULL_END

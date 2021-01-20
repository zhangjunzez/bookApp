//
//  LXMyScoreTableViewCell.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/24.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class LXScoreListModel;
@interface LXMyScoreTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *dateLable;
@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic,strong) LXScoreListModel *model;

@end

NS_ASSUME_NONNULL_END

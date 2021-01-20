//
//  LXMinePublishTableViewCell.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/28.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class LXLearnModel,LXMySkillModel;
@interface LXMinePublishTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *statusImg;
@property (nonatomic,strong) UIButton *pointBtn;
@property (nonatomic,strong) UIButton *viewsBtn;
@property (nonatomic,strong) LXLearnModel *model;
@property (nonatomic,strong) LXMySkillModel *skillModel;
@property (nonatomic,copy) void(^pointsBlock)(void);
@end

NS_ASSUME_NONNULL_END

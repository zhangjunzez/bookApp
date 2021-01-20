//
//  LXTuijianTableViewCell.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/24.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class LXMyTuijianModel,LXLearnModel;
@interface LXTuijianTableViewCell : UITableViewCell
@property (nonatomic,strong) LXMyTuijianModel *model;
@property (nonatomic,strong) LXLearnModel *studyModel;
@end

NS_ASSUME_NONNULL_END

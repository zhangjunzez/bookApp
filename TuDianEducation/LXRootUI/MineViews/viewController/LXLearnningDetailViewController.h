//
//  LXLearnningDetailViewController.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/2.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,LearnningEdtingType) {
    LearnningEdtingTypeEdting,
    LearnningEdtingTypeNone,
};
@class LXMySkillModel;
@interface LXLearnningDetailViewController : BaseViewController
@property (nonatomic,assign) LearnningEdtingType edtingType;
@property (nonatomic,strong) LXMySkillModel *model;

@end

NS_ASSUME_NONNULL_END

//
//  LXRealCommitSucessAlertVc.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/24.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXRealCommitSucessAlertVc : BaseViewController
@property (nonatomic,copy) void(^callBackBlcok)(void);
@end

NS_ASSUME_NONNULL_END
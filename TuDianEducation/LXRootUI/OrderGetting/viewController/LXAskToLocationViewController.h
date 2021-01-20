//
//  LXAskToLocationViewController.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/10.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXAskToLocationViewController : BaseViewController
@property (nonatomic,copy) void(^gotoBlock)(void);
@property (nonatomic,copy) void(^cancellBlock)(void);
@end

NS_ASSUME_NONNULL_END

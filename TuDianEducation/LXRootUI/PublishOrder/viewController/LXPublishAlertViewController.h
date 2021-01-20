//
//  LXPublishAlertViewController.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/1.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXPublishAlertViewController : BaseViewController
@property (nonatomic,assign) void (^callBackBlock)(void);
@end

NS_ASSUME_NONNULL_END

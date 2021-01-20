//
//  DSUserDelegeViewController.h
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/6.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DSUserDelegeViewController : BaseViewController

@property (nonatomic,copy) void(^callBackBlock)(BOOL isselect);

@end

NS_ASSUME_NONNULL_END

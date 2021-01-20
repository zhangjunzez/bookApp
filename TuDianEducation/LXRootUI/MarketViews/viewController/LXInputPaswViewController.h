//
//  LXInputPaswViewController.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/2.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXInputPaswViewController : BaseViewController
@property (nonatomic,copy) void(^callBackBlock)(NSString *payPassWord);
@property (nonatomic,copy) void(^forgetPayPassWordBlock)(void);
@end

NS_ASSUME_NONNULL_END

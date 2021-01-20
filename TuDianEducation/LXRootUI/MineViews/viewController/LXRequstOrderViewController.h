//
//  LXRequstOrderViewController.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/29.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXRequstOrderViewController : BaseViewController
///订单状态 0待支付 1服务中 2待评价 3已完成 4异常订单
@property (nonatomic,strong) NSString *state;
@end

NS_ASSUME_NONNULL_END

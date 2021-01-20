//
//  LXMarketOrderViewController.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/29.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXMarketOrderViewController : BaseViewController
 /////订单状态0待发货 1待收货 2已完成 (不传是全部)
@property (nonatomic,strong) NSString *state;
@end

NS_ASSUME_NONNULL_END

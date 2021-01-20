//
//  LXDetailBottomView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/2.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXMarketGoodsDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LXDetailBottomView : UIView
@property (nonatomic,strong) LXMarketGoodsDetailModel *model;
@property (nonatomic,copy) void(^reloadFrameBlock)(void);
@end

NS_ASSUME_NONNULL_END

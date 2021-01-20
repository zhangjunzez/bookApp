//
//  LXMarketEnsureTopView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/2.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXAddressModel.h"
#import "LXMarketGoodsDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LXMarketEnsureTopView : UIView
@property (nonatomic,copy) void(^gotoAddressBlock)(void);
@property (nonatomic,strong) LXAddressModel *model;
@property (nonatomic,strong) LXMarketGoodsDetailModel *detailModel;
@property (nonatomic,copy) void(^scoreAmountBlock)(NSInteger amount);
@property (nonatomic,assign) NSInteger amountCount;
@end

NS_ASSUME_NONNULL_END

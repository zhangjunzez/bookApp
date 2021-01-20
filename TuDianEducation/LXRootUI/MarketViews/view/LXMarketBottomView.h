//
//  LXMarketBottomView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/2.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXMarketBottomView : UIView
@property (nonatomic,copy) void(^conformBuyBlock)(void);
@property (nonatomic,strong) UILabel *priceLabel;
@end

NS_ASSUME_NONNULL_END

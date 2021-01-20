//
//  BkConformBottomView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/14.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BkConformBottomView : UIView
@property (nonatomic,copy) void(^conformBuyBlock)(void);
@property (nonatomic,strong) UILabel *priceLabel;
@end

NS_ASSUME_NONNULL_END

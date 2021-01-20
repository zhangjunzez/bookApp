//
//  BkMoneyBackView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/9.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BkMoneyBackView : UIView
@property (nonatomic,copy) void(^scoreAmountBlock)(NSInteger amount);
@property (nonatomic,assign) NSInteger amountCount;
@property (nonatomic,copy) void(^callBackBlock)(void);
@end

NS_ASSUME_NONNULL_END

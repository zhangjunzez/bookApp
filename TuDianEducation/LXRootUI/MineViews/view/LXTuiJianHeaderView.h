//
//  LXTuiJianHeaderView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/24.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXTuiJianHeaderView : UIView
@property (nonatomic,copy) void(^getMoneyBlock)(void);
@property (nonatomic,strong) UILabel *valueLabel;
@end

NS_ASSUME_NONNULL_END

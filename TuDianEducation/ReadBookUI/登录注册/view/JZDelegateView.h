//
//  JZDelegateView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/8/28.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JZDelegateView : UIView
@property (nonatomic,strong) UILabel *agreeLabel;
///用户协议
@property (nonatomic,copy) void(^userDelegateBlcok)(void);
///隐私政策
@property (nonatomic,copy) void(^securatyBlcok)(void);
@end

NS_ASSUME_NONNULL_END

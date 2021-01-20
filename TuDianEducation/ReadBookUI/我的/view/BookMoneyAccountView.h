//
//  BookMoneyAccountView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/7.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BookMoneyAccountView : UIView
@property (nonatomic,copy) void(^gotoBlock)(void);
@end

NS_ASSUME_NONNULL_END

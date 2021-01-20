//
//  BkOrderAddressView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/13.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BkOrderAddressView : UIView
@property (nonatomic,copy) void(^gotoAddressBlock)(void);
@end

NS_ASSUME_NONNULL_END

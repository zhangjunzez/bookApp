//
//  LXRequstDetailHeaderView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/29.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXRequstOrderDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LXRequstDetailHeaderView : UIView
@property (nonatomic,copy) void(^gotoAddressBlock)(void);
@property (nonatomic,copy) void(^reloadFrameBlock)(void);
@property (nonatomic,strong) LXRequstOrderDetailModel *model;
@end

NS_ASSUME_NONNULL_END

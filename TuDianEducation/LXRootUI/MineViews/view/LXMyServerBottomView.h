//
//  LXMyServerBottomView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/1.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class LXServerDetailModel;
@interface LXMyServerBottomView : UIView
@property (nonatomic,strong) LXServerDetailModel *model;
@property (nonatomic,copy) void(^reloadFrameBlcok)(void);
@end

NS_ASSUME_NONNULL_END

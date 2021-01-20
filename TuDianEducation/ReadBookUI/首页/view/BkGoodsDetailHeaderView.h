//
//  BkGoodsDetailHeaderView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/13.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BkGoodsDetailHeaderView : UIView
@property (nonatomic,copy) void(^reloadFrameBlock)(void);
@property (nonatomic,copy) void(^moreConmendBlock)(void);
@property (nonatomic,copy) void(^authorBlock)(void);
@end

NS_ASSUME_NONNULL_END

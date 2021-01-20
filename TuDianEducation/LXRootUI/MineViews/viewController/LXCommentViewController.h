//
//  LXCommentViewController.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/30.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "BaseViewController.h"
//#import "orderDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LXCommentViewController : BaseViewController
@property (nonatomic, copy) void(^callBackBlock)(void);
//@property (nonatomic, strong) orderDetailModel *model;
@end

NS_ASSUME_NONNULL_END

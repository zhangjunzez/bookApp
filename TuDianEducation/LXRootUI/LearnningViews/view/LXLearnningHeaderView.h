//
//  LXLearnningHeaderView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/30.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXLearnningHeaderView : UIView
@property (nonatomic,copy) void(^searchBlock)(void);
@property (nonatomic,strong) UITextField *searchTf;
@end

NS_ASSUME_NONNULL_END

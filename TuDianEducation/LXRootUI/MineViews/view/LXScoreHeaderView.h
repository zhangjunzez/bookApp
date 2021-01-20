//
//  LXScoreHeaderView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/24.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXScoreHeaderView : UIView
@property (nonatomic,copy) void(^selectIndexBlock)(NSInteger index);
@property (nonatomic,strong) UILabel *valueLabel;
@end

NS_ASSUME_NONNULL_END

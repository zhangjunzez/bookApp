//
//  LXSearchSectionView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/3.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXSearchSectionView : UIView
@property (nonatomic,copy) void(^reloadBlock)(void);
@property (nonatomic,copy) void(^locationBlock)(void);
@property (nonatomic,strong) UIButton *loactionBtn;
@end

NS_ASSUME_NONNULL_END

//
//  BkHomePageView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/12.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BkHomePageView : UIView
@property (nonatomic,copy) void(^selctItemBlock)(NSInteger index);
@property (nonatomic,copy) void(^selctThemeBlock)(NSInteger index);
@property (nonatomic,copy) void(^seeMoreBlock)(void);
@end

NS_ASSUME_NONNULL_END

//
//  LXMineHeaderItemView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/23.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface LXMineHeaderItemView : UIView
-(instancetype)initWithImge:(UIImage *)img message:(NSString *)message;
@property (nonatomic,copy) void(^itemClickBlock)(void);
@end
NS_ASSUME_NONNULL_END

//
//  LXHeaderSignItemView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/23.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXHeaderSignItemView : UIView
-(instancetype)initWithTop:(CGFloat)top left:(CGFloat)left title:(NSString *)title subTitle:(NSString *)subTitle imgeName:(NSString *)imgeName;
@property (nonatomic,copy) void(^itemClickedBlock)(void);

@end

NS_ASSUME_NONNULL_END

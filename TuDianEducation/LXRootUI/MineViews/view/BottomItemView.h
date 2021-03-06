//
//  BottomItemView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/24.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface BottomItemView : UIView
-(instancetype)initWithImge:(UIImage *)img message:(NSString *)message;
@property (nonatomic,copy) void(^itemClickBlock)(NSInteger index);
///位置
@property (nonatomic,assign) NSInteger index;

@end

NS_ASSUME_NONNULL_END

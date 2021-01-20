//
//  BookAgeHeaderView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/12.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BookAgeHeaderView : UIView
@property (nonatomic,copy) void(^selctItemBlock)(NSInteger index);
@end

NS_ASSUME_NONNULL_END

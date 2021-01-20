//
//  BookOrderView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/6.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BookOrderView : UIView
@property (nonatomic,copy) void(^orderSelectBlock)(NSString *title);
@property (nonatomic,copy) void(^seeAllOrderBlock)(void);
@end

NS_ASSUME_NONNULL_END

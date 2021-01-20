//
//  CalendarView.h
//  tudianjiaoyu
//
//  Created by 张本超 on 2020/4/3.
//  Copyright © 2020 张本超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CalendarModel;
NS_ASSUME_NONNULL_BEGIN

@interface CalendarView : UIView

@property (nonatomic, copy) void(^selectBlock)(CalendarModel *model);

@property (nonatomic, strong) CalendarModel *selectModel;
@end

NS_ASSUME_NONNULL_END

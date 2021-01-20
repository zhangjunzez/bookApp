//
//  CalendarModel.h
//  tudianjiaoyu
//
//  Created by 张本超 on 2020/4/3.
//  Copyright © 2020 张本超. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//哪一天
typedef NS_ENUM(NSInteger, DayType) {
    Other = 0,
    Today,                    /**< 今天 */
    Tomorrow,                 /**< 明天 */
    AfterTomorrow             /**< 后天 */
};


@interface CalendarModel : NSObject

@property (nonatomic, strong) NSString *time;                     /**< 时间戳*/
@property (nonatomic, strong) NSString *year;
@property (nonatomic, strong) NSString *month;
@property (nonatomic, strong) NSString *day;
@property (nonatomic, strong) NSString *week;
@property (nonatomic, strong) NSString *weekName;
@property (nonatomic, assign) DayType dayType;                    /**< 是否是今天,明天,后天 */
@property (nonatomic, assign) BOOL isSelected;
/**< 是否被选择 */
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *durction;//时间段
@property (nonatomic, assign) NSInteger durIndex;//时间段的位置
@property (nonatomic, strong) NSString *currentHour;
@property (nonatomic, assign) BOOL canSelect;

@property (nonatomic, assign) NSInteger nums;

@end
NS_ASSUME_NONNULL_END

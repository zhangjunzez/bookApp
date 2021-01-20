//
//  CalendarHelper.h
//  tudianjiaoyu
//
//  Created by 张本超 on 2020/4/3.
//  Copyright © 2020 张本超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalendarModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CalendarHelper : NSObject
//根据某一日数据初始化该月数据源
+(NSMutableArray *)createMonthDataInday:(NSString *)dateStr;
//下某月的数据源
+(NSMutableArray *)createMonthDataWith:(NSInteger)index;
///某个时间点下某月
+(NSMutableArray *)createMonthDataWith:(NSInteger)index date:(NSDate*)date;
+(NSMutableArray *)getDateWeeksDuraingTodayOffset:(NSInteger)Offset;
+(NSArray *)weeksName;
+(NSArray *)weeksFullName;
+(NSArray *)timesDurctions;
///时间校验
+(void)setToday:(NSDate *)date;
@end

NS_ASSUME_NONNULL_END

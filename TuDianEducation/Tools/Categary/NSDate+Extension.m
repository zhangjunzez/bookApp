//
//  NSDate+Extension.m
//  tudianjiaoyu
//
//  Created by 张本超 on 2020/4/3.
//  Copyright © 2020 张本超. All rights reserved.
//

#import "NSDate+Extension.h"

static NSDate *today =nil;
@implementation NSDate (Extension)

/// 获取年
+ (NSInteger)year:(NSString *)dateStr {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    NSDate *startDate = [dateFormatter dateFromString:dateStr];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:startDate];
    return components.year;
}

/// 获取月
+ (NSInteger)month:(NSString *)dateStr {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    NSDate *startDate = [dateFormatter dateFromString:dateStr];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:startDate];
    return components.month;
}


/// 获取星期
+ (NSInteger)week:(NSString *)dateStr {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    NSDate *startDate = [dateFormatter dateFromString:dateStr];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday) fromDate:startDate];
    return components.weekday - 1;
}

/// 获取星期 中文
+ (NSString *)getWeekFromDate:(NSDate *)date {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday) fromDate:date];
    NSInteger week = components.weekday - 1;
    NSDictionary *weekDic = @{@"0":@"日",@"1":@"一",@"2":@"二",@"3":@"三",@"4":@"四",@"5":@"五",@"6":@"六"};
    NSString *key = [NSString stringWithFormat:@"%ld",(long)week];
    return weekDic[key];
}

/// 获取星期中文
+ (NSString *)getChineseWeekFrom:(NSString *)dateStr {
    NSDictionary *weekDic = @{@"0":@"周日",@"1":@"周一",@"2":@"周二",@"3":@"周三",@"4":@"周四",@"5":@"周五",@"6":@"周六"};
    NSInteger week = [NSDate week:dateStr];
    NSString *weekKey = [NSString stringWithFormat:@"%ld",(long)week];
    return weekDic[weekKey];
}

/// 获取日
+ (NSInteger)day:(NSString *)dateStr {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    NSDate *startDate = [dateFormatter dateFromString:dateStr];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:startDate];
    return components.day;
}

/// 获取月共有多少天
+ (NSInteger)daysInMonth:(NSString *)dateStr {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[NSDate timeIntervalFromDateString:dateStr] / 1000];
    NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInLastMonth.length;
}

//获取当前日期
+ (NSString *)currentDay {
    NSDateFormatter *formater = [[ NSDateFormatter alloc] init];
    NSDate *date = today?:[NSDate date];
    [formater setDateFormat:@"yyyy-MM-dd"];
    NSString * time = [formater stringFromDate:date];
    return time;
}

//获取当前小时
+ (NSString *)currentHour {
    NSDateFormatter *formater = [[ NSDateFormatter alloc] init];
    NSDate *curDate = today?:[NSDate date];
    [formater setDateFormat:@"H:mm"];
    NSString * curTime = [formater stringFromDate:curDate];
    return curTime;
}

//找到两个月后的第一天~ 然后通过减一天来找到下个月的最后一天，所以，下月最后一天
+ (NSString *)nextMonthLastDay {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:today?:[NSDate date]];
    //设置日为1号
    dateComponents.day =1;
    //设置月份为后延2个月
    dateComponents.month +=2;
    NSDate * endDayOfNextMonth = [calendar dateFromComponents:dateComponents];
    //两个月后的1号往前推1天，即为下个月最后一天
    endDayOfNextMonth = [endDayOfNextMonth dateByAddingTimeInterval:-1];
    //格式化输出
    NSDateFormatter *formater = [[ NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    NSString * curTime = [formater stringFromDate:endDayOfNextMonth];
    return curTime;
}
/// 获取下某月最后一天
+(NSString *)nextIndexMonthLastDay:(NSInteger)index
{
   return  [self nextIndexMonthLastDay:index date:today?:[NSDate date]];
};
/// 获取某个日期下某月最后一天
+(NSString *)nextIndexMonthLastDay:(NSInteger)index date:(NSDate *)date
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
       NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
        index = index - 1;
       //设置日为1号
       dateComponents.day =1;
       //设置月份为后延2个月
       dateComponents.month +=index + 2;
       NSDate * endDayOfNextMonth = [calendar dateFromComponents:dateComponents];
       //两个月后的1号往前推1天，即为下个月最后一天
       endDayOfNextMonth = [endDayOfNextMonth dateByAddingTimeInterval:-1];
       //格式化输出
       NSDateFormatter *formater = [[ NSDateFormatter alloc] init];
       [formater setDateFormat:@"yyyy-MM-dd"];
       NSString * curTime = [formater stringFromDate:endDayOfNextMonth];
       return curTime;
};
///判断是否是今天
+ (BOOL)isToday:(NSString *)dateStr {
    BOOL isDay = NO;
    NSString *day = [NSDate timeStringWithInterval:(today?:[NSDate date]).timeIntervalSince1970];
    if ([dateStr isEqualToString:day]) {
        isDay = YES;
    }
    return isDay;
}

///判断是否是明天
+ (BOOL)isTomorrow:(NSString *)dateStr {
    BOOL isDay = NO;
    NSTimeInterval time = (today?:[NSDate date]).timeIntervalSince1970 + 24 * 3600;
    NSString *day = [NSDate timeStringWithInterval:time];
    if ([dateStr isEqualToString:day]) {
        isDay = YES;
    }
    return isDay;
}

///判断是否是后天
+ (BOOL)isAfterTomorrow:(NSString *)dateStr {
    BOOL isDay = NO;
    NSTimeInterval time = (today?:[NSDate date]).timeIntervalSince1970 + 48 * 3600;
    NSString *day = [NSDate timeStringWithInterval:time];
    if ([dateStr isEqualToString:day]) {
        isDay = YES;
    }
    return isDay;
}

/// 判断是否是过去的时间
+ (BOOL)isHistoryTime:(NSString *)dateStr {
    BOOL activity = NO;
    NSTimeInterval timeInterval = [NSDate timeIntervalFromDateString: dateStr];
    NSTimeInterval currentInterval = [NSDate timeIntervalFromDateString:[NSDate currentDay]];
    if (timeInterval < currentInterval) {
        activity = YES;
    }
    return activity;
}

/// 从时间戳获取具体时间 格式:6:00
+ (NSString *)hourStringWithInterval:(NSTimeInterval)timeInterval {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"H:mm"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    return dateString;
}

/// 从时间戳获取具体小时 格式:6
+ (NSString *)hourTagWithInterval:(NSTimeInterval)timeInterval {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"H"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

/// 从毫秒级时间戳获取具体小时 格式:600
+ (NSString *)hourNumberWithInterval:(NSTimeInterval)timeInterval {
    NSString *hourStr = [self hourStringWithInterval:timeInterval / 1000];
    NSString *hourNumber = [hourStr stringByReplacingOccurrencesOfString:@":" withString:@""];
    return hourNumber;
}

/// 从时间戳获取具体日期 格式:2018-03-05
+ (NSString *)timeStringWithInterval:(NSTimeInterval)timeInterval {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

/// 根据具体日期获取时间戳(毫秒)
+ (NSTimeInterval)timeIntervalFromDateString:(NSString *)dateStr {
    //要精确到毫秒2018-01-01 与 2018-01-01 00:00 都要转换成2018-01-01 00:00:00
    if (dateStr.length == 10) {
        dateStr = [dateStr stringByAppendingString:@" 00:00:00"];
    } else if (dateStr.length == 16) {
        dateStr = [dateStr stringByAppendingString:@":00"];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    NSTimeInterval interval = [date timeIntervalSince1970] * 1000;
    return interval;
}

/// 获取当前天的后几天的星期
+ (NSString *)getWeekAfterDay:(NSInteger)day {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday) fromDate:today?:[NSDate date]];
    NSInteger currentWeek = components.weekday - 1;
    NSDictionary *weekDic = @{@"0":@"日",@"1":@"一",@"2":@"二",@"3":@"三",@"4":@"四",@"5":@"五",@"6":@"六"};
    NSInteger week = currentWeek + day;
    if (week >= 7) {
        week -= 7;
    }
    NSString *key = [NSString stringWithFormat:@"%ld",(long)week];
    return weekDic[key];
}


/// 获取当前天的后几天的日
+ (NSString *)getDayAfterDay:(NSInteger)day {
    NSTimeInterval time = (today?:[NSDate date]).timeIntervalSince1970 + 24 * 3600 * day;
    NSString *date = [NSDate timeStringWithInterval:time];
    NSInteger dayNum = [self day:date];
    NSString *dayStr = [NSString stringWithFormat:@"%ld",(long)dayNum];
    return dayStr;
}

/// 获取当前月的后几月
+ (NSString *)getMonthAfterMonth:(NSInteger)Month {
    NSDate *currentDate = today?:[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
    //    [lastMonthComps setYear:1]; // year = 1表示1年后的时间 year = -1为1年前的日期，month day 类推
    [lastMonthComps setMonth:Month];
    NSDate *newdate = [calendar dateByAddingComponents:lastMonthComps toDate:currentDate options:0];
    NSString *dateStr = [formatter stringFromDate:newdate];
    return dateStr;
}
+(void)setTody:(NSDate *)date
{
    today = date;
}
@end


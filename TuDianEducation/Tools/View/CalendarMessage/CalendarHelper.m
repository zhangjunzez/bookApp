//
//  CalendarHelper.m
//  tudianjiaoyu
//
//  Created by 张本超 on 2020/4/3.
//  Copyright © 2020 张本超. All rights reserved.
//

#import "CalendarHelper.h"
#import "NSDate+Extension.h"

static NSDate *today = nil;

@implementation CalendarHelper

//根据某一日数据初始化该月数据源
+(NSMutableArray *)createMonthDataInday:(NSString *)dateStr {
  

    NSMutableArray *monthData = [NSMutableArray array];
    NSString *yearStr = [NSString stringWithFormat:@"%ld",[NSDate year:dateStr]];
    NSString *monthStr = [NSString stringWithFormat:@"%ld",[NSDate month:dateStr]];
    NSString *monthStr02 = [NSString stringWithFormat:@"%02ld",[NSDate month:dateStr]];
    //第一天的星期
    NSInteger firstDayWeek = [NSDate week:[NSString stringWithFormat:@"%@-%@-01",yearStr,monthStr]];
    //如果是当前月,"第一天星期几"就以今天的星期为开始
//    if ([NSDate isToday:dateStr]) {
//        firstDayWeek = [NSDate week:dateStr];
//    }
    //这个月的天数
    NSInteger days = [NSDate daysInMonth:dateStr];
    //每天的数字
    for (int i = 0; i < 42; i++) {
        CalendarModel *model = [[CalendarModel alloc] init];
        model.year = yearStr;
        model.month = monthStr;
        model.dayType = Other;
        NSInteger w = i%7;
        if (w ==0) {
            w = 7;
        }
        model.week = [NSString stringWithFormat:@"%ld",w];
        //在第一天之前的格子为空
        if (i < firstDayWeek) {
            model.day = @"";
        } else if ( i > days + firstDayWeek - 1) {
            //最后一天之后的,不添加进数据源
            continue;
        } else {
            //其他的都是有效数据
            model.day = [NSString stringWithFormat:@"%ld", i - firstDayWeek + 1];
            model.date = [NSString stringWithFormat:@"%@-%@-%@",yearStr,monthStr02,[NSString stringWithFormat:@"%02ld", i - firstDayWeek + 1]];
//            //如果是过去的时间,就跳出循环,不添加进数据源
//            if ([NSDate isHistoryTime:model.date]) {
//                continue;
//            }
            //今天明天后天
            if ([NSDate isToday:model.date]) {
                model.dayType = Today;
                //model.isSelected = YES;
                
            } else if ([NSDate isTomorrow:model.date]) {
                model.dayType = Tomorrow;
            } else if ([NSDate isAfterTomorrow:model.date]) {
                model.dayType = AfterTomorrow;
            }
        }
        [monthData addObject:model];
    }
    
    return monthData;
}

+(NSMutableArray *)createMonthDataWith:(NSInteger)index
{
    NSString *dateString = [NSDate nextIndexMonthLastDay:index];
    return [self createMonthDataInday:dateString];
}
+(NSMutableArray *)createMonthDataWith:(NSInteger)index date:(NSDate*)date
{
    NSString *dateString = [NSDate nextIndexMonthLastDay:index date:date];
    return [self createMonthDataInday:dateString];
}
+(NSArray *)weeksName{
    return @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
};
+(NSArray *)weeksFullName
{
   return @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
}
+(NSArray *)timesDurctions
{
    return @[@"8:00-9:00",@"9:00-10:00",@"10:00-11:00",@"11:00-12:00",@"12:00-13:00",@"13:00-14:00",@"14:00-15:00",@"15:00-16:00",@"16:00-17:00",@"17:00-18:00",@"18:00-19:00",@"19:00-20:00",@"20:00-21:00",@"21:00-22:00",@"22:00-23:00",@"23:00-24:00"];
};

+(NSMutableArray *)getDateWeeksDuraingTodayOffset:(NSInteger)Offset
{
    //日历格式
    NSDate *date = today?:[NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:date];
    // 得到：今天是星期几
    // 1(星期天) 2(星期二) 3(星期三) 4(星期四) 5(星期五) 6(星期六) 7(星期天)
    NSInteger weekDay = [comp weekday];
    
    // 计算当前日期和这周的星期一和星期天差的天数
    long firstDiff,lastDiff;
    if (weekDay == 1) {
        firstDiff = -5;
        lastDiff = 2;
    }else{
       
    }
    firstDiff = [calendar firstWeekday] - weekDay;
    lastDiff = 8 - weekDay;
    // 一周日期
    NSMutableArray *dateWeeks = [self getCurrentWeeksWithFirstDiff:firstDiff lastDiff:lastDiff Offset:Offset];
    return dateWeeks;
}
//获取一周时间 数组
+(NSMutableArray *)getCurrentWeeksWithFirstDiff:(NSInteger)first lastDiff:(NSInteger)last Offset:(NSInteger)offset{
    
    NSMutableArray *eightArr = [[NSMutableArray alloc] init];
    NSInteger index = 0;
    for (NSInteger i = first + 1; i < last + 1; i ++) {
        //从现在开始的24小时
        index ++;
        NSTimeInterval secondsPerDay = i * 24*60*60;
        NSTimeInterval offInterval = offset *7*24*60*60;
        NSDate *curDate = [NSDate dateWithTimeIntervalSinceNow:secondsPerDay + offInterval];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateStr = [dateFormatter stringFromDate:curDate];//几月几号
        NSDateFormatter *weekFormatter = [[NSDateFormatter alloc] init];
        [weekFormatter setDateFormat:@"EEEE"];//星期几 @"HH:mm 'on' EEEE MMMM d"];
        //组合时间
        CalendarModel *model = [[CalendarModel alloc]init];
        model.date = dateStr;
        model.week = [NSString stringWithFormat:@"%ld",index];
        //今天明天后天
       if ([NSDate isToday:model.date]) {
          model.dayType = Today;
          model.isSelected = YES;
       } else if ([NSDate isTomorrow:model.date]) {
          model.dayType = Tomorrow;
       } else if ([NSDate isAfterTomorrow:model.date]) {
          model.dayType = AfterTomorrow;
       }
        [eightArr addObject:model];
        
    }
    return eightArr;
}
+(void)setToday:(NSDate *)date
{
    today = date;
}
@end

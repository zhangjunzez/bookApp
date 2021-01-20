//
//  CalendarModel.m
//  tudianjiaoyu
//
//  Created by 张本超 on 2020/4/3.
//  Copyright © 2020 张本超. All rights reserved.
//

#import "CalendarModel.h"
#import "CalendarHelper.h"
@implementation CalendarModel
-(NSString *)weekName{
    if ((_week.integerValue - 1)>=0) {
         return [CalendarHelper weeksFullName][_week.integerValue - 1];
    }
    return @"";
}
@end

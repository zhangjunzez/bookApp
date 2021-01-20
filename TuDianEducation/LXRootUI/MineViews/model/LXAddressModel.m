//
//  LXAddressModel.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/8.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXAddressModel.h"

@implementation LXAddressModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqual:@"id"]) {
        self.addressid = value;
    }
}
-(NSString *)province{
    NSArray *array = [self.province_city_town componentsSeparatedByString:@"_"];
    return array.firstObject;
}
-(NSString *)city{
    NSArray *array = [self.province_city_town componentsSeparatedByString:@"_"];
    return array[1];
}
-(NSString *)area{
    NSArray *array = [self.province_city_town componentsSeparatedByString:@"_"];
    return array.lastObject;
}
@end

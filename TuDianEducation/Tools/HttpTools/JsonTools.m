//
//  JsonTools.m
//  iOSStudy
//
//  Created by chenguandong on 15/2/5.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import "JsonTools.h"

@implementation JsonTools

+(NSDictionary*)getRespnseStr:(NSString*)str{
    NSDictionary *dic =  [JsonTools getJsonNSDictionary:str];
    if ([dic[@"result"] isEqualToString:@"0"]) {
        
        
        
    }else{
        return  nil;
    }
    return nil;
}

+(id)getJsonNSDictionary:(id)jsonString{
//    NSData *data =  [ jsonString  dataUsingEncoding:NSUTF8StringEncoding];
    
   
    //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
    id JsonObjectAll = [NSJSONSerialization JSONObjectWithData:jsonString options:NSJSONReadingMutableLeaves error:nil];
    
    
    return JsonObjectAll;
}
+(NSString*)jsonDicToString:(NSDictionary*)dic{

    //convert object to data
    
    NSError *error;
    
    NSData* jsonData =[NSJSONSerialization dataWithJSONObject:dic
                                                      options:NSJSONWritingPrettyPrinted error:&error];
    
    //print out the data contents
    return [[NSString alloc] initWithData:jsonData
                                          encoding:NSUTF8StringEncoding];
}
@end

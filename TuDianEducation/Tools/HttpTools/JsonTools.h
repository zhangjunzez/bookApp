//
//  JsonTools.h
//  iOSStudy
//
//  Created by chenguandong on 15/2/5.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonTools : NSObject
+(id)getJsonNSDictionary:(id)jsonString;
+(NSString*)jsonDicToString:(NSDictionary*)dic;
@end

//
//  MyUUIDManager.h
//  GameHello
//
//  Created by 大新的电脑 on 2018/7/24.
//  Copyright © 2018年 大點哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyUUIDManager : NSObject

+(void)saveUUID:(NSString *)uuid;

+(NSString *)getUUID;

+(void)deleteUUID;

@end

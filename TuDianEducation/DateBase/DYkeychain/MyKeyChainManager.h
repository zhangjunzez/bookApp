//
//  MyKeyChainManager.h
//  GameHello
//
//  Created by 大新的电脑 on 2018/7/24.
//  Copyright © 2018年 大點哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyKeyChainManager : NSObject

+(NSString *)getDeviceIDInKeychain;

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service;

+ (void)save:(NSString *)service data:(id)data;

+ (id)load:(NSString *)service;

+ (void)delete:(NSString *)service;

@end

//
//  WL_KeyChainStore.h
//  WeiLv
//
//  Created by James on 2017/2/20.
//  Copyright © 2017年 WeiLv Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WL_KeyChainStore : NSObject

+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)deleteKeyData:(NSString *)service;

@end

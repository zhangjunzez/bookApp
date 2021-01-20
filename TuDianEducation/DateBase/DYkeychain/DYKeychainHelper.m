//
//  DYKeychainHelper.m
//  XILAIBANG
//
//  Created by ff on 2019/9/17.
//  Copyright © 2019 大點哥. All rights reserved.
//

#import "DYKeychainHelper.h"
#import "MyKeyChainManager.h"
@implementation DYKeychainHelper

#pragma mark - user for login
+(NSDictionary *)defaultUser {
    NSArray *dataArr = [self allUsers];
    if (dataArr.count != 0) {
        return dataArr.firstObject;
    }
    return @{};
}

+(NSString *)defaultUsername {
    return [self defaultUser].allKeys.firstObject;
}

+(NSDictionary *)defaultUserinfo {
    return [[self defaultUser]objectForKey:[self defaultUsername]];
}


+(NSString *)default_password {
    if ([[[self defaultUser]objectForKey:[self defaultUsername]] objectForKey:@"jgpw"]) {
        return [[[self defaultUser]objectForKey:[self defaultUsername]] objectForKey:@"jgpw"];
    }
    return @"";
}

+(void)setDefault:(NSString *)usersign {
    NSArray *oldArr = [self allUsers];
    NSMutableArray *dataArr = [NSMutableArray arrayWithArray:oldArr];
    if (dataArr.count != 0) {
        for (NSDictionary *dics in oldArr) {
            if ([usersign isEqualToString:dics.allKeys.firstObject]) {
                
                [self addAnUser:usersign info:[dics objectForKey:usersign]];
                return;
            }
        }
    }
}

+(NSArray*)allUsers {
    return [MyKeyChainManager load:@"xlbUser"];
}

+(void)addAnUser:(NSString *)username info:(NSDictionary *)userinfo {
    if (username == nil) {
        // 这个地方是手机刷机后,keychain没有东西了,但是进程入口有首次开启的清token操作
        return;
    }
    NSArray *oldArr = [self allUsers];
    NSMutableArray *dataArr = [NSMutableArray arrayWithArray:oldArr];
    if (dataArr.count != 0) {
        BOOL isrep = 0;
        for (NSDictionary *dics in oldArr) {
            if ([username isEqualToString:dics.allKeys.firstObject]) {
                isrep  = 1;
                NSMutableDictionary *md = [[NSMutableDictionary dictionaryWithDictionary:dics] objectForKey:username];
                [md addEntriesFromDictionary:userinfo];
                [dataArr removeObject:dics];
                [dataArr insertObject:@{username:md} atIndex:0];
            }
        }
        if (isrep == 0) {
            [dataArr insertObject:@{username:userinfo} atIndex:0];
        }
    }else {
        [dataArr addObject:@{username:userinfo}];
    }
    [MyKeyChainManager save:@"xlbUser" data:dataArr];
    DYLog(@"添加user===%@",[self allUsers]);
}

+(void)deleteAnUser:(NSString *)usersign {
    NSArray *oldArr = [self allUsers];
    NSMutableArray *dataArr = [NSMutableArray arrayWithArray:oldArr];
    if (dataArr.count != 0) {
        for (NSDictionary *dics in oldArr) {
            if ([usersign isEqualToString:dics.allKeys.firstObject]) {
                [dataArr removeObject:dics];
            }
        }
    }
    [MyKeyChainManager save:@"xlbUser" data:dataArr];
    DYLog(@"删除user===%@",[self allUsers]);
}

+(void)deleteAllUsers {
    NSArray *dataArr = [self allUsers];
    if (dataArr.count != 0) {
        [MyKeyChainManager delete:@"xlbUser"];
    }
    DYLog(@"删除全部user===%@",[self allUsers]);
}

@end

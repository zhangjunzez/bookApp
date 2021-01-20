//
//  DYKeychainHelper.h
//  XILAIBANG
//
//  Created by ff on 2019/9/17.
//  Copyright © 2019 大點哥. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DYKeychainHelper : NSObject

#pragma mark - user for login
+(NSDictionary *)defaultUser;

+(NSString *)defaultUsername;

+(NSDictionary *)defaultUserinfo;

//+(NSString *)default_password;

+(void)setDefault:(NSString *)usersign;

+(NSArray*)allUsers;

// username= user_9893420394,是极光ID,数字是邦号,这个参数是一旦登录成功就生成的;
+(void)addAnUser:(NSString *)username info:(NSDictionary *)userinfo;

+(void)deleteAnUser:(NSString *)usersign;

+(void)deleteAllUsers;

@end

NS_ASSUME_NONNULL_END

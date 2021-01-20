//
//  DYCodeHelper.h
//  XILAIBANG
//
//  Created by ff on 2019/9/11.
//  Copyright © 2019 大點哥. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DYCodeHelper : NSObject

#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber;

#pragma 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password;

#pragma 正则匹配6位验证码
+ (BOOL)checkVerificationCode : (NSString *) code;

#pragma 正则匹配昵称
+ (BOOL)checkNickname : (NSString *) nickname;
@end

NS_ASSUME_NONNULL_END

//
//  DYCodeHelper.m
//  XILAIBANG
//
//  Created by ff on 2019/9/11.
//  Copyright © 2019 大點哥. All rights reserved.
//

#import "DYCodeHelper.h"

@implementation DYCodeHelper

#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber {
    NSString *pattern = @"^1[3|4|5|7|8|9][0-9]\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;
}

#pragma 正则匹配用户密码8-16位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password {
    NSString *pattern = @"[A-Za-z0-9_]{6,16}";
    //    NSString *pattern = @"[A-Za-z0-9_]{5}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
}

#pragma 正则匹配4-6位验证码
+ (BOOL)checkVerificationCode : (NSString *) code{
//        NSString *pattern = @"(^[0-9]{4,6})";
    NSString *pattern = @"^[0-9]{6}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:code];
    return isMatch;
}

#pragma 正则匹配昵称
+ (BOOL)checkNickname : (NSString *) nickname{
    NSString *pattern = @"^[\u4e00-\u9fa5]{4,8}$";
    //    NSString *pattern = @"^[0-9]{6}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:nickname];
    return isMatch;
}

@end

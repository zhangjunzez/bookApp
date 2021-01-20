//
//  RegularExpression.h
//
//  Created by LS on 16/5/14.
//  Copyright © 2016年 mifengkong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegularExpression : NSObject

/** 邮箱*/
+ (BOOL) validateEmail:(NSString *)email;
/** qq*/
+ (BOOL) validateqq:(NSString *)qq; 
/**固话号码验证*/
+ (BOOL) validateGHMobile:(NSString *)mobile;
/** 手机号码验证*/
+ (BOOL) validateMobile:(NSString *)mobile;
/** 车牌号验证*/
+ (BOOL) validateCarNo:(NSString *)carNo;
/** 车型*/
+ (BOOL) validateCarType:(NSString *)CarType;
/** 用户名*/
+ (BOOL) validateUserName:(NSString *)name;
/** 密码*/
+ (BOOL) validatePassword:(NSString *)passWord;
/** 身份证号*/
+ (BOOL) validateIdentityCard: (NSString *)identityCard;
/** 字符串是否为纯数字*/
+ (BOOL) deptNumInputShouldNumber:(NSString *)str;
/** 字符串是否为整形*/
+ (BOOL) isPureInt:(NSString *)string;
/** 字符串是否为浮点型*/
+ (BOOL) isPureFloat:(NSString *)string;
/** 字符串为数字或字母*/
+ (BOOL) judgePassWordLegal:(NSString *)string;
//
+ (BOOL)deptNumInputShouldSixNumber:(NSString *)str;

@end

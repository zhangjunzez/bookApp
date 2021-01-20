//
//  TDUserDBManager.h
//  TuDianEducation
//
//  Created by zpz on 2020/4/21.
//  Copyright © 2020 郑州大點哥. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TDUserModel;

NS_ASSUME_NONNULL_BEGIN

@interface TDUserDBManager : NSObject
///用户登录状态
+ (BOOL)userIsLogin;

///用户退出登录
+ (void)userLoginOut;

///用户类型
+ (NSString *)userType;

///设置默认数据库
+ (void)setDefaultRealm;

/// 存取当前用户头像
+ (void)setUserHead:(NSData *)data;
+ (NSData *)getUserHead;

/// 存取当前用户头像url
+ (void)setUserHeadURL:(NSString *)data;
+ (NSString *)getUserHeadURL;

/// 存取当前用户手机号
+ (void)setUserPhone:(NSString *)data;
+ (NSString *)getUserPhone;

/// 当前用户是否设置交易密码
+ (void)setUserIsSetTradePwd:(BOOL)bo;
+ (BOOL)getUserIsSetTradePwd;

/// 存取当前用户名
+ (void)setUserName:(NSString *)data;
+ (NSString *)getUserName;

///存取用户信息
+ (void)setUserInfo:(TDUserModel *)data;
+ (TDUserModel *)getUserInfo;


@end

NS_ASSUME_NONNULL_END

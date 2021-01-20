//
//  DYDBUser.h
//  XILAIBANG
//
//  Created by ff on 2019/9/20.
//  Copyright © 2019 大點哥. All rights reserved.
//

#import "RLMObject.h"

NS_ASSUME_NONNULL_BEGIN

@class DYDBUserInfo,DYDBUserIM,DYDBUserExtendData;

@interface DYDBUser : RLMObject
// 用户唯一标识
@property NSString *xlb_uid;
// 首次登录的时间
@property NSString *firstLoginTime;
// 每次登录的时间
@property NSString *updateOnLineTime;
// 每次登录的时间戳(用来判断是否当前用户)
@property NSString *updateOnLineTimeinter;
// accesstoken
@property NSString *access_token;
// frefreshtoken
@property NSString *refresh_token;
// IM登录账号
@property NSString *IM_username;
// IM登录密码
@property NSString *IM_password;



@end

NS_ASSUME_NONNULL_END

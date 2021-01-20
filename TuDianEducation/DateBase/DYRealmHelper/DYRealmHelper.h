//
//  DYRealmHelper.h
//  XILAIBANG
//
//  Created by ff on 2019/9/12.
//  Copyright © 2019 大點哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm.h>
#import "DYDBCreatObj.h"

#import "DYDBUser.h"
#import "DYDBUserInfo.h"
#import "DYDBUserIM_Conversation.h"
#import "DYDBUserIM_Message.h"
#import "DYDBUserIM_Resource.h"
#import "DYDBUserIM_Contact.h"
#import "DYDBUserIM_Group.h"
#import "DYDBUserExtendData.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^DYDBResultBlock)(BOOL isSuccess,id _Nullable obj);

@interface DYRealmHelper : NSObject

#pragma mark - =============设置数据库=================
+(void)DBSet;

#pragma mark - =============user&userinfo=============
#pragma mark - 获取全部用户
+(void)allUsers:(DYDBResultBlock)result;
#pragma mark - 默认user
+(DYDBUser *)defaultUser;
#pragma mark - 默认user基本信息
+(DYDBUserInfo *)defaultUserinfo;
#pragma mark - 默认前台uid
+(NSString *)defaultXlb_UID;
#pragma mark - 默认后台uid
+(NSString *)defaultIM_username;
#pragma mark - 默认IM登录密码
+(NSString *)defaultIM_password;
#pragma mark - 默认AccessToken
+(NSString *)defaultAccessToken;
#pragma mark - 默认RefreshToken
+(NSString *)defaultRefreshToken;
#pragma mark - 刷新token
+(void)newRefreshToken:(nullable NSString *)RefreshToken AccessToken:(nullable NSString *)AccessToken;
#pragma mark - 添加user+基本信息
+(void)addOrUpdateAnUser:(NSString *)uid info:(nonnull NSDictionary *)userinfo result:(DYDBResultBlock)result;
#pragma mark - 更新用户基本信息
+(void)updateUserinfo:(NSString *)uid info:(NSDictionary *)userinfo result:(DYDBResultBlock)result;
//#pragma mark - 删除user
//+(void)deleteAnUser:(NSString *)uid clearAll:(BOOL)isclearAll result:(DYDBResultBlock)result;

#pragma mark - =============花名册================
#pragma mark - 当前user好友花名册列表
+(NSMutableArray *)defaultRosterContactsList;
#pragma mark - 当前user群组花名册列表
+(NSMutableArray *)defaultRosterGroupsList;
#pragma mark - 时间段内好友列表更新
+(void)updateAllContacts:(NSString *)uid info:(nonnull NSArray *)contacts result:(DYDBResultBlock)result;
#pragma mark - 单个好友入库/更新
+(void)addOrUpdateAnContact:(NSString *)unique_id info:(nonnull NSDictionary *)info result:(DYDBResultBlock)result;
#pragma mark - 删除单个好友
+(void)deleteAnContact:(NSString *)unique_id info:(nonnull NSDictionary *)info result:(DYDBResultBlock)result;
#pragma mark - 时间段内群组列表更新
+(void)updateAllGroups:(NSString *)uid info:(nonnull NSArray *)groups result:(DYDBResultBlock)result;
#pragma mark - 单个群组入库/更新
+(void)addOrUpdateAnGroup:(NSString *)unique_id info:(nonnull NSDictionary *)info result:(DYDBResultBlock)result;
#pragma mark - 删除单个群组
+(void)deleteAnGroup:(NSString *)unique_id info:(nonnull NSDictionary *)info result:(DYDBResultBlock)result;

#pragma mark - =============会话================
#pragma mark - 会话消息入库
+(void)addAnMessage:(NSString *)msgId info:(NSDictionary *)info result:(DYDBResultBlock)result;
#pragma mark - 会话消息更新
+(void)updateAnMessage:(NSString *)msgId info:(NSDictionary *)info result:(DYDBResultBlock)result;
#pragma mark - 所有会话
+(NSMutableArray *)defaultConversations;
#pragma mark - 添加/更新一个会话
+(void)addOrUpdateAnConversation:(NSString *)uid targetID:(nullable NSString *)targetID info:(NSDictionary *)info result:(DYDBResultBlock)result;
#pragma mark - 删除一个会话
+(void)deleteAnConversation:(NSString *)uid targetID:(NSString *)targetID result:(DYDBResultBlock)result;
#pragma mark - 某会话所有消息
+(NSMutableArray *)allMessageInAnConversation:(NSString *)uid targetID:(NSString *)targetID;
#pragma mark - 删除一个会话所有消息
+(void)deleteAllMessageOfAnConversation:(NSString *)uid targetID:(NSString *)targetID result:(DYDBResultBlock)result;
#pragma mark - 删除好友-全部相关
+(void)deleteAFriend:(NSString *)uid targetID:(NSString *)targetID result:(DYDBResultBlock)result;
#pragma mark - 删除一条本地消息
+(void)deleteAMessage:(DYDBUserIM_Message *)message result:(DYDBResultBlock)result;
#pragma mark - 添加一个媒体文件
+(void)addAnMedia:(NSString *)mediaId info:(NSDictionary *)info result:(DYDBResultBlock)result;
#pragma mark - 更新一个媒体文件
+(void)updateAnMedia:(NSString *)mediaId info:(NSDictionary *)info result:(DYDBResultBlock)result;
@end

NS_ASSUME_NONNULL_END

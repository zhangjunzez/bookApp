//
//  DYRealmHelper.m
//  XILAIBANG
//
//  Created by ff on 2019/9/12.
//  Copyright © 2019 大點哥. All rights reserved.
//

#import "DYRealmHelper.h"

@interface DYRealmHelper ()

@end

@implementation DYRealmHelper


#pragma mark - =============方便类=============
+(BOOL)hasValue:(NSDictionary *)dic key:(NSString *)key {
    if ([dic valueForKey:key] && ![[dic valueForKey:key]isKindOfClass:[NSNull class]]) {
        return YES;
    }
    return NO;
}

#pragma mark - =============设置数据库=================
+(void)DBSet {
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.fileURL = [[[config.fileURL URLByDeletingLastPathComponent]
                       URLByAppendingPathComponent:@"xlb"] URLByAppendingPathExtension:@"realm"];
    config.schemaVersion = [APP_BUILD longLongValue];
//    config.encryptionKey = [NSData dataWithBytes:"喜来邦" length:64];
//    config.readOnly = NO;
//    config.deleteRealmIfMigrationNeeded = NO;
    config.migrationBlock = ^(RLMMigration * _Nonnull migration, uint64_t oldSchemaVersion) {
//        if (oldSchemaVersion == 1) {
//            [migration enumerateObjects:DYDBUser.className
//                                  block:^(RLMObject *oldObject, RLMObject *newObject) {
////              newObject[@"firstName"] = oldObject[@"name"];
//              newObject[@"currentUser"] = @(0);
//            }];
//        }
    };
    [RLMRealmConfiguration setDefaultConfiguration:config];
    RLMResults <DYDBCreatObj*> *objs = [DYDBCreatObj allObjects];
    if (objs.count==0) {
        DYDBCreatObj *obj = [[DYDBCreatObj alloc]init];
        obj.creatTime = [DYLogicHelper getCurrentTimes];
        RLMRealm *realm = [RLMRealm defaultRealm];
        NSError *error;
        [realm transactionWithBlock:^{
            [realm addObject:obj];
        } error:&error];
        DYLog(@"---%@",error);
    }
    DYLog(@"--%@",[RLMRealmConfiguration defaultConfiguration].fileURL);
}

#pragma mark - =============user&userinfo=============

#pragma mark - 获取全部用户

+(void)allUsers:(DYDBResultBlock)result {
    RLMResults <DYDBUser*> *allUsers = [DYDBUser allObjects];
    DYLog(@"%@",allUsers);
    result(YES,allUsers);
}

#pragma mark - 默认user
+(DYDBUser *)defaultUser {
    RLMResults *result = [DYDBUser allObjects];
    if (result.count!=0) {
        RLMResults *sort = [result sortedResultsUsingKeyPath:@"updateOnLineTimeinter" ascending:NO];
        return sort.firstObject;
        DYLog(@"%@",sort);
    }
    DYLog(@"没user");
    return nil;
}

#pragma mark - 默认user基本信息
+(DYDBUserInfo *)defaultUserinfo {
    return [DYDBUserInfo objectForPrimaryKey:[DYRealmHelper defaultUser].xlb_uid];
}

#pragma mark - 默认前台uid
+(NSString *)defaultXlb_UID {
    DYDBUser *user = [self defaultUser];
    if (!user) {
        return @"";
    }else {
      return user.xlb_uid;
    }
}

#pragma mark - 默认后台uid
+(NSString *)defaultIM_username {
    DYDBUser *user = [self defaultUser];
    if (!user) {
        return @"";
    }else {
      return user.IM_username;
    }
}

#pragma mark - 默认IM登录密码
+(NSString *)defaultIM_password {
    DYDBUser *user = [self defaultUser];
    if (!user) {
        return @"";
    }else {
      return user.IM_password;
    }
}

#pragma mark - 默认AccessToken
+(NSString *)defaultAccessToken {
    DYDBUser *user = [self defaultUser];
    
    if (!user) {
        return @"";
    }else {
      return user.access_token;
    }
}
#pragma mark - 默认RefreshToken
+(NSString *)defaultRefreshToken {
    DYDBUser *user = [self defaultUser];
    if (!user) {
        return @"";
    }else {
      return user.refresh_token;
    }
}

#pragma mark - 刷新token
+(void)newRefreshToken:(nullable NSString *)RefreshToken AccessToken:(nullable NSString *)AccessToken {
    DYDBUser *user = [self defaultUser];
    if (!user) {
        DYLog(@"刷新token-没有这个用户");
    }else {
     RLMRealm *realm = [RLMRealm defaultRealm];
     NSError *error;
     [realm transactionWithBlock:^{
         user.refresh_token = RefreshToken;
         user.access_token = AccessToken;
         [realm addOrUpdateObject:user];
     } error:&error];
     if (!error) {
         DYLog(@"刷新token成功");
     }else {
         DYLog(@"刷新token失败");
     }
    }
}

#pragma mark - 添加user+基本信息
/*
 uid 用户id
 userinfo 用户基本信息
**/
+(void)addOrUpdateAnUser:(NSString *)uid info:(nonnull NSDictionary *)userinfo result:(DYDBResultBlock)result {
    RLMRealm *realm = [RLMRealm defaultRealm];
    DYDBUser *user = [DYDBUser objectForPrimaryKey:uid];
    if (!user) {
        DYDBUser *newUser = [DYDBUser new];
        newUser.xlb_uid = uid;
        newUser.firstLoginTime = newUser.updateOnLineTime = [DYLogicHelper getCurrentTimes];
        newUser.updateOnLineTimeinter = [DYLogicHelper getNowTimestamp];
        if ([self hasValue:userinfo key:@"jg"]==YES) {
            newUser.IM_username = [userinfo valueForKey:@"jg"];
        }else {
            newUser.IM_username = uid;
        }
        if ([self hasValue:userinfo key:@"IM_password"]==YES) {
            newUser.IM_password = [userinfo valueForKey:@"IM_password"];
        }else {
            newUser.IM_password = [NSString stringWithFormat:@"%@",[DYLogicHelper MD5ForLower32Bate:[NSString stringWithFormat:@"%@_123456",uid]]];
        }
        if ([self hasValue:userinfo key:@"access_token"]==YES) {
            newUser.access_token = [userinfo valueForKey:@"access_token"];
        }
        if ([self hasValue:userinfo key:@"refresh_token"]==YES) {
            newUser.refresh_token = [userinfo valueForKey:@"refresh_token"];
        }
        NSError *error;
        [realm transactionWithBlock:^{
            [realm addOrUpdateObject:newUser];
        } error:&error];
        if (!error) {
            DYLog(@"添加新用户成功-%@",uid);
            [self updateUserinfo:uid info:userinfo result:^(BOOL isSuccess, id  _Nullable obj) {
                result(isSuccess,obj);
            }];
        }else {
            DYLog(@"添加新用户失败-%@",error);
            result(NO,nil);
        }
    }else {

        NSError *error;
        [realm transactionWithBlock:^{
            user.updateOnLineTime = [DYLogicHelper getCurrentTimes];
            user.updateOnLineTimeinter = [DYLogicHelper getNowTimestamp];
            if ([self hasValue:userinfo key:@"jg"]==YES) {
                user.IM_username = [userinfo valueForKey:@"jg"];
            }else {
                user.IM_username = uid;
            }
            if ([self hasValue:userinfo key:@"IM_password"]==YES) {
                user.IM_password = [userinfo valueForKey:@"IM_password"];
            }else {
                user.IM_password = [NSString stringWithFormat:@"%@",[DYLogicHelper MD5ForLower32Bate:[NSString stringWithFormat:@"%@_123456",uid]]];
            }
            if ([self hasValue:userinfo key:@"access_token"]==YES) {
                user.access_token = [userinfo valueForKey:@"access_token"];
            }
            if ([self hasValue:userinfo key:@"refresh_token"]==YES) {
                user.refresh_token = [userinfo valueForKey:@"refresh_token"];
            }
        } error:&error];
        if (!error) {
            DYLog(@"老用户更新成功-%@",uid);
            [self updateUserinfo:uid info:userinfo result:^(BOOL isSuccess, id  _Nullable obj) {
                result(isSuccess,obj);
            }];
        }else {
            DYLog(@"老用户更新失败-%@",error);
            result(NO,nil);
        }
    }
    
}

#pragma mark - 更新用户信息
/*
 uid 主键
 userinfo 信息
 **/
+(void)updateUserinfo:(NSString *)uid info:(NSDictionary *)userinfo result:(DYDBResultBlock)result{
    RLMRealm *realm = [RLMRealm defaultRealm];
    DYDBUserInfo *info = [DYDBUserInfo objectForPrimaryKey:uid];
    if (!info) {
        DYDBUserInfo *newInfo = [DYDBUserInfo new];
        newInfo.xlb_uid = uid;
        if ([self hasValue:userinfo key:@"username"]==YES) {
            newInfo.username = [userinfo valueForKey:@"username"];
        }
        if ([self hasValue:userinfo key:@"unique_id"]==YES) {
            newInfo.unique_id = [userinfo valueForKey:@"unique_id"];
        }
        if ([self hasValue:userinfo key:@"picture"]==YES) {
            newInfo.picture = [userinfo valueForKey:@"picture"];
        }
        if ([self hasValue:userinfo key:@"nickname"]==YES) {
            newInfo.nickname = [userinfo valueForKey:@"nickname"];
        }
        if ([self hasValue:userinfo key:@"phone"]==YES) {
            newInfo.phone = [userinfo valueForKey:@"phone"];
        }
        if ([self hasValue:userinfo key:@"gender"]==YES) {
            newInfo.gender = @([[userinfo valueForKey:@"gender"] intValue]);
        }
        if ([self hasValue:userinfo key:@"age"]==YES) {
            newInfo.age = @([[userinfo valueForKey:@"age"] intValue]);
        }
        if ([self hasValue:userinfo key:@"birthday"]==YES) {
            newInfo.birthday = [userinfo valueForKey:@"birthday"];
        }
        if ([self hasValue:userinfo key:@"sign_text"]==YES) {
            newInfo.sign_text = [userinfo valueForKey:@"sign_text"];
        }
        if ([self hasValue:userinfo key:@"province"]==YES) {
            newInfo.province = [userinfo valueForKey:@"province"];
        }
        if ([self hasValue:userinfo key:@"city"]==YES) {
            newInfo.city = [userinfo valueForKey:@"city"];
        }
        if ([self hasValue:userinfo key:@"district"]==YES) {
            newInfo.district = [userinfo valueForKey:@"district"];
        }
        if ([self hasValue:userinfo key:@"address"]==YES) {
            newInfo.address = [userinfo valueForKey:@"address"];
        }
        if ([self hasValue:userinfo key:@"isEdit"]==YES) {
            bool a = [[userinfo valueForKey:@"isEdit"] boolValue];
            newInfo.isEdit = @(a);
        }
        if ([self hasValue:userinfo key:@"has_payword"]==YES) {
            newInfo.has_payword = @([[userinfo valueForKey:@"has_payword"] boolValue]);
        }
        if ([self hasValue:userinfo key:@"tjcode"]==YES) {
            newInfo.tjCode = [userinfo valueForKey:@"tjcode"];
        }
        if ([self hasValue:userinfo key:@"tj_link"]==YES) {
            newInfo.tj_link = [userinfo valueForKey:@"tj_link"];
        }
        if ([self hasValue:userinfo key:@"lecturers"]==YES) {
            newInfo.lecturers = @([[userinfo valueForKey:@"lecturers"] boolValue]);
        }
        if ([self hasValue:userinfo key:@"lecturers_lv"]==YES) {
            newInfo.lecturers_lv = @([[userinfo valueForKey:@"lecturers_lv"] intValue]);
        }
        if ([self hasValue:userinfo key:@"lecturers_nameplate"]==YES) {
            newInfo.lecturers_nameplate = @([[userinfo valueForKey:@"lecturers_nameplate"] boolValue]);
        }
        if ([self hasValue:userinfo key:@"salesman_vip"]==YES) {
            newInfo.salesman_vip = @([[userinfo valueForKey:@"salesman_vip"] boolValue]);
        }
        if ([self hasValue:userinfo key:@"orchard_url"]==YES) {
            newInfo.orchard_url = [userinfo valueForKey:@"orchard_url"];
        }
        newInfo.font = @(1.0f);
        newInfo.chatUnreadCount = @"0";
        newInfo.rosterUnreadCount = @"0";
        [[NSUserDefaults standardUserDefaults]setValue:@(1.0) forKey:@"DYFont"];
        newInfo.contactListUpdateTimeInterival = @"0";
        newInfo.groupListUpdateTimeInterival = @"0";
        NSError *error;
        [realm transactionWithBlock:^{
            [realm addOrUpdateObject:newInfo];
        } error:&error];
        if (!error) {
            DYLog(@"userinfo添加成功-%@",newInfo);
            result(YES,newInfo);
        }else {
            DYLog(@"userinfo添加失败-%@",error);
            result(NO,nil);
        }
    }else {
        NSError *error;
        [realm transactionWithBlock:^{
            if ([self hasValue:userinfo key:@"username"]==YES) {
                info.username = [userinfo valueForKey:@"username"];
            }
            if ([self hasValue:userinfo key:@"unique_id"]==YES) {
                info.unique_id = [userinfo valueForKey:@"unique_id"];
            }
            if ([self hasValue:userinfo key:@"picture"]==YES) {
                info.picture = [userinfo valueForKey:@"picture"];
            }
            if ([self hasValue:userinfo key:@"nickname"]==YES) {
                info.nickname = [userinfo valueForKey:@"nickname"];
            }
            if ([self hasValue:userinfo key:@"phone"]==YES) {
                info.phone = [userinfo valueForKey:@"phone"];
            }
            if ([self hasValue:userinfo key:@"gender"]==YES) {
                info.gender = @([[userinfo valueForKey:@"gender"] intValue]);
            }
            if ([self hasValue:userinfo key:@"age"]==YES) {
                info.age = @([[userinfo valueForKey:@"age"] intValue]);
            }
            if ([self hasValue:userinfo key:@"birthday"]==YES) {
                info.birthday = [userinfo valueForKey:@"birthday"];
            }
            if ([self hasValue:userinfo key:@"sign_text"]==YES) {
                info.sign_text = [userinfo valueForKey:@"sign_text"];
            }
            if ([self hasValue:userinfo key:@"province"]==YES) {
                info.province = [userinfo valueForKey:@"province"];
            }
            if ([self hasValue:userinfo key:@"city"]==YES) {
                info.city = [userinfo valueForKey:@"city"];
            }
            if ([self hasValue:userinfo key:@"district"]==YES) {
                info.district = [userinfo valueForKey:@"district"];
            }
            if ([self hasValue:userinfo key:@"address"]==YES) {
                info.address = [userinfo valueForKey:@"address"];
            }
            if (([self hasValue:userinfo key:@"isEdit"]==YES)) {
                info.isEdit = @([[userinfo valueForKey:@"isEdit"] boolValue]);
            }
            if ([self hasValue:userinfo key:@"need_edit"]==YES) {
                info.isEdit = @([[userinfo valueForKey:@"need_edit"] boolValue]);
            }
            if ([self hasValue:userinfo key:@"has_payword"]==YES) {
                info.has_payword = @([[userinfo valueForKey:@"has_payword"] boolValue]);
            }
            if ([self hasValue:userinfo key:@"tjcode"]==YES) {
                info.tjCode = [userinfo valueForKey:@"tjcode"];
            }
            if ([self hasValue:userinfo key:@"tj_link"]==YES) {
                info.tj_link = [userinfo valueForKey:@"tj_link"];
            }
            if ([self hasValue:userinfo key:@"lecturers"]==YES) {
                info.lecturers = @([[userinfo valueForKey:@"lecturers"] boolValue]);
            }
            if ([self hasValue:userinfo key:@"lecturers_lv"]==YES) {
                info.lecturers_lv = @([[userinfo valueForKey:@"lecturers_lv"] intValue]);
            }
            if ([self hasValue:userinfo key:@"lecturers_nameplate"]==YES) {
                info.lecturers_nameplate = @([[userinfo valueForKey:@"lecturers_nameplate"] boolValue]);
            }
            if ([self hasValue:userinfo key:@"salesman_vip"]==YES) {
                info.salesman_vip = @([[userinfo valueForKey:@"salesman_vip"] boolValue]);
            }
            if ([self hasValue:userinfo key:@"orchard_url"]==YES) {
                info.orchard_url = [userinfo valueForKey:@"orchard_url"];
            }
            
            if ([self hasValue:userinfo key:@"font"]==YES) {
                info.font = @([[userinfo valueForKey:@"font"] doubleValue]);
                [[NSUserDefaults standardUserDefaults]setValue:@([[userinfo valueForKey:@"font"] doubleValue]) forKey:@"DYFont"];
            }
            if ([self hasValue:userinfo key:CHAT_UNREAD_COUNT]==YES) {
                NSUInteger count = [[userinfo valueForKey:CHAT_UNREAD_COUNT] intValue];
                DYApplication.applicationIconBadgeNumber = count;
//                [JMessage setBadge:DYApplication.applicationIconBadgeNumber];
                info.chatUnreadCount = [NSString stringWithFormat:@"%ld",count];
            }
            if ([self hasValue:userinfo key:ROSTER_UNREAD_COUNT]==YES) {
                int count = [[userinfo valueForKey:ROSTER_UNREAD_COUNT] intValue];
                int oldcount = [info.rosterUnreadCount intValue];
                DYApplication.applicationIconBadgeNumber =DYApplication.applicationIconBadgeNumber+count;
//                [JMessage setBadge:DYApplication.applicationIconBadgeNumber];
                info.rosterUnreadCount = [NSString stringWithFormat:@"%d",oldcount+count];
//                DYLog(@"yyy~realmhelper~%d-%d",count,oldcount);
            }
            if ([self hasValue:userinfo key:@"contactListUpdateTimeInterival"]==YES) {
                info.contactListUpdateTimeInterival = [userinfo valueForKey:@"contactListUpdateTimeInterival"];
            }
            if ([self hasValue:userinfo key:@"groupListUpdateTimeInterival"]==YES) {
                info.groupListUpdateTimeInterival = [userinfo valueForKey:@"groupListUpdateTimeInterival"];
            }
            
        } error:&error];
        if (!error) {
//            DYLog(@"userinfo更新成功-%@",info);
            result(YES,info);
        }else {
            DYLog(@"userinfo更新失败-%@",error);
            result(NO,nil);
        }
    }
}

//#pragma mark - 删除user
//+(void)deleteAnUser:(NSString *)uid clearAll:(BOOL)isclearAll result:(DYDBResultBlock)result{
//
//}

#pragma mark - =============花名册================

#pragma mark - 当前user好友花名册列表
+(NSMutableArray *)defaultRosterContactsList{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    RLMResults <DYDBUserIM_Contact *>*results = [DYDBUserIM_Contact objectsWhere:[NSString stringWithFormat:@"xlb_uid = '%@' AND status = 2",[self defaultXlb_UID]]];
    for (DYDBUserIM_Contact *contact in results) {
        [arr addObject:contact];
    }
    return arr;
}

#pragma mark - 时间段内好友列表更新
+(void)updateAllContacts:(NSString *)uid info:(nonnull NSArray *)contacts result:(DYDBResultBlock)result {
    if (contacts.count==0) {
        result(YES,[self defaultRosterContactsList]);
    }else {
        NSError *erro;
        RLMRealm *realms = [RLMRealm defaultRealm];
        [realms transactionWithBlock:^{
            NSString *dfUser = [DYRealmHelper defaultXlb_UID];
            for (NSDictionary *dic in contacts) {
                DYDBUserIM_Contact *oldContact = [DYDBUserIM_Contact objectForPrimaryKey:[NSString stringWithFormat:@"%@%@",dfUser,[dic valueForKey:@"unique_id"]]];
                if (oldContact != nil && [oldContact.xlb_uid isEqualToString:uid]) {
                    oldContact.DYUsersID = [NSString stringWithFormat:@"%@%@",uid,[dic valueForKey:@"unique_id"]];
                    oldContact.xlb_uid = uid;
                    
                    if ([self hasValue:dic key:@"unique_id"]==YES) {
                        oldContact.unique_id = [dic valueForKey:@"unique_id"];
                    }
                    if ([self hasValue:dic key:@"age"]==YES) {
                        oldContact.age = @([[dic valueForKey:@"age"]intValue]);
                    }
                    if ([self hasValue:dic key:@"background_id"]==YES) {
                        oldContact.background_id = [dic valueForKey:@"background_id"];
                    }
                    if ([self hasValue:dic key:@"gender"]==YES) {
                        oldContact.gender = @([[dic valueForKey:@"gender"] intValue]);
                    }
                    if ([self hasValue:dic key:@"is_new"]==YES) {
                        oldContact.is_new = @([[dic valueForKey:@"is_new"] boolValue]);
                    }
                    if ([self hasValue:dic key:@"is_quiet"]==YES) {
                        oldContact.is_quiet = @([[dic valueForKey:@"is_quiet"] boolValue]);
                    }
                    if ([self hasValue:dic key:@"is_sys"]==YES) {
                        oldContact.is_sys = @([[dic valueForKey:@"is_sys"] boolValue]);
                    }
                    if ([self hasValue:dic key:@"nickname"]==YES) {
                        oldContact.nickname = [dic valueForKey:@"nickname"];
                    }
                    if ([self hasValue:dic key:@"phone"]==YES) {
                        oldContact.phone = [dic valueForKey:@"phone"];
                    }
                    if ([self hasValue:dic key:@"picture"]==YES) {
                        if ([[dic valueForKey:@"picture"]isKindOfClass:[NSString class]]) {
                            oldContact.picture = [NSData dataWithContentsOfURL:[NSURL URLWithString:[dic valueForKey:@"picture"]]];
                            oldContact.pictureUrl = [dic valueForKey:@"picture"];
                        }else if ([[dic valueForKey:@"picture"]isKindOfClass:[NSData class]]){
                            oldContact.picture = [dic valueForKey:@"picture"];
                            
                        }
                    }
                    if ([self hasValue:dic key:@"remarks"]==YES) {
                        oldContact.remarks = [dic valueForKey:@"remarks"];
                    }
                    if ([self hasValue:dic key:@"sign_text"]==YES) {
                        oldContact.sign_text = [dic valueForKey:@"sign_text"];
                    }
                    if ([self hasValue:dic key:@"status"]==YES) {
                        oldContact.status = @([[dic valueForKey:@"status"]intValue]);
                    }
                    if ([self hasValue:dic key:@"tag_name"]==YES) {
                        oldContact.tag_name = [dic valueForKey:@"tag_name"];
                    }
                    if ([self hasValue:dic key:@"uid"]==YES) {
                        oldContact.uid = [NSString stringWithFormat:@"%@",[dic valueForKey:@"uid"]];
                    }
                    if ([self hasValue:dic key:@"update_time"]==YES) {
                        oldContact.update_time = @([[dic valueForKey:@"update_time"]intValue]);
                    }
                    if ([self hasValue:dic key:@"username"]==YES) {
                        oldContact.username = [dic valueForKey:@"username"];
                    }
                    if ([self hasValue:dic key:@"from_way"]==YES) {
                        oldContact.from_way = @([[dic valueForKey:@"from_way"]intValue]);
                    }
                    if ([self hasValue:dic key:@"pictureUrl"]==YES) {
                        oldContact.pictureUrl = [dic valueForKey:@"pictureUrl"];
                    }
                    [realms addOrUpdateObject:oldContact];
                }else {
                    DYDBUserIM_Contact *contact = [DYDBUserIM_Contact new];
                    contact.DYUsersID = [NSString stringWithFormat:@"%@%@",uid,[dic valueForKey:@"unique_id"]];
                    contact.xlb_uid = uid;
                    if ([self hasValue:dic key:@"unique_id"]==YES) {
                        contact.unique_id = [dic valueForKey:@"unique_id"];
                    }
                    if ([self hasValue:dic key:@"age"]==YES) {
                        contact.age = @([[dic valueForKey:@"age"]intValue]);
                    }
                    if ([self hasValue:dic key:@"background_id"]==YES) {
                        contact.background_id = [dic valueForKey:@"background_id"];
                    }
                    if ([self hasValue:dic key:@"gender"]==YES) {
                        contact.gender = @([[dic valueForKey:@"gender"] intValue]);
                    }
                    if ([self hasValue:dic key:@"is_new"]==YES) {
                        contact.is_new = @([[dic valueForKey:@"is_new"] boolValue]);
                    }
                    if ([self hasValue:dic key:@"is_quiet"]==YES) {
                        contact.is_quiet = @([[dic valueForKey:@"is_quiet"] boolValue]);
                    }
                    if ([self hasValue:dic key:@"is_sys"]==YES) {
                        contact.is_sys = @([[dic valueForKey:@"is_sys"] boolValue]);
                    }
                    if ([self hasValue:dic key:@"nickname"]==YES) {
                        contact.nickname = [dic valueForKey:@"nickname"];
                    }
                    if ([self hasValue:dic key:@"phone"]==YES) {
                        contact.phone = [dic valueForKey:@"phone"];
                    }
                    if ([self hasValue:dic key:@"picture"]==YES) {
                        if ([[dic valueForKey:@"picture"]isKindOfClass:[NSString class]]) {
                            contact.picture = [NSData dataWithContentsOfURL:[NSURL URLWithString:[dic valueForKey:@"picture"]]];
                            contact.pictureUrl = [dic valueForKey:@"picture"];
                        }else if ([[dic valueForKey:@"picture"]isKindOfClass:[NSData class]]){
                            contact.picture = [dic valueForKey:@"picture"];
                        }
                    }
                    if ([self hasValue:dic key:@"remarks"]==YES) {
                        contact.remarks = [dic valueForKey:@"remarks"];
                    }
                    if ([self hasValue:dic key:@"sign_text"]==YES) {
                        contact.sign_text = [dic valueForKey:@"sign_text"];
                    }
                    if ([self hasValue:dic key:@"status"]==YES) {
                        contact.status = @([[dic valueForKey:@"status"]intValue]);
                    }
                    if ([self hasValue:dic key:@"tag_name"]==YES) {
                        contact.tag_name = [dic valueForKey:@"tag_name"];
                    }
                    if ([self hasValue:dic key:@"uid"]==YES) {
                        contact.uid = [NSString stringWithFormat:@"%@",[dic valueForKey:@"uid"]];
                    }
                    if ([self hasValue:dic key:@"update_time"]==YES) {
                        contact.update_time = @([[dic valueForKey:@"update_time"]intValue]);
                    }
                    if ([self hasValue:dic key:@"username"]==YES) {
                        contact.username = [dic valueForKey:@"username"];
                    }
                    if ([self hasValue:dic key:@"from_way"]==YES) {
                        contact.from_way = @([[dic valueForKey:@"from_way"]intValue]);
                    }
                    if ([self hasValue:dic key:@"pictureUrl"]==YES) {
                        contact.pictureUrl = [dic valueForKey:@"pictureUrl"];
                    }
                    [realms addObject:contact];
                }
                
            }
        } error:&erro];
        if (!erro) {
            DYLog(@"花名册-好友列表,新数据刷新成功,返回新数据");
            result(YES,[self defaultRosterContactsList]);
        }else {
            DYLog(@"花名册-好友列表,新数据刷新失败,返回空数据");
            result(NO,[self defaultRosterContactsList]);
        }
    }
}
#pragma mark - 单个好友入库/更新
+(void)addOrUpdateAnContact:(NSString *)unique_id info:(nonnull NSDictionary *)info result:(DYDBResultBlock)result {
    
    RLMResults<DYDBUserIM_Contact *> *contactResult = [DYDBUserIM_Contact objectsWhere:[NSString stringWithFormat:@"xlb_uid = '%@' AND unique_id = '%@'",[self defaultXlb_UID],unique_id]];
    RLMRealm *realms = [RLMRealm defaultRealm];
    NSError *error;
    if (contactResult.count == 0) {
        [realms transactionWithBlock:^{
            DYDBUserIM_Contact *contact = [DYDBUserIM_Contact new];
            contact.DYUsersID = [NSString stringWithFormat:@"%@%@",[self defaultXlb_UID],[info valueForKey:@"unique_id"]];
            contact.xlb_uid = [self defaultXlb_UID];
            if ([self hasValue:info key:@"unique_id"]==YES) {
                contact.unique_id = [info valueForKey:@"unique_id"];
            }
            if ([self hasValue:info key:@"age"]==YES) {
                contact.age = @([[info valueForKey:@"age"]intValue]);
            }
            if ([self hasValue:info key:@"background_id"]==YES) {
                contact.background_id = [info valueForKey:@"background_id"];
            }
            if ([self hasValue:info key:@"gender"]==YES) {
                contact.gender = @([[info valueForKey:@"gender"] intValue]);
            }
            if ([self hasValue:info key:@"is_new"]==YES) {
                contact.is_new = @([[info valueForKey:@"is_new"] boolValue]);
            }
            if ([self hasValue:info key:@"is_quiet"]==YES) {
                contact.is_quiet = @([[info valueForKey:@"is_quiet"] boolValue]);
            }
            if ([self hasValue:info key:@"is_sys"]==YES) {
                contact.is_sys = @([[info valueForKey:@"is_sys"] boolValue]);
            }
            if ([self hasValue:info key:@"nickname"]==YES) {
                contact.nickname = [info valueForKey:@"nickname"];
            }
            if ([self hasValue:info key:@"phone"]==YES) {
                contact.phone = [info valueForKey:@"phone"];
            }
            if ([self hasValue:info key:@"picture"]==YES) {
                if ([[info valueForKey:@"picture"]isKindOfClass:[NSString class]]) {
                    contact.picture = [NSData dataWithContentsOfURL:[NSURL URLWithString:[info valueForKey:@"picture"]]];
                    contact.pictureUrl = [info valueForKey:@"picture"];
                }else if ([[info valueForKey:@"picture"]isKindOfClass:[NSData class]]){
                    contact.picture = [info valueForKey:@"picture"];
                }
            }
            if ([self hasValue:info key:@"remarks"]==YES) {
                contact.remarks = [info valueForKey:@"remarks"];
            }
            if ([self hasValue:info key:@"sign_text"]==YES) {
                contact.sign_text = [info valueForKey:@"sign_text"];
            }
            if ([self hasValue:info key:@"status"]==YES) {
                contact.status = @([[info valueForKey:@"status"]intValue]);
            }
            if ([self hasValue:info key:@"tag_name"]==YES) {
                contact.tag_name = [info valueForKey:@"tag_name"];
            }
            if ([self hasValue:info key:@"uid"]==YES) {
                contact.uid = [NSString stringWithFormat:@"%@",[info valueForKey:@"uid"]];
            }
            if ([self hasValue:info key:@"update_time"]==YES) {
                contact.update_time = @([[info valueForKey:@"update_time"]intValue]);
            }
            if ([self hasValue:info key:@"username"]==YES) {
                contact.username = [info valueForKey:@"username"];
            }
            if ([self hasValue:info key:@"from_way"]==YES) {
                contact.from_way = @([[info valueForKey:@"from_way"]intValue]);
            }
            if ([self hasValue:info key:@"pictureUrl"]==YES) {
                contact.pictureUrl = [info valueForKey:@"pictureUrl"];
            }
            [realms addObject:contact];
        } error:&error];
        if (!error) {
            DYLog(@"花名册-添加新好友成功");
            result(YES,nil);
        }else {
            DYLog(@"花名册-添加新好友失败");
            result(NO,nil);
        }
    }else {
        DYDBUserIM_Contact *contact = contactResult.firstObject;
        
        [realms transactionWithBlock:^{
//            contact.DYUsersID = [NSString stringWithFormat:@"%@%@",[self defaultXlb_UID],[info valueForKey:@"unique_id"]];
//            contact.xlb_uid = [self defaultXlb_UID];
            if ([self hasValue:info key:@"unique_id"]==YES) {
                contact.unique_id = [info valueForKey:@"unique_id"];
            }
            if ([self hasValue:info key:@"age"]==YES) {
                contact.age = @([[info valueForKey:@"age"]intValue]);
            }
            if ([self hasValue:info key:@"background_id"]==YES) {
                contact.background_id = [info valueForKey:@"background_id"];
            }
            if ([self hasValue:info key:@"gender"]==YES) {
                contact.gender = @([[info valueForKey:@"gender"] intValue]);
            }
            if ([self hasValue:info key:@"is_new"]==YES) {
                contact.is_new = @([[info valueForKey:@"is_new"] boolValue]);
            }
            if ([self hasValue:info key:@"is_quiet"]==YES) {
                contact.is_quiet = @([[info valueForKey:@"is_quiet"] boolValue]);
            }
            if ([self hasValue:info key:@"is_sys"]==YES) {
                contact.is_sys = @([[info valueForKey:@"is_sys"] boolValue]);
            }
            if ([self hasValue:info key:@"nickname"]==YES) {
                contact.nickname = [info valueForKey:@"nickname"];
            }
            if ([self hasValue:info key:@"phone"]==YES) {
                contact.phone = [info valueForKey:@"phone"];
            }
            if ([self hasValue:info key:@"picture"]==YES) {
                if ([[info valueForKey:@"picture"]isKindOfClass:[NSString class]]) {
                    contact.picture = [NSData dataWithContentsOfURL:[NSURL URLWithString:[info valueForKey:@"picture"]]];
                    contact.pictureUrl = [info valueForKey:@"picture"];
                }else if ([[info valueForKey:@"picture"]isKindOfClass:[NSData class]]){
                    contact.picture = [info valueForKey:@"picture"];
                }
            }
            if ([self hasValue:info key:@"remarks"]==YES) {
                contact.remarks = [info valueForKey:@"remarks"];
            }
            if ([self hasValue:info key:@"sign_text"]==YES) {
                contact.sign_text = [info valueForKey:@"sign_text"];
            }
            if ([self hasValue:info key:@"status"]==YES) {
                contact.status = @([[info valueForKey:@"status"]intValue]);
            }
            if ([self hasValue:info key:@"tag_name"]==YES) {
                contact.tag_name = [info valueForKey:@"tag_name"];
            }
            if ([self hasValue:info key:@"uid"]==YES) {
                contact.uid = [NSString stringWithFormat:@"%@",[info valueForKey:@"uid"]];
            }
            if ([self hasValue:info key:@"update_time"]==YES) {
                contact.update_time = @([[info valueForKey:@"update_time"]intValue]);
            }
            if ([self hasValue:info key:@"username"]==YES) {
                contact.username = [info valueForKey:@"username"];
            }
            if ([self hasValue:info key:@"from_way"]==YES) {
                contact.from_way = @([[info valueForKey:@"from_way"]intValue]);
            }
            if ([self hasValue:info key:@"pictureUrl"]==YES) {
                contact.pictureUrl = [info valueForKey:@"pictureUrl"];
            }
            [realms addOrUpdateObject:contact];
        } error:&error];
        if (!error) {
            DYLog(@"花名册-更新好友成功");
            result(YES,nil);
        }else {
            DYLog(@"花名册-更新好友失败");
            result(NO,nil);
        }
    }
}
#pragma mark - 删除单个好友
+(void)deleteAnContact:(NSString *)unique_id info:(nonnull NSDictionary *)info result:(DYDBResultBlock)result {
    RLMResults<DYDBUserIM_Contact *> *contactResult = [DYDBUserIM_Contact objectsWhere:[NSString stringWithFormat:@"xlb_uid = '%@' AND unique_id = '%@'",[self defaultXlb_UID],unique_id]];
    RLMRealm *realms = [RLMRealm defaultRealm];
    NSError *error;
    if (contactResult.count != 0) {
        DYDBUserIM_Contact *contact = contactResult[0];
        [realms transactionWithBlock:^{
            [realms deleteObject:contact];
        } error:&error];
        if (!error) {
            DYLog(@"花名册-删除好友成功");
            result(YES,nil);
        }else {
            DYLog(@"花名册-删除好友失败");
            result(NO,nil);
        }
    }else {
        DYLog(@"花名册-删除好友-没有这个人");
        result(NO,nil);
    }
}

#pragma mark - 当前user群组花名册列表
+(NSMutableArray *)defaultRosterGroupsList{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    RLMResults <DYDBUserIM_Group *>*results = [DYDBUserIM_Group objectsWhere:[NSString stringWithFormat:@"xlb_uid = '%@'",[self defaultXlb_UID]]];
    for (DYDBUserIM_Group *group in results) {
        [arr addObject:group];
    }
    return arr;
}

#pragma mark - 时间段内群组列表更新
+(void)updateAllGroups:(NSString *)uid info:(nonnull NSArray *)groups result:(DYDBResultBlock)result {
        if (groups.count==0) {
            result(YES,[self defaultRosterContactsList]);
        }else {
            NSError *erro;
            RLMRealm *realms = [RLMRealm defaultRealm];
            [realms transactionWithBlock:^{
                for (NSDictionary *dic in groups) {
                    DYDBUserIM_Group *oldGroup = [DYDBUserIM_Group objectForPrimaryKey:[NSString stringWithFormat:@"%@%@",uid,[dic valueForKey:@"unique_id"]]];
                    if (oldGroup != nil && [oldGroup.xlb_uid isEqualToString:uid]) {
                        oldGroup.xlb_uid = uid;
//                        if ([self hasValue:dic key:@"background_id"]==YES) {
//                            oldGroup.background_id = [dic valueForKey:@"background_id"];
//                        }
                        if ([self hasValue:dic key:@"unique_id"]==YES) {
                            oldGroup.unique_id = [dic valueForKey:@"unique_id"];
                        }
                        if ([self hasValue:dic key:@"chatroom_id"]==YES) {
                            oldGroup.chatroom_id = [dic valueForKey:@"chatroom_id"];
                        }
                        if ([self hasValue:dic key:@"g_is_label"]==YES) {
                            oldGroup.g_is_label = @([[dic valueForKey:@"g_is_label"] boolValue]);
                        }
                        if ([self hasValue:dic key:@"group_id"]==YES) {
                            oldGroup.group_id = [dic valueForKey:@"group_id"];
                        }
                        if ([self hasValue:dic key:@"group_name"]==YES) {
                            oldGroup.group_name = [dic valueForKey:@"group_name"];
                        }
                        if ([self hasValue:dic key:@"id"]==YES) {
                            oldGroup.id = [dic valueForKey:@"id"];
                        }
                        if ([self hasValue:dic key:@"is_anonymous"]==YES) {
                            oldGroup.is_anonymous = @([[dic valueForKey:@"is_anonymous"]boolValue]);
                        }
                        if ([self hasValue:dic key:@"is_forbid"]==YES) {
                            oldGroup.is_forbid = @([[dic valueForKey:@"is_forbid"] boolValue]);
                        }
                        if ([self hasValue:dic key:@"is_label"]==YES) {
                            oldGroup.is_label = @([[dic valueForKey:@"is_label"] intValue]);
                        }
                        if ([self hasValue:dic key:@"is_manager"]==YES) {
                            oldGroup.is_manager = @([[dic valueForKey:@"is_manager"] boolValue]);
                        }
                        if ([self hasValue:dic key:@"is_open_business_card"]==YES) {
                            oldGroup.is_open_business_card = @([[dic valueForKey:@"is_open_business_card"] boolValue]);
                        }
                        if ([self hasValue:dic key:@"is_owner"]==YES) {
                            oldGroup.is_owner = @([[dic valueForKey:@"is_owner"]boolValue]);
                        }
                        if ([self hasValue:dic key:@"need_audit_label"]==YES) {
                            oldGroup.need_audit_label = @([[dic valueForKey:@"need_audit_label"] boolValue]);
                        }
                        if ([self hasValue:dic key:@"picture"]==YES) {
                            if ([[dic valueForKey:@"picture"]isKindOfClass:[NSString class]]) {
                                oldGroup.picture = [NSData dataWithContentsOfURL:[NSURL URLWithString:[dic valueForKey:@"picture"]]];
                                oldGroup.pictureUrl = [dic valueForKey:@"picture"];
                            }else if ([[dic valueForKey:@"picture"]isKindOfClass:[NSData class]]){
                                oldGroup.picture = [dic valueForKey:@"picture"];
                            }
                        }
                        if ([self hasValue:dic key:@"screenshots_to_inform"]==YES) {
                            oldGroup.screenshots_to_inform = @([[dic valueForKey:@"screenshots_to_inform"] boolValue]);
                        }
                        if ([self hasValue:dic key:@"pictureUrl"]==YES) {
                            oldGroup.pictureUrl = [dic valueForKey:@"pictureUrl"];
                        }
                        [realms addOrUpdateObject:oldGroup];
                    }else {
                        DYDBUserIM_Group *group = [DYDBUserIM_Group new];
                        group.DYUsersID = [NSString stringWithFormat:@"%@%@",uid,[dic valueForKey:@"unique_id"]];
                        group.xlb_uid = uid;
                        if ([self hasValue:dic key:@"background_id"]==YES) {
                            group.background_id = [dic valueForKey:@"background_id"];
                        }
                        if ([self hasValue:dic key:@"unique_id"]==YES) {
                            group.unique_id = [dic valueForKey:@"unique_id"];
                        }
                        if ([self hasValue:dic key:@"chatroom_id"]==YES) {
                            group.chatroom_id = [dic valueForKey:@"chatroom_id"];
                        }
                        
                        if ([self hasValue:dic key:@"g_is_label"]==YES) {
                            group.g_is_label = @([[dic valueForKey:@"g_is_label"] boolValue]);
                        }
                        if ([self hasValue:dic key:@"group_id"]==YES) {
                            group.group_id = [dic valueForKey:@"group_id"];
                        }
                        if ([self hasValue:dic key:@"group_name"]==YES) {
                            group.group_name = [dic valueForKey:@"group_name"];
                        }
                        if ([self hasValue:dic key:@"id"]==YES) {
                            group.id = [dic valueForKey:@"id"];
                        }
                        if ([self hasValue:dic key:@"is_anonymous"]==YES) {
                            group.is_anonymous = @([[dic valueForKey:@"is_anonymous"]boolValue]);
                        }
                        if ([self hasValue:dic key:@"is_forbid"]==YES) {
                            group.is_forbid = @([[dic valueForKey:@"is_forbid"] boolValue]);
                        }
                        if ([self hasValue:dic key:@"is_label"]==YES) {
                            group.is_label = @([[dic valueForKey:@"is_label"] intValue]);
                        }
                        if ([self hasValue:dic key:@"is_manager"]==YES) {
                            group.is_manager = @([[dic valueForKey:@"is_manager"] boolValue]);
                        }
                        if ([self hasValue:dic key:@"is_open_business_card"]==YES) {
                            group.is_open_business_card = @([[dic valueForKey:@"is_open_business_card"] boolValue]);
                        }
                        if ([self hasValue:dic key:@"is_owner"]==YES) {
                            group.is_owner = @([[dic valueForKey:@"is_owner"]boolValue]);
                        }
                        if ([self hasValue:dic key:@"need_audit_label"]==YES) {
                            group.need_audit_label = @([[dic valueForKey:@"need_audit_label"] boolValue]);
                        }
                        if ([self hasValue:dic key:@"picture"]==YES) {
                            if ([[dic valueForKey:@"picture"]isKindOfClass:[NSString class]]) {
                                group.picture = [NSData dataWithContentsOfURL:[NSURL URLWithString:[dic valueForKey:@"picture"]]];
                                group.pictureUrl = [dic valueForKey:@"picture"];
                            }else if ([[dic valueForKey:@"picture"]isKindOfClass:[NSData class]]){
                                group.picture = [dic valueForKey:@"picture"];
                            }
                        }
                        if ([self hasValue:dic key:@"screenshots_to_inform"]==YES) {
                            group.screenshots_to_inform = @([[dic valueForKey:@"screenshots_to_inform"] boolValue]);
                        }
                        if ([self hasValue:dic key:@"pictureUrl"]==YES) {
                            group.pictureUrl = [dic valueForKey:@"pictureUrl"];
                        }
                        [realms addObject:group];
                    }
                }
            } error:&erro];
            if (!erro) {
                DYLog(@"花名册-群组列表,新数据刷新成功,返回新数据");
                result(YES,[self defaultRosterGroupsList]);
            }else {
                DYLog(@"花名册-群组列表,新数据刷新失败,返回空数据");
                result(NO,[self defaultRosterGroupsList]);
            }
        }
}
#pragma mark - 单个群组入库/更新
+(void)addOrUpdateAnGroup:(NSString *)unique_id info:(nonnull NSDictionary *)info result:(DYDBResultBlock)result {
    RLMResults<DYDBUserIM_Group *> *groupResult = [DYDBUserIM_Group objectsWhere:[NSString stringWithFormat:@"xlb_uid = '%@' AND unique_id = '%@'",[self defaultXlb_UID],unique_id]];
    RLMRealm *realms = [RLMRealm defaultRealm];
    NSError *error;
    
    if (groupResult.count == 0) {
        
        [realms transactionWithBlock:^{
            DYDBUserIM_Group *group = [DYDBUserIM_Group new];
            group.DYUsersID = [NSString stringWithFormat:@"%@%@",[self defaultXlb_UID],[info valueForKey:@"unique_id"]];
            group.xlb_uid = [self defaultXlb_UID];
            
            if ([self hasValue:info key:@"background_id"]==YES) {
                group.background_id = [NSString stringWithFormat:@"%@",[info valueForKey:@"background_id"]];
            }
            
            if ([self hasValue:info key:@"unique_id"]==YES) {
                group.unique_id = [info valueForKey:@"unique_id"];
            }
            
            if ([self hasValue:info key:@"chatroom_id"]==YES) {
                group.chatroom_id = [info valueForKey:@"chatroom_id"];
            }
            
            if ([self hasValue:info key:@"g_is_label"]==YES) {
                group.g_is_label = @([[info valueForKey:@"g_is_label"] boolValue]);
            }
            
            if ([self hasValue:info key:@"group_id"]==YES) {
                group.group_id = @([[info valueForKey:@"group_id"]longLongValue]);
            }
            
            if ([self hasValue:info key:@"group_name"]==YES) {
                group.group_name = [info valueForKey:@"group_name"];
            }
            
            if ([self hasValue:info key:@"id"]==YES) {
                group.id = [NSString stringWithFormat:@"%@",[info valueForKey:@"id"]];
            }
            
            if ([self hasValue:info key:@"is_anonymous"]==YES) {
                group.is_anonymous = @([[info valueForKey:@"is_anonymous"]boolValue]);
            }
            
            if ([self hasValue:info key:@"is_forbid"]==YES) {
                group.is_forbid = @([[info valueForKey:@"is_forbid"] boolValue]);
            }
            
            if ([self hasValue:info key:@"is_label"]==YES) {
                group.is_label = @([[info valueForKey:@"is_label"] intValue]);
            }
            
            if ([self hasValue:info key:@"is_manager"]==YES) {
                group.is_manager = @([[info valueForKey:@"is_manager"] intValue]);
            }
            
            if ([self hasValue:info key:@"is_open_business_card"]==YES) {
                group.is_open_business_card = @([[info valueForKey:@"is_open_business_card"] boolValue]);
            }
            
            if ([self hasValue:info key:@"is_owner"]==YES) {
                group.is_owner = @([[info valueForKey:@"is_owner"]boolValue]);
            }
            
            if ([self hasValue:info key:@"need_audit_label"]==YES) {
                group.need_audit_label = @([[info valueForKey:@"need_audit_label"] boolValue]);
            }
                        
            if ([self hasValue:info key:@"picture"]==YES) {
                if ([[info valueForKey:@"picture"]isKindOfClass:[NSString class]]) {
                    group.picture = [NSData dataWithContentsOfURL:[NSURL URLWithString:[info valueForKey:@"picture"]]];
                    group.pictureUrl = [info valueForKey:@"picture"];
                }else if ([[info valueForKey:@"picture"]isKindOfClass:[NSData class]]){
                    group.picture = [info valueForKey:@"picture"];
                }
            }
            
            if ([self hasValue:info key:@"screenshots_to_inform"]==YES) {
                
                group.screenshots_to_inform = @([[info valueForKey:@"screenshots_to_inform"] boolValue]);
            }
            if ([self hasValue:info key:@"pictureUrl"]==YES) {
                group.pictureUrl = [info valueForKey:@"pictureUrl"];
            }
            [realms addObject:group];
        } error:&error];
        if (!error) {
            DYLog(@"花名册-添加新群组成功");
            result(YES,nil);
        }else {
            DYLog(@"花名册-添加新群组失败");
            result(NO,nil);
        }
    }else {
        
        DYDBUserIM_Group *group = groupResult[0];
        [realms transactionWithBlock:^{
            group.xlb_uid = [self defaultXlb_UID];
            if ([self hasValue:info key:@"background_id"]==YES) {
                group.background_id = [info valueForKey:@"background_id"];
            }
            if ([self hasValue:info key:@"unique_id"]==YES) {
                group.unique_id = [info valueForKey:@"unique_id"];
            }
            if ([self hasValue:info key:@"chatroom_id"]==YES) {
                group.chatroom_id = [info valueForKey:@"chatroom_id"];
            }
            
            if ([self hasValue:info key:@"g_is_label"]==YES) {
                group.g_is_label = @([[info valueForKey:@"g_is_label"] boolValue]);
            }
            if ([self hasValue:info key:@"group_id"]==YES) {
                group.group_id = [info valueForKey:@"group_id"];
            }
            if ([self hasValue:info key:@"group_name"]==YES) {
                group.group_name = [info valueForKey:@"group_name"];
            }
            if ([self hasValue:info key:@"id"]==YES) {
                group.id = [info valueForKey:@"id"];
            }
            if ([self hasValue:info key:@"is_anonymous"]==YES) {
                group.is_anonymous = @([[info valueForKey:@"is_anonymous"]boolValue]);
            }
            if ([self hasValue:info key:@"is_forbid"]==YES) {
                group.is_forbid = @([[info valueForKey:@"is_forbid"] boolValue]);
            }
            if ([self hasValue:info key:@"is_label"]==YES) {
                group.is_label = @([[info valueForKey:@"is_label"] intValue]);
            }
            if ([self hasValue:info key:@"is_manager"]==YES) {
                group.is_manager = @([[info valueForKey:@"is_manager"] boolValue]);
            }
            if ([self hasValue:info key:@"is_open_business_card"]==YES) {
                group.is_open_business_card = @([[info valueForKey:@"is_open_business_card"] boolValue]);
            }
            if ([self hasValue:info key:@"is_owner"]==YES) {
                group.is_owner = @([[info valueForKey:@"is_owner"]boolValue]);
            }
            if ([self hasValue:info key:@"need_audit_label"]==YES) {
                group.need_audit_label = @([[info valueForKey:@"need_audit_label"] boolValue]);
            }
            if ([self hasValue:info key:@"picture"]==YES) {
                if ([[info valueForKey:@"picture"]isKindOfClass:[NSString class]]) {
                    group.picture = [NSData dataWithContentsOfURL:[NSURL URLWithString:[info valueForKey:@"picture"]]];
                    group.pictureUrl = [info valueForKey:@"picture"];
                }else if ([[info valueForKey:@"picture"]isKindOfClass:[NSData class]]){
                    group.picture = [info valueForKey:@"picture"];
                }
            }
            if ([self hasValue:info key:@"screenshots_to_inform"]==YES) {
                group.screenshots_to_inform = @([[info valueForKey:@"screenshots_to_inform"] boolValue]);
            }
            if ([self hasValue:info key:@"pictureUrl"]==YES) {
                group.pictureUrl = [info valueForKey:@"pictureUrl"];
            }
            [realms addOrUpdateObject:group];
        } error:&error];
        if (!error) {
            DYLog(@"花名册-更新单个群组成功");
            result(YES,nil);
        }else {
            DYLog(@"花名册-更新单个群组失败");
            result(NO,nil);
        }
    }
}
#pragma mark - 删除单个群组
+(void)deleteAnGroup:(NSString *)unique_id info:(nonnull NSDictionary *)info result:(DYDBResultBlock)result {
    RLMResults<DYDBUserIM_Group *> *contactResult = [DYDBUserIM_Group objectsWhere:[NSString stringWithFormat:@"xlb_uid = '%@' AND unique_id = '%@'",[self defaultXlb_UID],unique_id]];
    RLMRealm *realms = [RLMRealm defaultRealm];
    NSError *error;
    if (contactResult.count != 0) {
        DYDBUserIM_Group *group = contactResult[0];
        [realms transactionWithBlock:^{
            [realms deleteObject:group];
        } error:&error];
        if (!error) {
            DYLog(@"花名册-删除单个群成功");
            result(YES,nil);
        }else {
            DYLog(@"花名册-删除单个群失败");
            result(NO,nil);
        }
    }else {
        DYLog(@"花名册-删除单个群-没有这个群");
        result(NO,nil);
    }
}

#pragma mark - =============会话与消息================
#pragma mark - 会话消息入库
+(void)addAnMessage:(NSString *)msgId info:(NSDictionary *)info result:(DYDBResultBlock)result {
    RLMRealm *realm = [RLMRealm defaultRealm];
    NSError *error;
    DYDBUserIM_Message *message = [DYDBUserIM_Message new];
    [realm transactionWithBlock:^{
        message.xlb_uid = [self defaultXlb_UID];
        message.msgId = msgId;
        if ([self hasValue:info key:@"msgId"]) {
            message.msgId = [info valueForKey:@"msgId"];
        }
        if ([self hasValue:info key:@"serverMessageId"]) {
            message.serverMessageId = [info valueForKey:@"serverMessageId"];
        }
        if ([self hasValue:info key:@"target"]) {
            message.target = [info valueForKey:@"target"];
        }
        if ([self hasValue:info key:@"targetAppKey"]) {
            message.targetAppKey = [info valueForKey:@"targetAppKey"];
        }
        if ([self hasValue:info key:@"fromAppKey"]) {
            message.fromAppKey = [info valueForKey:@"fromAppKey"];
        }
        if ([self hasValue:info key:@"fromUser"]) {
            message.fromUser = [info valueForKey:@"fromUser"];
        }
        if ([self hasValue:info key:@"fromType"]) {
            message.fromType = [info valueForKey:@"fromType"];
        }
        if ([self hasValue:info key:@"contentType"]) {
            message.contentType = @([[info valueForKey:@"contentType"] intValue]);
        }
        if ([self hasValue:info key:@"content"]) {
            message.content = [info valueForKey:@"content"];
        }
        if ([self hasValue:info key:@"timestamp"]) {
            message.timestamp = @([[info valueForKey:@"timestamp"]longLongValue]);
        }
        if ([self hasValue:info key:@"fromName"]) {
            message.fromName = [info valueForKey:@"fromName"];
        }
        if ([self hasValue:info key:@"targetType"]) {
            message.targetType = @([[info valueForKey:@"targetType"] intValue]);
        }
        if ([self hasValue:info key:@"status"]) {
            message.status = @([[info valueForKey:@"status"] intValue]);
        }
        if ([self hasValue:info key:@"isReceived"]) {
            message.isReceived = @([[info valueForKey:@"isReceived"] boolValue]);
        }
        if ([self hasValue:info key:@"flag"]) {
            message.flag = @([[info valueForKey:@"flag"] boolValue]);
        }
        if ([self hasValue:info key:@"isMeSend"]) {
            message.isMeSend = @([[info valueForKey:@"isMeSend"] boolValue]);
        }
        if ([self hasValue:info key:@"fromUserAvatar"]) {
            message.fromUserAvatar = [info valueForKey:@"fromUserAvatar"];
        }
        if ([self hasValue:info key:@"isHaveRead"]) {
            message.isHaveRead = @([[info valueForKey:@"isHaveRead"] boolValue]);
        }
        if ([self hasValue:info key:@"type"]) {
                       message.type = [info valueForKey:@"type"];
                   }
        if ([self hasValue:info key:@"belongConversation"]) {
            message.belongConversation = [info valueForKey:@"belongConversation"];
        }
        if ([self hasValue:info key:@"forSearchText"]) {
            message.forSearchText = [info valueForKey:@"forSearchText"];
        }
        [realm addObject:message];
    } error:&error];
    if (!error) {
        DYLog(@"会话消息入库成功");
        result(YES,message);
    }else {
        DYLog(@"会话消息入库失败");
        result(NO,nil);
    }
}

#pragma mark - 会话消息更新
+(void)updateAnMessage:(NSString *)msgId info:(NSDictionary *)info result:(DYDBResultBlock)result {
    RLMRealm *realm = [RLMRealm defaultRealm];
    NSError *error;
    DYDBUserIM_Message *message = [DYDBUserIM_Message objectForPrimaryKey:msgId];
//    DYLog(@"updateAnMessage:%@-%@",message,message.content);
    if (message!= nil) {
        
        [realm transactionWithBlock:^{
            message.xlb_uid = [self defaultXlb_UID];
//            if ([self hasValue:info key:@"msgId"]) {
//                message.msgId = [info valueForKey:@"msgId"];
//            }
            if ([self hasValue:info key:@"serverMessageId"]) {
                message.serverMessageId = [info valueForKey:@"serverMessageId"];
            }
            if ([self hasValue:info key:@"target"]) {
                message.target = [info valueForKey:@"target"];
            }
            if ([self hasValue:info key:@"targetAppKey"]) {
                message.targetAppKey = [info valueForKey:@"targetAppKey"];
            }
            if ([self hasValue:info key:@"fromAppKey"]) {
                message.fromAppKey = [info valueForKey:@"fromAppKey"];
            }
            if ([self hasValue:info key:@"fromUser"]) {
                message.fromUser = [info valueForKey:@"fromUser"];
            }
            if ([self hasValue:info key:@"fromType"]) {
                message.fromType = [info valueForKey:@"fromType"];
            }
            if ([self hasValue:info key:@"contentType"]) {
                message.contentType = @([[info valueForKey:@"contentType"] intValue]);
            }
            if ([self hasValue:info key:@"content"]) {
                message.content = [info valueForKey:@"content"];
            }
            if ([self hasValue:info key:@"timestamp"]) {
                message.timestamp = @([[info valueForKey:@"timestamp"]longLongValue]);
            }
            if ([self hasValue:info key:@"fromName"]) {
                message.fromName = [info valueForKey:@"fromName"];
            }
            if ([self hasValue:info key:@"targetType"]) {
                message.targetType = @([[info valueForKey:@"targetType"] intValue]);
            }
            if ([self hasValue:info key:@"status"]) {
                message.status = @([[info valueForKey:@"status"] intValue]);
            }
            if ([self hasValue:info key:@"isReceived"]) {
                message.isReceived = @([[info valueForKey:@"isReceived"] boolValue]);
            }
            if ([self hasValue:info key:@"flag"]) {
                message.flag = @([[info valueForKey:@"flag"] boolValue]);
            }
            if ([self hasValue:info key:@"isHaveRead"]) {
                message.isHaveRead = @([[info valueForKey:@"isHaveRead"] boolValue]);
            }
            if ([self hasValue:info key:@"isMeSend"]) {
                message.isMeSend = @([[info valueForKey:@"isMeSend"] boolValue]);
            }
            if ([self hasValue:info key:@"fromUserAvatar"]) {
                message.fromUserAvatar = [info valueForKey:@"fromUserAvatar"];
            }
            if ([self hasValue:info key:@"type"]) {
                message.type = [info valueForKey:@"type"];
            }
            if ([self hasValue:info key:@"belongConversation"]) {
                message.belongConversation = [info valueForKey:@"belongConversation"];
            }
            if ([self hasValue:info key:@"forSearchText"]) {
                message.forSearchText = [info valueForKey:@"forSearchText"];
            }
            [realm addOrUpdateObject:message];
        } error:&error];
        if (!error) {
            DYLog(@"会话消息更新成功");
            result(YES,message);
        }else {
            DYLog(@"会话消息更新失败");
            result(NO,nil);
        }
    }else {
        [self addAnMessage:msgId info:info result:^(BOOL isSuccess, id  _Nullable obj) {
            result(isSuccess,obj);
        }];
    }
}

#pragma mark - 所有会话
+(NSMutableArray *)defaultConversations {
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    RLMResults <DYDBUserIM_Conversation *>*results = [DYDBUserIM_Conversation objectsWhere:[NSString stringWithFormat:@"xlb_uid = '%@' AND isHide = false AND isBlack = false",[self defaultXlb_UID]]];
    for (DYDBUserIM_Conversation *conv in results) {
        [arr addObject:conv];
    }
    return arr;
}

#pragma mark - 添加/更新一个会话
+(void)addOrUpdateAnConversation:(NSString *)uid targetID:(NSString *)targetID info:(NSDictionary *)info result:(DYDBResultBlock)result {
    RLMResults <DYDBUserIM_Conversation *>*results = [DYDBUserIM_Conversation objectsWhere:[NSString stringWithFormat:@"xlb_uid = '%@' AND targetID = '%@'",uid,targetID]];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    NSError *error;
    if (results.count==0) {
        DYDBUserIM_Conversation *conv = [DYDBUserIM_Conversation new];
        [realm transactionWithBlock:^{
            
            conv.xlb_uid = uid;
            conv.DYUsersID = [NSString stringWithFormat:@"%@%@",uid,[info valueForKey:@"targetID"]];
            if ([self hasValue:info key:@"avatar"]) {
                conv.avatar = [info valueForKey:@"avatar"];
            }
            if ([self hasValue:info key:@"conversationType"]) {
                conv.conversationType = @([[info valueForKey:@"conversationType"] intValue]);
            }
            if ([self hasValue:info key:@"name"]) {
                conv.name = [info valueForKey:@"name"];
            }
            if ([self hasValue:info key:@"latestTimeInterval"]) {
                conv.latestTimeInterval = [NSString stringWithFormat:@"%@",[info valueForKey:@"latestTimeInterval"]];
            }
            if ([self hasValue:info key:@"updateTimeInterval"]) {
                conv.updateTimeInterval = [NSString stringWithFormat:@"%@",[info valueForKey:@"updateTimeInterval"]];
            }
            if ([self hasValue:info key:@"unReadCount"]) {
                conv.unReadCount = @([[info valueForKey:@"unReadCount"] intValue]);
            }
            if ([self hasValue:info key:@"groupSendman"]) {
                conv.groupSendman = [info valueForKey:@"groupSendman"];
            }
            if ([self hasValue:info key:@"messageContent"]) {
                conv.messageContent = [info valueForKey:@"messageContent"];
            }
//            if ([self hasValue:info key:@"isReplaceTop"]) {
//                conv.isReplaceTop = @([[info valueForKey:@"isReplaceTop"] boolValue]);
//            }
            conv.isReplaceTop = @(NO);
            if ([self hasValue:info key:@"replaceTopTimeInterval"]) {
                conv.replaceTopTimeInterval = [NSString stringWithFormat:@"%@",[info valueForKey:@"replaceTopTimeInterval"]];
            }
//            if ([self hasValue:info key:@"isNoDisturb"]) {
//                conv.isNoDisturb = @([[info valueForKey:@"isNoDisturb"] boolValue]);
//            }
            conv.isNoDisturb = @(NO);
            if ([self hasValue:info key:@"targetID"]) {
                conv.targetID = [info valueForKey:@"targetID"];
            }
            if ([self hasValue:info key:@"draftText"]) {
                conv.draftText = [info valueForKey:@"draftText"];
            }
//            if ([self hasValue:info key:@"hasDraft"]) {
//                conv.hasDraft = @([[info valueForKey:@"hasDraft"] intValue]);
//            }
            conv.hasDraft = @(NO);
//            if ([self hasValue:info key:@"isHide"]) {
//                conv.isHide = @([[info valueForKey:@"isHide"] boolValue]);
//            }
            conv.isHide = @(NO);
            conv.isBlack = @(NO);
            
            [realm addObject:conv];
        } error:&error];
        if (!error) {
            DYLog(@"会话入库成功");
            result(YES,conv);
        }else {
            DYLog(@"会话入库失败");
            result(NO,nil);
        }
    }else {
        
        DYDBUserIM_Conversation *conv = results[0];
        
        [realm transactionWithBlock:^{
//            conv.DYUsersID = [NSString stringWithFormat:@"%@%@",[self defaultXlb_UID],[info valueForKey:@"targetID"]];
//            conv.xlb_uid = [self defaultXlb_UID];
            if ([self hasValue:info key:@"avatar"]) {
                conv.avatar = [info valueForKey:@"avatar"];
            }
            if ([self hasValue:info key:@"conversationType"]) {
                conv.conversationType = @([[info valueForKey:@"conversationType"] intValue]);
            }
            if ([self hasValue:info key:@"name"]) {
                conv.name = [info valueForKey:@"name"];
            }
            if ([self hasValue:info key:@"latestTimeInterval"]) {
                conv.latestTimeInterval = [NSString stringWithFormat:@"%@",[info valueForKey:@"latestTimeInterval"]];
            }
            if ([self hasValue:info key:@"updateTimeInterval"]) {
                conv.updateTimeInterval = [NSString stringWithFormat:@"%@",[info valueForKey:@"updateTimeInterval"]];
            }
            if ([self hasValue:info key:@"unReadCount"]) {
                conv.unReadCount = @([[info valueForKey:@"unReadCount"] intValue]);
            }
            if ([self hasValue:info key:@"groupSendman"]) {
                conv.groupSendman = [info valueForKey:@"groupSendman"];
            }
            if ([self hasValue:info key:@"messageContent"]) {
                conv.messageContent = [info valueForKey:@"messageContent"];
            }
            if ([self hasValue:info key:@"isReplaceTop"]) {
                conv.isReplaceTop = @([[info valueForKey:@"isReplaceTop"] boolValue]);
            }
            if ([self hasValue:info key:@"replaceTopTimeInterval"]) {
                conv.replaceTopTimeInterval = [NSString stringWithFormat:@"%@",[info valueForKey:@"replaceTopTimeInterval"]];
            }
            if ([self hasValue:info key:@"isNoDisturb"]) {
                conv.isNoDisturb = @([[info valueForKey:@"isNoDisturb"] boolValue]);
            }
//            if ([self hasValue:info key:@"targetID"]) {
//                conv.targetID = [info valueForKey:@"targetID"];
//            }
            if ([self hasValue:info key:@"isBlack"]) {
                conv.isBlack = @([[info valueForKey:@"isBlack"] boolValue]);
            }
            if ([self hasValue:info key:@"draftText"]) {
                conv.draftText = [info valueForKey:@"draftText"];
            }
            if ([self hasValue:info key:@"hasDraft"]) {
                conv.hasDraft = @([[info valueForKey:@"hasDraft"] intValue]);
            }
            if ([self hasValue:info key:@"isHide"]) {
                conv.isHide = @([[info valueForKey:@"isHide"] boolValue]);
            }
            if ([self hasValue:info key:@"chatBackGroundImage"]) {
                conv.chatBackGroundImage = [info valueForKey:@"chatBackGroundImage"];
            }
            [realm addOrUpdateObject:conv];
        } error:&error];
        if (!error) {
            DYLog(@"会话更新成功");
            result(YES,conv);
        }else {
            DYLog(@"会话更新失败");
            result(NO,nil);
        }
    }
}


#pragma mark - 删除一个会话
+(void)deleteAnConversation:(NSString *)uid targetID:(NSString *)targetID result:(DYDBResultBlock)result {
    RLMResults <DYDBUserIM_Conversation *>*results = [DYDBUserIM_Conversation objectsWhere:[NSString stringWithFormat:@"xlb_uid = '%@' AND targetID = '%@'",uid,targetID]];
    RLMRealm *realm = [RLMRealm defaultRealm];
    NSError *error;
    if (results.count!=0) {
        [realm transactionWithBlock:^{
            [realm deleteObjects:results];
        } error:&error];
        if (!error) {
            DYLog(@"会话删除成功");
            result(YES,nil);
        }else {
            DYLog(@"会话删除失败");
            result(NO,nil);
        }
    }else {
        DYLog(@"删除会话-没有这个会话")
        result(YES,nil);
    }
}

#pragma mark - 某会话所有消息
+(NSMutableArray *)allMessageInAnConversation:(NSString *)uid targetID:(NSString *)targetID {
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    RLMResults *results = [DYDBUserIM_Message objectsWhere:[NSString stringWithFormat:@"xlb_uid = '%@' AND belongConversation = '%@'",uid,targetID]];
    if (results.count != 0) {
        for (DYDBUserIM_Message *msg in results) {
            [arr addObject:msg];
        }
    }
    NSSortDescriptor *timeSD = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES];//ascending:YES 代表升序 如果为NO 代表降序
    arr = [[arr sortedArrayUsingDescriptors:@[timeSD]] mutableCopy];
    return arr;
}

#pragma mark - 删除一个会话所有消息
+(void)deleteAllMessageOfAnConversation:(NSString *)uid targetID:(NSString *)targetID result:(DYDBResultBlock)result {
    RLMRealm *realm = [RLMRealm defaultRealm];
    RLMResults *results = [DYDBUserIM_Message objectsWhere:[NSString stringWithFormat:@"xlb_uid = '%@' AND belongConversation = '%@'",uid,targetID]];
    NSError *error;
    [realm transactionWithBlock:^{
        [realm deleteObjects:results];
    } error:&error];
    result(error==nil?YES:NO,nil);
}

#pragma mark - 删除好友-全部相关
+(void)deleteAFriend:(NSString *)uid targetID:(NSString *)targetID result:(DYDBResultBlock)result {
    // 花名册是被消息删除的
    NSString *str;
    if (![targetID hasPrefix:@"user_"]) {
        str = [NSString stringWithFormat:@"user_%@",targetID];
    }
    [self deleteAllMessageOfAnConversation:uid targetID:str result:^(BOOL isSuccess, id  _Nullable obj) {
        
        [self deleteAnConversation:uid targetID:str result:^(BOOL isSuccess, id  _Nullable obj) {
            
            [self deleteAnContact:targetID info:@{} result:^(BOOL isSuccess, id  _Nullable obj) {
                
                result(YES,nil);
            }];
        }];
    }];
}

#pragma mark - 删除一条本地消息
+(void)deleteAMessage:(DYDBUserIM_Message *)message result:(DYDBResultBlock)result {
    RLMRealm *realm = [RLMRealm defaultRealm];
    if (message!=nil) {
        NSError *error;
        [realm transactionWithBlock:^{
            [realm deleteObject:message];
        } error:&error];
        result(error==nil?YES:NO,nil);
    }else {
        result(YES,nil);
    }
    
}

#pragma mark - 添加一个媒体文件
+(void)addAnMedia:(NSString *)mediaId info:(NSDictionary *)info result:(DYDBResultBlock)result{
    RLMRealm *realm = [RLMRealm defaultRealm];
    NSError *error;
    DYDBUserIM_Resource *resource = [DYDBUserIM_Resource new];
    [realm transactionWithBlock:^{
        resource.mediaID = mediaId;
        resource.xlb_uid = [self defaultXlb_UID];
        if ([self hasValue:info key:@"url"]) {
            resource.url = [info valueForKey:@"url"];
        }
        if ([self hasValue:info key:@"status"]) {
            resource.status = [info valueForKey:@"status"];
        }
        if ([self hasValue:info key:@"type"]) {
            resource.type = [info valueForKey:@"type"];
        }
        if ([self hasValue:info key:@"mediaData"]) {
            resource.mediaData = [info valueForKey:@"mediaData"];
        }
        if ([self hasValue:info key:@"extension"]) {
            resource.extension = [info valueForKey:@"extension"];
        }
        if ([self hasValue:info key:@"videoCoverData"]) {
            resource.videoCoverData = [info valueForKey:@"videoCoverData"];
        }
        if ([self hasValue:info key:@"videoCoverUrl"]) {
            resource.videoCoverUrl = [info valueForKey:@"videoCoverUrl"];
        }
        if ([self hasValue:info key:@"videoCoverextension"]) {
            resource.videoCoverextension = [info valueForKey:@"videoCoverextension"];
        }
        if ([self hasValue:info key:@"duration"]) {
            resource.duration = [info valueForKey:@"duration"];
        }
        if ([self hasValue:info key:@"videoCoverMediaID"]) {
            resource.videoCoverMediaID = [info valueForKey:@"videoCoverMediaID"];
        }
        if ([self hasValue:info key:@"ext"]) {
            resource.ext = [info valueForKey:@"ext"];
        }
        if ([self hasValue:info key:@"timbre"]) {
            resource.timbre = [info valueForKey:@"timbre"];
        }
        [realm addObject:resource];
    } error:&error];
    if (!error) {
        DYLog(@"媒体文件入库成功");
        result(YES,resource);
    }else {
        DYLog(@"媒体文件入库失败");
        result(NO,nil);
    }
}

#pragma mark - 更新一个媒体文件
+(void)updateAnMedia:(NSString *)mediaId info:(NSDictionary *)info result:(DYDBResultBlock)result{
    RLMRealm *realm = [RLMRealm defaultRealm];
    NSError *error;
    DYDBUserIM_Resource *resource = [DYDBUserIM_Resource objectForPrimaryKey:mediaId];
    if (resource!= nil) {
        [realm transactionWithBlock:^{
            if ([self hasValue:info key:@"url"]) {
                resource.url = [info valueForKey:@"url"];
            }
            if ([self hasValue:info key:@"status"]) {
                resource.status = [info valueForKey:@"status"];
            }
            if ([self hasValue:info key:@"mediaID"]) {
                resource.mediaID = [info valueForKey:@"mediaID"];
            }
            resource.xlb_uid = [self defaultXlb_UID];
            if ([self hasValue:info key:@"type"]) {
                resource.type = [info valueForKey:@"type"];
            }
            if ([self hasValue:info key:@"mediaData"]) {
                resource.mediaData = [info valueForKey:@"mediaData"];
            }
            if ([self hasValue:info key:@"extension"]) {
                resource.extension = [info valueForKey:@"extension"];
            }
            if ([self hasValue:info key:@"videoCoverData"]) {
                resource.videoCoverData = [info valueForKey:@"videoCoverData"];
            }
            if ([self hasValue:info key:@"videoCoverUrl"]) {
                resource.videoCoverUrl = [info valueForKey:@"videoCoverUrl"];
            }
            if ([self hasValue:info key:@"videoCoverextension"]) {
                resource.videoCoverextension = [info valueForKey:@"videoCoverextension"];
            }
            if ([self hasValue:info key:@"duration"]) {
                resource.duration = [info valueForKey:@"duration"];
            }
            if ([self hasValue:info key:@"videoCoverMediaID"]) {
                resource.videoCoverMediaID = [info valueForKey:@"videoCoverMediaID"];
            }
            if ([self hasValue:info key:@"ext"]) {
                resource.ext = [info valueForKey:@"ext"];
            }
            if ([self hasValue:info key:@"timbre"]) {
                resource.timbre = [info valueForKey:@"timbre"];
            }
            [realm addOrUpdateObject:resource];
        } error:&error];
        if (!error) {
            DYLog(@"媒体文件更新成功");
            result(YES,resource);
        }else {
            DYLog(@"媒体文件更新失败");
            result(NO,nil);
        }
    }else {
        [self addAnMedia:mediaId info:info result:^(BOOL isSuccess, id  _Nullable obj) {
            result(isSuccess,obj);
        }];
    }
}

@end


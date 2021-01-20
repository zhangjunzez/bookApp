//
//  TDUserDBManager.m
//  TuDianEducation
//
//  Created by zpz on 2020/4/21.
//  Copyright © 2020 郑州大點哥. All rights reserved.
//

#import "TDUserDBManager.h"
#import "TDUserModel.h"


@implementation TDUserDBManager

+ (BOOL)userIsLogin{
    NSString *token = kToken;
    return token.length > 1;
}

+ (void)setDefaultRealm{
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.fileURL = [[[config.fileURL URLByDeletingLastPathComponent]  URLByAppendingPathComponent:kUserID] URLByAppendingPathExtension:@"realm"];
    [RLMRealmConfiguration setDefaultConfiguration:config];
}

+ (void)setUserHead:(NSData *)data{
    RLMRealm *realm = [RLMRealm defaultRealm];
    TDUserModel *user = [self getUserInfo];
    
    if (user) {
        //更新指定属性的数据
        [realm transactionWithBlock:^{
            user.userHeadData = data;
        }];
    }else{
        TDUserModel *model = [[TDUserModel alloc]initWithValue:@{@"userHeadData": data,}];
        [realm transactionWithBlock:^{
            [realm addObject:model];
        }];
    }

}


+ (NSData *)getUserHead{
    

    TDUserModel *user = [self getUserInfo];
    if (user) {
        return user.userHeadData;
    }else{
        return nil;
    }
    
}


+ (void)setUserHeadURL:(NSString *)data{
    RLMRealm *realm = [RLMRealm defaultRealm];
          TDUserModel *user = [self getUserInfo];
        
        if (user) {
            //更新指定属性的数据
            [realm transactionWithBlock:^{
                user.headUrl = data;
            }];
        }else{
            TDUserModel *model = [[TDUserModel alloc]initWithValue:@{@"headUrl": data,}];
            [realm transactionWithBlock:^{
                [realm addObject:model];
            }];
        }
}

+ (NSString *)userType{
    TDUserModel *user = [self getUserInfo];
    if (user) {
        return user.type;
    }else{
        return nil;
    }
}


+ (NSString *)getUserHeadURL{

    TDUserModel *user = [self getUserInfo];
    if (user) {
        return user.headUrl;
    }else{
        return nil;
    }
}

+ (void)setUserPhone:(NSString *)data{
    RLMRealm *realm = [RLMRealm defaultRealm];
      TDUserModel *user = [self getUserInfo];
    
    if (user) {
        //更新指定属性的数据
        [realm transactionWithBlock:^{
            user.phone = data;
        }];
    }else{
        TDUserModel *model = [[TDUserModel alloc]initWithValue:@{@"phone": data,}];
        [realm transactionWithBlock:^{
            [realm addObject:model];
        }];
    }
}
+ (NSString *)getUserPhone{

    TDUserModel *user = [self getUserInfo];
    if (user) {
        return user.phone;
    }else{
        return nil;
    }
}

+ (void)setUserName:(NSString *)data{
    RLMRealm *realm = [RLMRealm defaultRealm];
      TDUserModel *user = [self getUserInfo];
    
    if (user) {
        //更新指定属性的数据
        [realm transactionWithBlock:^{
            user.nickname = data;
        }];
    }else{
        TDUserModel *model = [[TDUserModel alloc]initWithValue:@{@"nickname": data,}];
        [realm transactionWithBlock:^{
            [realm addObject:model];
        }];
    }
}

+ (NSString *)getUserName{
    TDUserModel *user = [self getUserInfo];
    if (user) {
        return user.nickname;
    }else{
        return nil;
    }
}

+ (void)setUserInfo:(TDUserModel *)data{
    if (!data) {
        return;
    }
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addOrUpdateObject:data];
    }];
}


+ (TDUserModel *)getUserInfo{
    if (!kUserID.length) {
        return nil;
    }
    RLMRealm *realm = [RLMRealm defaultRealm];
    TDUserModel *res = [TDUserModel objectInRealm:realm forPrimaryKey:kUserID];
    return res;
}


+ (void)setUserIsSetTradePwd:(BOOL)bo{
    RLMRealm *realm = [RLMRealm defaultRealm];
    TDUserModel *user = [self getUserInfo];
    if (user) {
        //更新指定属性的数据
        [realm transactionWithBlock:^{
            user.hasTradersPwd = bo;
        }];
    }
}
+ (BOOL)getUserIsSetTradePwd{
    TDUserModel *user = [self getUserInfo];
    if (user) {
        return user.hasTradersPwd;
    }else{
        return NO;
    }
}

+ (void)userLoginOut{
    
    SSKJUserDefaultsSET(@"", @"id");
    SSKJUserDefaultsSET(@"", @"uid");
    
    kSendNotificationForLoginOut
    
   
}

//+ (void)initialize{
//    if (!kUserID.length) {
//        SSKJUserDefaultsSET(@"1", @"id");
//    }
//}
@end

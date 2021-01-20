//
//  DYDBUserIM_Group.h
//  XILAIBANG
//
//  Created by ff on 2019/10/16.
//  Copyright © 2019 大點哥. All rights reserved.
//

#import "RLMObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface DYDBUserIM_Group : RLMObject

// 多用户唯一标识(xlb_uid+unique_id)
@property NSString *DYUsersID;
// 用户唯一标识
@property NSString *xlb_uid;

@property NSString *background_id;
@property NSString *chatroom_id;
@property NSNumber<RLMBool> *g_is_label;
@property NSNumber<RLMInt> *group_id;
@property NSString *group_name;
@property NSString *id;
@property NSNumber<RLMBool> *is_anonymous;
@property NSNumber<RLMBool> *is_forbid;
@property NSNumber<RLMInt> *is_label;
@property NSNumber<RLMBool> *is_manager;
@property NSNumber<RLMBool> *is_open_business_card;
@property NSNumber<RLMBool> *is_owner;
@property NSNumber<RLMBool> *need_audit_label;
@property NSData *picture;
@property NSString *pictureUrl;
@property NSNumber<RLMBool> *screenshots_to_inform;
@property NSString *unique_id;

@end


NS_ASSUME_NONNULL_END

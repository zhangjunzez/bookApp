//
//  DYDBUserIM_Contact.h
//  XILAIBANG
//
//  Created by ff on 2019/9/20.
//  Copyright © 2019 大點哥. All rights reserved.
//

#import "RLMObject.h"

NS_ASSUME_NONNULL_BEGIN
/*
 age = 14;
 "background_id" = 0;
 gender = 2;
 "is_new" = 1;
 "is_quiet" = 0;
 "is_sys" = 0;
 nickname = "\U4e00\U5929\U5929";
 phone = "152****0000";
 picture = "https://xilaibang.oss-cn-hangzhou.aliyuncs.com/userimg/0/20190923/0000000000_1569226838000_cyxwid.jpg";
 remarks = "\U4e00\U5929\U5929";
 "sign_text" = "\U8fd9\U5bb6\U4f19\U5f88\U61d2\Uff01\U4ec0\U4e48\U4e5f\U6ca1\U5199";
 status = 2;
 "tag_name" = Y;
 uid = 256;
 "unique_id" = 5068238884;
 "update_time" = 1569226840;
 username = "user_5068238884";
 */

// 联系人
@interface DYDBUserIM_Contact : RLMObject

// 多用户唯一标识(xlb_uid+unique_id)
@property NSString *DYUsersID;
// 用户唯一标识
@property NSString *xlb_uid;


@property NSNumber<RLMInt> *age;
@property NSString *background_id;
@property NSNumber<RLMInt> *gender;
@property NSNumber<RLMBool> *is_new;
@property NSNumber<RLMBool> *is_quiet;
@property NSNumber<RLMBool> *is_sys;
@property NSString *nickname;
@property NSString *phone;
@property NSData *picture;
@property NSString *pictureUrl;
@property NSString *remarks;
@property NSString *sign_text;
@property NSNumber<RLMInt> *status;
@property NSString *tag_name;
@property NSString *uid;
@property NSString *unique_id;
@property NSNumber<RLMInt> *update_time;
@property NSString *username;
// 添加来源
@property NSNumber <RLMInt> *from_way;
@end


NS_ASSUME_NONNULL_END

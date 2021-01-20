//
//  DYDBUserInfo.h
//  XILAIBANG
//
//  Created by ff on 2019/9/20.
//  Copyright © 2019 大點哥. All rights reserved.
//

#import "RLMObject.h"

NS_ASSUME_NONNULL_BEGIN
/*
username = "user_5338837061";
"unique_id" = 5338837061;
picture = "https://xilaibang.oss-cn-hangzhou.aliyuncs.com/userimg/0/20190918/0000000000_1568773781000_sejSZh.png";
nickname = 20;
phone = 13140191520;
 
gender = 1;
 age = 13;
birthday = "2005-12-30";
 "sign_text" = "\U8fd9\U5bb6\U4f19\U5f88\U61d2\Uff01\U4ec0\U4e48\U4e5f\U6ca1\U5199";
 
province = "";
city = "";
district = "<null>";
address = "";
 
 
"need_edit" = 0;
"has_payword" = 1;
jg = "user_5338837061";
tjcode = GQCVJG;
lecturers = 1;
"lecturers_lv" = 0;
showLecturers = 0;


"user_interested" =         (
);

*/

@interface DYDBUserInfo : RLMObject
// 用户唯一标识(前台)
@property NSString *xlb_uid;
// 用户唯一标识(服务器)
@property NSString *username;
// 邦号
@property NSString *unique_id;
// 头像
@property NSString *picture;
// 昵称
@property NSString *nickname;
// 头像
@property NSString *phone;
// 性别
@property NSNumber <RLMInt> *gender;
// 年龄
@property NSNumber <RLMInt> *age;
// 生日
@property NSString *birthday;
// 个性签名
@property NSString *sign_text;
// 省
@property NSString *province;
// 市
@property NSString *city;
// 区
@property NSString *district;
// 详细地址
@property NSString *address;
// 是否需要完善信息
@property NSNumber <RLMBool> *isEdit;
// 是否设置过支付密码
@property NSNumber <RLMBool> *has_payword;
// 推荐码
@property NSString *tjCode;
// 推荐码链接
@property NSString *tj_link;
// 是否是讲师
@property NSNumber <RLMBool> *lecturers;
// 讲师等级
@property NSNumber <RLMInt> *lecturers_lv;
// 是否展示讲师铭牌
@property NSNumber <RLMBool> *lecturers_nameplate;
//
@property NSNumber <RLMBool> *salesman_vip;
// 果园链接
@property NSString *orchard_url;

#pragma mark - 前台本地配置项
// 字体
@property NSNumber <RLMDouble> *font;
// 会话未读数量
@property NSString *chatUnreadCount;
// 花名册未读数量
@property NSString *rosterUnreadCount;
// 花名册-好友列表刷新时间戳
@property NSString *contactListUpdateTimeInterival;
// 花名册-群组列表刷新时间戳
@property NSString *groupListUpdateTimeInterival;
// 购买权限列表(json ->dic)
@property NSString *PurchasePermission;

@end


NS_ASSUME_NONNULL_END

//
//  LXUserInforModel.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/6.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXUserInforModel : NSObject
///手机号
@property (nonatomic,strong) NSString *phone;
///昵称
@property (nonatomic,strong) NSString *nickname;
///是否设置支付密码 0未设置 1已设置
@property (nonatomic,strong) NSString *paypassword;
///性别
@property (nonatomic,strong) NSString *sex;
///年龄
@property (nonatomic,strong) NSString *age;
///真实姓名
@property (nonatomic,strong) NSString *realname;
///公司名称
@property (nonatomic,strong) NSString *companyname;
///擅长行业id
@property (nonatomic,strong) NSString *inid;
///擅长行业名称
@property (nonatomic,strong) NSString *industrys;
///从业年限
@property (nonatomic,strong) NSString *workingyears;
///认证状态 0未认证 1审核中 2已认证 3审核失败
@property (nonatomic,strong) NSString *isauth;
///审核失败原因(isauth=3时返回)
@property (nonatomic,strong) NSString *authreason;
///邀请码
@property (nonatomic,strong) NSString *invitationcode;
///余额
@property (nonatomic,strong) NSString *balance;
///积分
@property (nonatomic,strong) NSString *integrals;
///头像地址
@property (nonatomic,strong) NSString *icon;
@end

NS_ASSUME_NONNULL_END

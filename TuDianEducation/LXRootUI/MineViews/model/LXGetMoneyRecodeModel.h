//
//  LXGetMoneyRecodeModel.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/8.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 {
   "wid":""//提现id
   "state":""//状态 0待审核 1已通过 2已拒绝
   "bankname":""//开户行名称
   "username":""//开户人名称
   "banknum":""//银行卡号
   "money":""//提现金额
   "remarks":""//备注
   "adtime":""//申请时间
   "endtime":""//审核时间
 }
 */
NS_ASSUME_NONNULL_BEGIN

@interface LXGetMoneyRecodeModel : NSObject
@property (nonatomic,strong) NSString *wid;
@property (nonatomic,strong) NSString *state;
@property (nonatomic,strong) NSString *bankname;
@property (nonatomic,strong) NSString *username;
@property (nonatomic,strong) NSString *banknum;
@property (nonatomic,strong) NSString *money;
@property (nonatomic,strong) NSString *remarks;
@property (nonatomic,strong) NSString *adtime;
@property (nonatomic,strong) NSString *endtime;
@end

NS_ASSUME_NONNULL_END

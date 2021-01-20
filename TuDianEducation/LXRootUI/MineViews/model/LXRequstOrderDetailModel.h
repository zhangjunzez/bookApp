//
//  LXRequstOrderDetailModel.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/13.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 {
   "ordernum":""//订单号
   "name":""//需求人姓名
   "phone":""//需求人电话
   "address":""//需求地区
   "addressdetail":""//需求地址详情
   "industrys":""//行业分类
   "companyname":""//公司名称
   "qualifications":""//公司资质
   "equipmentname":""//设备名称
   "describes":""//故障问题描述
   "describeimage":["",""]//故障照片
   "expecttime":""//期望到达时间
   "price":""//酬金
   "cmprice":""//优惠券金额
   "allprice":""//实付金额
   "state":""//状态 0待审核 1审核失败 2待接单 3已取消 4待支付 5工程师服务中 6用户待确认 7待评价 8已完成 9异常订单
   "paytype":""//支付方式 0会员余额 1微信 2支付宝
   "adtime":""//下单时间
   "shtime":""//审核时间
   "jdtime":""//接单时间
   "qxtime":""//取消时间
   "zftime":""//支付时间
   "gcsqrtime":""//工程师确认时间
   "yhqrtime":""//用户确认时间
   "pjtime":""//评价时间
 }
 */
NS_ASSUME_NONNULL_BEGIN

@interface LXRequstOrderDetailModel : NSObject
@property (nonatomic,strong) NSString *ordernum;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *addressdetail;
@property (nonatomic,strong) NSString *industrys;
@property (nonatomic,strong) NSString *companyname;
@property (nonatomic,strong) NSString *qualifications;
@property (nonatomic,strong) NSString *equipmentname;
@property (nonatomic,strong) NSString *describes;
@property (nonatomic,strong) NSArray *describeimage;
@property (nonatomic,strong) NSString *expecttime;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *cmprice;
@property (nonatomic,strong) NSString *allprice;
@property (nonatomic,strong) NSString *state;
@property (nonatomic,strong) NSString *paytype;
@property (nonatomic,strong) NSString *adtime;
@property (nonatomic,strong) NSString *shtime;
@property (nonatomic,strong) NSString *jdtime;
@property (nonatomic,strong) NSString *qxtime;
@property (nonatomic,strong) NSString *zftime;
@property (nonatomic,strong) NSString *gcsqrtime;
@property (nonatomic,strong) NSString *yhqrtime;
@property (nonatomic,strong) NSString *pjtime;

@property (nonatomic,strong) NSString *statusString;
@end

NS_ASSUME_NONNULL_END

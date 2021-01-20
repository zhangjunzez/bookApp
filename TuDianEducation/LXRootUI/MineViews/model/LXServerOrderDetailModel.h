//
//  LXServerOrderDetailModel.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/13.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 {//工程师端只返回状态2及以后的订单
   "ordernum":""//订单号
   "name":""//需求人姓名
   "phone":""//需求人电话
   "address":""//需求地区
   "addressdetail":""//需求地址详情
   "servicesname":""//服务名称
   "servicestitle":""//服务副标题
   "servicesintroduction":""//服务简介
   "servicesbannerimages":[]//服务图片
   "servicesprice":""//服务价格
   "cmprice":""//优惠券金额
   "allprice":""//实付金额
   "state":""//状态 0待付款 1已取消 2工程师服务中 3用户待确认 4待评价 5已完成 6异常订单
   "paytype":""//支付方式 0会员余额 1微信 2支付宝
   "adtime":""//下单时间
   "qxtime":""//取消时间
   "zftime":""//支付时间
   "gcsqrtime":""//工程师确认时间
   "yhqrtime":""//用户确认时间
   "pjtime":""//评价时间
 }
 */
NS_ASSUME_NONNULL_BEGIN

@interface LXServerOrderDetailModel : NSObject
@property (nonatomic,strong) NSString *ordernum;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *addressdetail;
@property (nonatomic,strong) NSString *servicesname;
@property (nonatomic,strong) NSString *servicestitle;
@property (nonatomic,strong) NSString *servicesintroduction;
@property (nonatomic,strong) NSString *servicesbannerimages;
@property (nonatomic,strong) NSString *servicesprice;
@property (nonatomic,strong) NSString *cmprice;
@property (nonatomic,strong) NSString *allprice;
@property (nonatomic,strong) NSString *state;
@property (nonatomic,strong) NSString *paytype;
@property (nonatomic,strong) NSString *adtime;
@property (nonatomic,strong) NSString *qxtime;
@property (nonatomic,strong) NSString *zftime;
@property (nonatomic,strong) NSString *gcsqrtime;
@property (nonatomic,strong) NSString *yhqrtime;
@property (nonatomic,strong) NSString *pjtime;
@property (nonatomic,strong) NSString *serverStausString;
@property (nonatomic,strong) NSString *requstStausString;

@end

NS_ASSUME_NONNULL_END

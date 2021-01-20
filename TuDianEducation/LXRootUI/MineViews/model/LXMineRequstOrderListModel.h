//
//  LXMineRequstOrderListModel.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/10.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 {//工程师端订单状态只有4及以后的
   "ordernum":""//订单号
   "industrys":""//行业分类
   "equipmentname":""//设备名称
   "price":""//酬金
   "state":""//状态 0待审核 1审核失败 2待接单 3已取消 4待支付 5工程师服务中 6用户待确认 7待评价 8已完成 9异常订单
   "expecttime":""//期望到达时间
   "adtime":""//下单时间
   "jdtime":""//接单时间
 }
 {
   "ordernum":""//订单号
   "servicesname":""//服务名称
   "servicestitle":""//服务副标题
   "servicesprice":""//服务价格
   "cmprice":""//优惠券金额
   "allprice":""//实付金额
   "state":""//状态 0待付款 1已取消 2工程师服务中 3用户待确认 4待评价 5已完成 6异常订单
   "adtime":""//下单时间
 }
 */
@interface LXMineRequstOrderListModel : NSObject
@property (nonatomic,strong) NSString *ordernum;
@property (nonatomic,strong) NSString *servicesname;
@property (nonatomic,strong) NSString *servicestitle;
@property (nonatomic,strong) NSString *servicesprice;
@property (nonatomic,strong) NSString *cmprice;
@property (nonatomic,strong) NSString *allprice;
@property (nonatomic,strong) NSString *industrys;
@property (nonatomic,strong) NSString *equipmentname;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *state;
@property (nonatomic,strong) NSString *expecttime;
@property (nonatomic,strong) NSString *adtime;
@property (nonatomic,strong) NSString *jdtime;
@property (nonatomic,assign) double offHeight;
@end

NS_ASSUME_NONNULL_END

//
//  LXMarketOrderDetailModel.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/14.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 {
   "ordernum":""//订单号
   "name":""//收货人名称
   "phone":""//收货人电话
   "address":""//收货人地址详情
   "goodsid":""//商品id
   "goodsname":""//商品名称
   "goodsprice":""//积分价格
   "goodsimage":""//商品封面图
   "state":""//状态 0待发货 1待收货 2已完成
   "logisticsnum":""//物流公司编码
   "logisticscompany":""//物流公司
   "logistics":""//物流单号
   "adtime":""//兑换时间
   "fhtime":""//发货时间
   "shtime":""//收货时间
 }
 */
@interface LXMarketOrderDetailModel : NSObject
@property (nonatomic,strong) NSString *ordernum;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *goodsname;
@property (nonatomic,strong) NSString *goodsid;
@property (nonatomic,strong) NSString *goodsprice;
@property (nonatomic,strong) NSString *goodsimage;
@property (nonatomic,strong) NSString *logistics;
@property (nonatomic,strong) NSString *adtime;
@property (nonatomic,strong) NSString *state;
@property (nonatomic,strong) NSString *logisticsnum;
@property (nonatomic,strong) NSString *logisticscompany;
@property (nonatomic,strong) NSString *fhtime;
@property (nonatomic,strong) NSString *shtime;
@property (nonatomic,strong) NSString *statusString;
@property (nonatomic,strong) NSString *fahuoString;
@property (nonatomic,strong) NSString *allprice;
@property (nonatomic,strong) NSString *allprice1;
@property (nonatomic,strong) NSString *goodsprice1;
@property (nonatomic,strong) NSString *amounts;

@end

NS_ASSUME_NONNULL_END

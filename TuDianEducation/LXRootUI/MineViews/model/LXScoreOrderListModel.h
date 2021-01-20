//
//  LXScoreOrderListModel.h
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
   "goodsid":""//商品id
   "goodsname":""//商品名称
   "goodsprice":""//积分价格
   "goodsimage":""//商品封面图
   "state":""//状态 0待发货 1待收货 2已完成
   "logisticsnum":""//物流公司编码
   "logisticscompany":""//物流公司
   "logistics":""//物流单号
   "adtime":""//兑换时间
 "goodsprice1":""//现金价格
 "amounts":""//购买数量
 "allprice1":""//现金总价格
 }
 */
@interface LXScoreOrderListModel : NSObject
@property (nonatomic,strong) NSString *ordernum;
@property (nonatomic,strong) NSString *goodsid;
@property (nonatomic,strong) NSString *allprice;
@property (nonatomic,strong) NSString *goodsname;
@property (nonatomic,strong) NSString *goodsprice;
@property (nonatomic,strong) NSString *goodsimage;
@property (nonatomic,strong) NSString *state;
@property (nonatomic,strong) NSString *logisticsnum;
@property (nonatomic,strong) NSString *logisticscompany;
@property (nonatomic,strong) NSString *logistics;
@property (nonatomic,strong) NSString *adtime;
@property (nonatomic,strong) NSString *goodsprice1;
@property (nonatomic,strong) NSString *amounts;
@property (nonatomic,strong) NSString *allprice1;
@end

NS_ASSUME_NONNULL_END

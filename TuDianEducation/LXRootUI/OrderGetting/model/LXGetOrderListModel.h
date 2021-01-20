//
//  LXGetOrderListModel.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/10.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 {
   "ordernum":""//订单号
   "industrys":""//行业分类
   "equipmentname":""//设备名称
   "price":""//酬金
   "expecttime":""//期望到达时间
   "describeimage":[]//故障照片
   "describes":""//故障问题描述
   "address":""//需求地区
   "distance":""//距离
   "adtime":""//下单时间
 }
 */
@interface LXGetOrderListModel : NSObject
@property (nonatomic,strong) NSString *ordernum;
@property (nonatomic,strong) NSString *industrys;
@property (nonatomic,strong) NSString *equipmentname;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *expecttime;
@property (nonatomic,strong) NSArray *describeimage;
@property (nonatomic,strong) NSString *describes;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *distance;
@property (nonatomic,strong) NSString *adtime;
@property (nonatomic,assign) CGFloat offHeight;
@end

NS_ASSUME_NONNULL_END

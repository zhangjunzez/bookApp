//
//  LXMarketGoodsDetailModel.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/13.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 {
   "goodsid":""//商品id
   "goodsname":""//商品名称
   "goodsprice":""//商品积分价格
   "goodsimage":""//商品封面图
   "goodsimages":[]//商品轮播图
   "introduction":""//商品简介
   "url":""//详情url
   "goodssale":""//已兑换数量
 }
 */
@interface LXMarketGoodsDetailModel : NSObject
@property (nonatomic,strong) NSString *goodsid;
@property (nonatomic,strong) NSString *goodsname;
@property (nonatomic,strong) NSString *goodsprice;
@property (nonatomic,strong) NSString *goodsprice1;
@property (nonatomic,strong) NSString *goodsstock;
@property (nonatomic,strong) NSString *goodsimage;
@property (nonatomic,strong) NSArray *goodsimages;
@property (nonatomic,strong) NSString *introduction;
@property (nonatomic,strong) NSString *url;
@property (nonatomic,strong) NSString *goodssale;

@end

NS_ASSUME_NONNULL_END

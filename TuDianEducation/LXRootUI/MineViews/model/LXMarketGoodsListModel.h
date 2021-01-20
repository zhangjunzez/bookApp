//
//  LXMarketGoodsListModel.h
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
   "goodssale":""//已兑换数量
 }
 {
        "goodsid":""//商品id
        "goodsname":""//商品名称
        "goodsprice":""//商品积分价格
        "goodsprice1":""//商品现金价格
        "goodsstock":""//商品库存
        "goodsimage":""//商品封面图
        "goodssale":""//已兑换数量
      }
 */
@interface LXMarketGoodsListModel : NSObject
@property (nonatomic,strong) NSString *goodsid;
@property (nonatomic,strong) NSString *goodsname;
@property (nonatomic,strong) NSString *goodsprice;
@property (nonatomic,strong) NSString *goodsimage;
@property (nonatomic,strong) NSString *goodssale;
@property (nonatomic,strong) NSString *goodsstock;
@property (nonatomic,strong) NSString *goodsprice1;

@end

NS_ASSUME_NONNULL_END

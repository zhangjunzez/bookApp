//
//  WXPayHandler.h
//  youtoo
//
//  Created by Seven on 16/4/25.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"


@interface WXPayHandler : NSObject<WXApiDelegate>

/**
 *微信支付方法
 *prepayId 预支付订单
*/
+ (void)WXPayWithbodyDic:(NSDictionary *)bodyDic;



@end

//
//  WXPayHandler.m
//  youtoo
//
//  Created by Seven on 16/4/25.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "WXPayHandler.h"
@implementation WXPayHandler

//微信支付
+ (void)WXPayWithbodyDic:(NSDictionary *)bodyDic{
    //调起微信支付
    NSMutableString *stamp  = [bodyDic objectForKey:@"timestamp"];
    PayReq* req  = [[PayReq alloc] init];
    req.openID = [bodyDic valueForKey:@"appid"];
    req.partnerId  = [bodyDic valueForKey:@"partnerid"];
    req.prepayId   = [bodyDic valueForKey:@"prepayid"];
    req.nonceStr   = [bodyDic valueForKey:@"noncestr"];
    req.timeStamp  = stamp.intValue;
    req.package    = [bodyDic valueForKey:@"package"];
    req.sign       = [bodyDic valueForKey:@"sign"];
    if ([WXApi isWXAppInstalled]) {
        [WXApi sendReq:req completion:^(BOOL success) {
            
        }];
    }else{
        [MBProgressHUD showError:@"微信支付需要安装微信客户端"];
    }

}


@end

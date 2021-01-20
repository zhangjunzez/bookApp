//
//  DYPayHelper.m
//  XILAIBANG
//
//  Created by ff on 2019/10/6.
//  Copyright © 2019 大點哥. All rights reserved.
//

#import "DYPayHelper.h"
#import <WXApi.h>
#import <WXApiObject.h>

@interface DYPayHelper ()

@property (nonatomic, copy)payResultBlock payResultBlock;

@end


@implementation DYPayHelper

+ (instancetype)defaultHelper {
  static DYPayHelper *singleton = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    singleton = [[DYPayHelper alloc] init];
  });
  return singleton;
}

- (void)paywithType:(DYPayType)type data:(id)data result:(payResultBlock)result {
    _payResultBlock = result;
    WEAK_SELF;
    if (type == DYPayType_WechatPay) {
        NSDictionary *dict= data;
        PayReq* req = [[PayReq alloc] init];
        req.partnerId = [dict objectForKey:@"partnerid"];
        req.prepayId = [dict objectForKey:@"prepayid"];
        req.nonceStr = [dict objectForKey:@"noncestr"];
        req.timeStamp = [[dict objectForKey:@"timestamp"] intValue];
        req.package = [dict objectForKey:@"package"];
        req.sign = [dict objectForKey:@"sign"];
        [WXApi sendReq:req completion:^(BOOL success) {
            
        }];
    }else if (type == DYPayType_AliPay) {
        [[AlipaySDK defaultService] payOrder:data[@"pay_string"] fromScheme:@"xlbalipay" callback:^(NSDictionary *resultDic) {
                             DYLog(@"reslut = %@",resultDic);
                             NSString *code = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]];
                             if ([code isEqual:@"9000"]) {
                               // 支付成功
                                 if (weakSelf.payResultBlock) {
                                     weakSelf.payResultBlock(YES, @"");
                                 }
                                 [MBProgressHUD showError:@"支付成功"];
                             }else {
                                 [MBProgressHUD showError:resultDic[@"memo"]];
                             }
        //                     else if([code isEqual:@"4000"]){
        //                       [MBProgressHUD showError:@"系统异常"];
        //                     }else if([code isEqual:@"6001"]){
        //                       [MBProgressHUD showError:@"支付取消"];
        //                     }else if([code isEqual:@"6002"]){
        //                       [MBProgressHUD showError:@"网络不太好"];
        //                     }else{
        //                       [MBProgressHUD showError:@"支付失败"];
        //                     }
                           }];
    }
}

- (void)onResp:(BaseResp *)resp {
    /*
     enum  WXErrCode {
     WXSuccess           = 0,    成功
     WXErrCodeCommon     = -1,  普通错误类型
     WXErrCodeUserCancel = -2,    用户点击取消并返回
     WXErrCodeSentFail   = -3,   发送失败
     WXErrCodeAuthDeny   = -4,    授权失败
     WXErrCodeUnsupport  = -5,   微信不支持
     };
     */
    //微信支付的类
    if([resp isKindOfClass:[PayResp class]]){
        if (resp.errCode == 0) {
            // 成功
            if (self.payResultBlock) {
                self.payResultBlock(YES, @"");
            }
            [MBProgressHUD showError:@"支付成功"];
        }else{
            //失败
            [MBProgressHUD showError:resp.errStr];
        }
        
    }
    
    //微信登录的类
    if([resp isKindOfClass:[SendAuthResp class]]){
        if (resp.errCode == 0) {  //成功。
        }else{ //失败
            DYLog(@"error %@",resp.errStr);
        }
    }

    //微信分享的类
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        //微信分享 微信回应给第三方应用程序的类
        SendMessageToWXResp *response = (SendMessageToWXResp *)resp;
        DYLog(@"error code %d  error msg %@  lang %@   country %@",response.errCode,response.errStr,response.lang,response.country);
        if (resp.errCode == 0) {//成功。
        }else{ //失败
        }
    }
}

@end

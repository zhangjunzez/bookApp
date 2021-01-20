//
//  DYPayHelper.h
//  XILAIBANG
//
//  Created by ff on 2019/10/6.
//  Copyright © 2019 大點哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlipaySDK/AlipaySDK.h>
#import <WXApi.h>
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, DYPayType) {
    DYPayType_WechatPay,
    DYPayType_AliPay
};

typedef void(^payResultBlock)(BOOL isSuccess,id obj);

@interface DYPayHelper : NSObject <WXApiDelegate>

+(instancetype)defaultHelper;

- (void)paywithType:(DYPayType)type data:(id)data result:(payResultBlock)result;

@end




NS_ASSUME_NONNULL_END

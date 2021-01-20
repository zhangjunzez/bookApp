//
//  JZPayViewController.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/9/22.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "BaseViewController.h"
typedef NS_ENUM(NSUInteger,payType) {
    payTypeYuepay,
    payTypeAlipay,
    payTypeWeChatPay,
    payTypeBankPay,
};

NS_ASSUME_NONNULL_BEGIN

@interface JZPayViewController : BaseViewController
///订单号
@property (nonatomic,strong) NSString *ordernum;
///支付金额
@property (nonatomic,strong) NSString *moneyAmount;

@property (nonatomic,assign) payType payType;
@end

NS_ASSUME_NONNULL_END

//
//  LXServerOrderDetailModel.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/13.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXServerOrderDetailModel.h"

@implementation LXServerOrderDetailModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
-(NSString *)serverStausString{
    NSString *statusString = @"待支付";
    switch (self.state.integerValue) {
            ///0待付款
        case 0:
        {
            statusString = @"待支付";
        }
            break;
           ///1已取消
        case 1:
        {
            statusString = @"已取消";
        }
            break;
            ///2工程服务中
        case 2:
        {
            statusString = @"工程师服务中";
        }
            break;
            ///3用户待确认
        case 3:
        {
            statusString = @"用户待确认";
        }
            break;
            ///4待评价
        case 4:
        {
            statusString = @"待评价";
        }
            break;
            ///5已完成
        case 5:
        {
            statusString = @"已完成";
        }
            break;
            ///6异常订单
        case 6:
        {
            
            statusString = @"异常订单";
        }
            break;
        default:
            break;
    }
    return statusString;
}
-(NSString *)requstStausString{
    NSString *statusString = @"待支付";
    switch (self.state.integerValue) {
               ///4待支付
           case 4:
           {
               statusString = @"待支付";
    
           }
               break;
               ///5工程师服务中
           case 5:
           {
               statusString = @"工程师服务中";
              
           }
               break;
               ///6用户待确认
           case 6:
           {
               statusString = @"用户待确认";
              
           }
               break;
               ///7待评价
           case 7:
           {
               statusString = @"待评价";
              
           }
               break;
               ///8已完成
           case 8:
           {
               statusString = @"已完成";
               
           }
               break;
               ///9异常订单
           case 9:
           {
               statusString = @"异常订单";
           }
               break;
           default:
               break;
       }
    return statusString;
}
@end

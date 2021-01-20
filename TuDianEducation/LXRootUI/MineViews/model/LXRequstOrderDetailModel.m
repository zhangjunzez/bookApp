//
//  LXRequstOrderDetailModel.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/13.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXRequstOrderDetailModel.h"

@implementation LXRequstOrderDetailModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
-(NSString *)statusString{
    NSString *statusString = @"";
   
     switch (self.state.integerValue) {
             ///用户已取消
        case 3:
         {
             statusString = @"用户已取消";
         }
             break;
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

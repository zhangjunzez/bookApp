//
//  LXMarketOrderDetailModel.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/14.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXMarketOrderDetailModel.h"

@implementation LXMarketOrderDetailModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
-(NSString *)statusString{
     NSString *statusString = @"待发货";
   // 状态 0待发货 1待收货 2已完成
     switch (self.state.integerValue) {
             ///0待付款
         case 0:
         {
             statusString = @"待发货";
         }
             break;
            ///1已取消
         case 1:
         {
             statusString = @"待收货";
         }
             break;
             ///2工程服务中
         case 2:
         {
             statusString = @"已完成";
         }
             break;
        
         default:
             break;
     }
    return statusString;
   
}
-(NSString *)fahuoString{
     NSString *statusString = @"待发货";
     // 状态 0待发货 1待收货 2已完成
       switch (self.state.integerValue) {
               ///0待付款
           case 0:
           {
               statusString = [NSString stringWithFormat:@"兑换时间 %@",self.adtime];
           }
               break;
              ///1已取消
           case 1:
           {
               statusString = [NSString stringWithFormat:@"发货时间 %@",self.fhtime];
           }
               break;
               ///2工程服务中
           case 2:
           {
               statusString = [NSString stringWithFormat:@"发货时间 %@",self.shtime];
           }
               break;
          
           default:
               break;
       }
      return statusString;
}
@end

//
//  LXMoneyModel.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/8.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 {
   "mid":""//记录id
   "title":""//标题
   "type":""//类型 0分销收益 1需求收益 2服务收益 3申请提现 4提现返还
   "money":""//金额
   "adtime":""//时间
 }
 */
@interface LXMoneyModel : NSObject
@property (nonatomic,strong) NSString *mid;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *money;
@property (nonatomic,strong) NSString *adtime;
@end

NS_ASSUME_NONNULL_END

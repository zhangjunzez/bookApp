//
//  LXScoreListModel.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/8.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 {
   "inteid":""//记录id
   "title":""//标题
   "type":""//类型 0签到赠送 1消费
   "money":""//金额
   "adtime":""//时间
 }
 */
@interface LXScoreListModel : NSObject
@property (nonatomic,strong) NSString *inteid;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *money;
@property (nonatomic,strong) NSString *adtime;

@end

NS_ASSUME_NONNULL_END

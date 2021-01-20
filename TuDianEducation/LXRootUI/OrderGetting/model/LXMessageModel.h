//
//  LXMessageModel.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/10.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 {
   "mid":""//消息id
   "title":""//消息标题
   "content":""//内容
   "url":""//富文本链接
   "type":""//消息类型 0系统消息 1订单消息
   "state":""//0未读 1已读
   "objid":""//对应id
   "adtime":""//时间
 }
 */
@interface LXMessageModel : NSObject
@property (nonatomic,strong) NSString *mid;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *url;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *state;
@property (nonatomic,strong) NSString *objid;
@property (nonatomic,strong) NSString *adtime;
@end

NS_ASSUME_NONNULL_END

//
//  LXServerListModel.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/10.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 {
   "servicesid":""//服务id
   "servicesname":""//服务名称
   "servicestitle":""//服务副标题
   "servicesprice":""//服务价格
   "state":""//状态 0上架 1下架
   "authstate":""//审核状态 0待审核 1已审核 2审核失败
 }
 */
NS_ASSUME_NONNULL_BEGIN

@interface LXServerListModel : NSObject
@property (nonatomic,strong) NSString *servicesid;
@property (nonatomic,strong) NSString *servicesname;
@property (nonatomic,strong) NSString *servicestitle;
@property (nonatomic,strong) NSString *servicesprice;
@property (nonatomic,strong) NSString *state;
@property (nonatomic,strong) NSString *authstate;
@property (nonatomic,assign) CGFloat cellHeight;
@end

NS_ASSUME_NONNULL_END

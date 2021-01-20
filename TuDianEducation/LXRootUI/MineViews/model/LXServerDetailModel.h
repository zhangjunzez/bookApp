//
//  LXServerDetailModel.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/10.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 {
   "servicesid":""//服务id
   "inid":""//行业分类
   "industrys":""//行业分类名称
   "cid":""//发布城市id
   "cityname":""//发布城市名称
   "servicesname":""//服务名称
   "servicestitle":""//服务副标题
   "servicesintroduction":""//服务简介
   "servicescontent":""//服务详情内容
   "bannerimages":[]//轮播图
   "detailimages":[]//详情图片
   "servicesprice":""//服务价格
   "state":""//状态 0上架 1下架
   "authstate":""//审核状态 0待审核 1已审核 2审核失败
 }
 */
@interface LXServerDetailModel : NSObject
@property (nonatomic,strong) NSString *servicesid;
@property (nonatomic,strong) NSString *inid;
@property (nonatomic,strong) NSString *industrys;
@property (nonatomic,strong) NSString *cid;
@property (nonatomic,strong) NSString *cityname;
@property (nonatomic,strong) NSString *servicesname;
@property (nonatomic,strong) NSString *servicestitle;
@property (nonatomic,strong) NSString *servicesintroduction;
@property (nonatomic,strong) NSString *servicescontent;
@property (nonatomic,strong) NSArray *bannerimages;
@property (nonatomic,strong) NSArray *detailimages;
@property (nonatomic,strong) NSString *servicesprice;
@property (nonatomic,strong) NSString *state;
@property (nonatomic,strong) NSString *authstate;

@end

NS_ASSUME_NONNULL_END

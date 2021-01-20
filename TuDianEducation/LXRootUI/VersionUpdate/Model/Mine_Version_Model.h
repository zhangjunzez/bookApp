//
//  HeBi_Version_Model.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/19.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Mine_Version_Model : NSObject


////下载地址
//@property(nonatomic,copy)NSString *addr;
//
////版本号
//@property(nonatomic,copy)NSString *appVersion;
//
////更新标题
//@property(nonatomic,copy)NSString *title;
//
////更新内容 content
//@property(nonatomic,copy)NSString *details;
//
//@property (nonatomic, copy) NSString *downUrl; //!< 下载地址
//
//@property (nonatomic, copy)  NSString *appType;
//
////发布时间
//@property(nonatomic,copy)NSString *createTime;
//
////1：强制更新  2：不强制更新
//@property(nonatomic,copy) NSString *isForcedUpdate;

//升级标题
@property (nonatomic, copy) NSString *title;

//版本号
@property (nonatomic, copy) NSString *num;

//内容
@property (nonatomic, copy) NSString *content;

//下载地址
@property (nonatomic, copy) NSString *apkurl;

//是否强制更新  false:不强更  true:强更',
@property (nonatomic, copy) NSString *isForcedUpdate;
///发布时间
@property (nonatomic,strong) NSString *addtime;

@property (nonatomic,strong) NSString *adtime;


@end

NS_ASSUME_NONNULL_END

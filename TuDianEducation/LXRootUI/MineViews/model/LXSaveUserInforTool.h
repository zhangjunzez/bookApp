//
//  LXSaveUserInforTool.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/6.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXUserInforModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface LXSaveUserInforTool : NSObject
+(instancetype)sharedUserTool;
@property (nonatomic,strong)LXUserInforModel *userInforModel;
///新闻类型数组
@property (nonatomic,strong) NSArray *newsTypeArray;
///城市id
@property (nonatomic,strong) NSString *cityId;
///行业类型
@property (nonatomic,strong) NSArray *hangyeTypeArray;

///客服电话号码
@property (nonatomic,strong) NSString *telNum;
///a
@property (nonatomic,assign) NSInteger medaiType;
@end

NS_ASSUME_NONNULL_END

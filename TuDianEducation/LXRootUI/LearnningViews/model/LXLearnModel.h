//
//  LXLearnModel.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/7.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXLearnModel : NSObject
///技能id
@property (nonatomic,strong) NSString *skillsid;
///标题
@property (nonatomic,strong) NSString *title;
///发布工程师id
@property (nonatomic,strong) NSString *eid;
///发布工程师姓名
@property (nonatomic,strong) NSString *engineername;
///发布工程师头像
@property (nonatomic,strong) NSString *engineericon;
///观看人数
@property (nonatomic,strong) NSString *looknum;
///发布时间
@property (nonatomic,strong) NSString *adtime;
///学习时间
@property (nonatomic,strong) NSString *studytime;
@end

NS_ASSUME_NONNULL_END

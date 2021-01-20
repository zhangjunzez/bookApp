//
//  LXMyTuijianModel.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/9.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 {
   "eid":""//下级工程师id
   "engineername":""//下级工程师名称
   "engineericon":""//下级工程师头像
   "adtime":""//下级注册时间
 }
 {
   "userid":""//下级id
   "username":""//下级昵称
   "userimage":""//下级头像
   "adtime":""//下级注册时间
 }
 */
NS_ASSUME_NONNULL_BEGIN

@interface LXMyTuijianModel : NSObject
@property (nonatomic,strong) NSString *eid;
@property (nonatomic,strong) NSString *engineername;
@property (nonatomic,strong) NSString *engineericon;
@property (nonatomic,strong) NSString *adtime;
@property (nonatomic,strong) NSString *userid;
@property (nonatomic,strong) NSString *username;
@property (nonatomic,strong) NSString *userimage;

@end

NS_ASSUME_NONNULL_END

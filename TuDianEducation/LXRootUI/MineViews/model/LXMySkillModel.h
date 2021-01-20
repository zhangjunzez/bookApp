//
//  LXMySkillModel.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/9.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 {
   "skillsid":""//技能id
   "authstate":""//审核状态 0待审核 1已审核 2审核失败
   "title":""//标题
   "content1":""//段落一
   "content2":""//段落二
   "content3":""//段落三
   "images1":""//图片一
   "images2":""//图片二
   "images3":""//图片三
   "looknum":""//观看人数
   "adtime":""//发布时间
 }
 */
NS_ASSUME_NONNULL_BEGIN

@interface LXMySkillModel : NSObject
@property (nonatomic,strong) NSString*skillsid;
@property (nonatomic,strong) NSString*authstate;
@property (nonatomic,strong) NSString*title;
@property (nonatomic,strong) NSString*content1;
@property (nonatomic,strong) NSString*content2;
@property (nonatomic,strong) NSString*content3;
@property (nonatomic,strong) NSString*images1;
@property (nonatomic,strong) NSString*images2;
@property (nonatomic,strong) NSString*images3;
@property (nonatomic,strong) NSString*looknum;
@property (nonatomic,strong) NSString*adtime;

@property (nonatomic,strong) NSString *studytime;
@property (nonatomic,strong) NSString *tiname;
@property (nonatomic,strong) NSString *tid;

@end

NS_ASSUME_NONNULL_END

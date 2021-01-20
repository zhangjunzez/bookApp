//
//  LXSaveUserInforTool.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/6.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXSaveUserInforTool.h"
#import "LXUserInforModel.h"

@implementation LXSaveUserInforTool
+(LXSaveUserInforTool *)sharedUserTool
{
    
    static LXSaveUserInforTool *sharedSVC=nil;

        static dispatch_once_t onceToken;
        dispatch_once(&onceToken,
        ^{
            
            sharedSVC = [[self alloc] init];
        });
  
    return sharedSVC;
}
-(NSString *)cityId{
    if (!_cityId) {
        //默认
        _cityId = @"0371";
    }
    return _cityId;
}
@end

//
//  AudioServicesManager.h
//  XILAIBANG
//
//  Created by ff on 2019/11/4.
//  Copyright © 2019 大點哥. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger){
    AudioOnly = 1,  // 声音提示
    VibrateOnly,    // 振动提示
    AudioAndVibrate // 声音&振动
}AudioServicesType;
@interface AudioServicesManager : NSObject
@property (nonatomic ,assign) AudioServicesType audioServicesType;
+ (instancetype)sharedManager;
-(void)play:(int)soundid;
@end

NS_ASSUME_NONNULL_END

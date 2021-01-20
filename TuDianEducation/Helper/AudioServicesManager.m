//
//  AudioServicesManager.m
//  XILAIBANG
//
//  Created by ff on 2019/11/4.
//  Copyright © 2019 大點哥. All rights reserved.
//

#import "AudioServicesManager.h"
#import <AudioToolbox/AudioToolbox.h>
//NSString *const kFileUrl = @"sound.caf";
@interface AudioServicesManager()

@property (nonatomic ,assign) SystemSoundID soundID;

@end

@implementation AudioServicesManager

+ (instancetype)sharedManager{
    static AudioServicesManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AudioServicesManager alloc]init];
    });
    return manager;
}
- (instancetype)init{
    self = [super init];
    if (self) {
//        NSString *audioFile=[[NSBundle mainBundle] pathForResource:kFileUrl ofType:nil];
//        NSURL *fileUrl=[NSURL fileURLWithPath:audioFile];
//        AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &_soundID);
    }
    return self;
}
#pragma mark - play
-(void)play:(int)soundid{
//    DYLog(@"%d",_soundID);
    _soundID = soundid;
    switch (_audioServicesType) {
        case AudioOnly:
            [self audioOnly];
            break;
        case VibrateOnly:
            [self vibrateOnly];
            break;
        case AudioAndVibrate:
            [self audioAndVibrate];
            break;
            
        default:
            break;
    }
}
- (void)audioOnly{
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_9_0
    AudioServicesPlaySystemSound(_soundID);
#else
    AudioServicesPlaySystemSoundWithCompletion(_soundID, nil);
#endif
}
- (void)vibrateOnly{
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_9_0
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
#else
    AudioServicesPlaySystemSoundWithCompletion(kSystemSoundID_Vibrate, nil);
#endif
}
- (void)audioAndVibrate{
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_9_0
    AudioServicesPlayAlertSound(_soundID);
#else
    AudioServicesPlayAlertSoundWithCompletion(_soundID,nil);
#endif
}

#pragma mark -
#pragma mark - dealloc
- (void)dealloc{
    DYLog(@"qqqqq");
    AudioServicesRemoveSystemSoundCompletion(_soundID);
    AudioServicesDisposeSystemSoundID(_soundID);
}
@end

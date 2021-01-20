//
//  DYAuthHelper.h
//  XILAIBANG
//
//  Created by ff on 2019/9/3.
//  Copyright © 2019 大點哥. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AuthBlock)(BOOL isFirst);
typedef void(^NoAuthBlock)(BOOL isGoToResetAuth);

@interface DYAuthHelper : NSObject

// 联网权限
+ (void)AuthForNet:(AuthBlock)hasAuthBlock noAuth:(NoAuthBlock)noAuthBlock;
// 推送权限
+ (void)AuthForPush:(AuthBlock)hasAuthBlock noAuth:(NoAuthBlock)noAuthBlock;
// 相机权限
+ (void)AuthForCamera:(AuthBlock)hasAuthBlock noAuth:(NoAuthBlock)noAuthBlock;
// 相册权限
+ (void)AuthForPhotoLibrary:(AuthBlock)hasAuthBlock noAuth:(NoAuthBlock)noAuthBlock;
// 相册写入权限
+ (void)AuthForAddPhotoLibrary:(AuthBlock)hasAuthBlock noAuth:(NoAuthBlock)noAuthBlock;
// 麦克风权限
+ (void)AuthForMicrophone:(AuthBlock)hasAuthBlock noAuth:(NoAuthBlock)noAuthBlock;
// 通讯录权限
+ (void)AuthForContacts:(AuthBlock)hasAuthBlock noAuth:(NoAuthBlock)noAuthBlock;
// 日历权限
+ (void)AuthForCalendar:(AuthBlock)hasAuthBlock noAuth:(NoAuthBlock)noAuthBlock;
// 定位权限
+ (void)AuthForLocation:(id)cotr hasAuthBlock:(AuthBlock)hasAuthBlock noAuth:(NoAuthBlock)noAuthBlock;
// 提醒事项权限
+ (void)AuthForReminder:(AuthBlock)hasAuthBlock noAuth:(NoAuthBlock)noAuthBlock;
//// 媒体资料库权限
//+ (void)AuthForAppleMusic:(AuthBlock)hasAuthBlock noAuth:(NoAuthBlock)noAuthBlock;
@end

NS_ASSUME_NONNULL_END

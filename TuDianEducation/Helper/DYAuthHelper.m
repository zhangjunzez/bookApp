//
//  DYAuthHelper.m
//  XILAIBANG
//
//  Created by ff on 2019/9/3.
//  Copyright © 2019 大點哥. All rights reserved.
//

#import "DYAuthHelper.h"
#import <Photos/Photos.h>
#import <Contacts/Contacts.h>
#import <UserNotifications/UserNotifications.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
#import <CoreTelephony/CTCellularData.h>
#import <AFNetworking.h>
#import <EventKit/EventKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "AppDelegate.h"

typedef NS_ENUM(NSInteger, DYAuthType) {
    DYAuthType_Net = 0,
    DYAuthType_NetWlan,
    DYAuthType_NetWifi,
    DYAuthType_Push,
    DYAuthType_Camera,
    DYAuthType_PhotoLibrary,
    DYAuthType_AddPhotoLibrary,
    DYAuthType_Microphone,
    DYAuthType_Contacts,
    DYAuthType_Calendar,
    DYAuthType_Location,
    DYAuthType_Reminder,
    DYAuthType_Media,
};

@interface DYAuthHelper () <CLLocationManagerDelegate>

@end

@implementation DYAuthHelper
#pragma mark - alert
+ (void)alertWithAuthType:(DYAuthType)type handle:(NoAuthBlock)NoAuthBlock{
    NSString *titleStr;
    switch (type) {
        case DYAuthType_Net:
            titleStr = @"网络访问";
            break;
        case DYAuthType_NetWifi:
            titleStr = @"wifi网络访问";
            break;
        case DYAuthType_NetWlan:
            titleStr = @"蜂窝网络访问";
            break;
        case DYAuthType_Push:
            titleStr = @"推送";
            break;
        case DYAuthType_Camera:
            titleStr = @"相机";
            break;
        case DYAuthType_PhotoLibrary:
            titleStr = @"相册";
            break;
        case DYAuthType_AddPhotoLibrary:
            titleStr = @"相册编辑";
            break;
        case DYAuthType_Microphone:
            titleStr = @"麦克风";
            break;
        case DYAuthType_Contacts:
            titleStr = @"通讯录";
            break;
        case DYAuthType_Calendar:
            titleStr = @"日历";
            break;
        case DYAuthType_Location:
            titleStr = @"定位";
            break;
        case DYAuthType_Reminder:
            titleStr = @"提醒事项";
            break;
        case DYAuthType_Media:
            titleStr = @"媒体资料库";
            break;
            
        default:
            break;
    }
    kDISPATCH_MAIN_THREAD((^{
        UIAlertController *ac;
        if ([titleStr containsString:@"蜂窝网络"] || [titleStr containsString:@"wifi网络"]) {
            ac = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@未被授权使用",titleStr] message:[NSString stringWithFormat:@"请点击'去设置' 或 前往系统-设置-喜来邦 进行设置 亦或者 通过上划屏幕-拉起快捷菜单-开启%@访问",[titleStr containsString:@"蜂窝网络"] == YES ? @"wifi网络":@"蜂窝网络"] preferredStyle:(UIAlertControllerStyleAlert)];
        }else {
            ac = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@未被授权使用",titleStr] message:@"请点击'去设置' 或 前往系统-设置-喜来邦 进行设置" preferredStyle:(UIAlertControllerStyleAlert)];
        }
        
        [ac addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            if (NoAuthBlock) {
                NoAuthBlock(NO);
            }
        }]];
        [ac addAction:[UIAlertAction actionWithTitle:@"去设置" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            if (NoAuthBlock) {
                NoAuthBlock(YES);
            }
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }]];
        if (IS_IPAD) {
            UIPopoverPresentationController *popPresenter = [ac popoverPresentationController];
            popPresenter.sourceView =KEYWINDOW.rootViewController.view;
            popPresenter.sourceRect =KEYWINDOW.rootViewController.view.bounds;
            popPresenter.permittedArrowDirections = UIPopoverArrowDirectionUp;
            [[DYLogicHelper findCurrentViewController] presentViewController:ac animated:YES completion:nil];
        }else{
            [[DYLogicHelper findCurrentViewController] presentViewController:ac animated:YES completion:nil];
        }
    }))
}

#pragma mark -联网权限
+ (void)AuthForNet:(AuthBlock)hasAuthBlock noAuth:(NoAuthBlock)noAuthBlock {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
         int x = [self getNetWorkStatesFromStatusBar];
        //获取联网可达状态
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
//                DYLog(@"NetworkingTypeUnknown");
                break;
            case AFNetworkReachabilityStatusNotReachable:
//                DYLog(@"NetworkingTypeNotReachable");
                if (x == -1) {
//                    DYLog(@"飞行模式/同时关闭蜂窝和wifi");
                    [MBProgressHUD showError:@"当前可能为飞行模式或无网络访问权限,请开启网络使用或检查权限设置"];
                }else {
                    if (x >=0 && x < 4) {
//                        DYLog(@"开的蜂窝,但是没权限");
                    [self alertWithAuthType:DYAuthType_NetWlan handle:^(BOOL isGoToResetAuth) {
                        if (noAuthBlock) {
                            noAuthBlock(isGoToResetAuth);
                        }
                    }];
                    }else if (x == 5) {
//                        DYLog(@"开的wifi,但是没权限");
                        [self alertWithAuthType:DYAuthType_NetWifi handle:^(BOOL isGoToResetAuth) {
                            if (noAuthBlock) {
                                noAuthBlock(isGoToResetAuth);
                            }
                        }];
                    }else if (x == -2) {
                        // 非蜂窝非wifi
                    }
                }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                //                DYLog(@"NetworkingTypeReachableViaWWAN");
            {
                kDISPATCH_ONCE_BLOCK(^{
                    [MBProgressHUD showError:@"当前为非wifi环境,请注意流量消耗"];
                })
                if (hasAuthBlock) {
                    hasAuthBlock(NO);
                }
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
//                DYLog(@"NetworkingTypeReachableViaWiFi");
                if (hasAuthBlock) {
                    hasAuthBlock(NO);
                }
                break;
            default:
//                DYLog(@"NetworkingTypeUnknown");
                break;
        }
    }];

}

+ (int)getNetWorkStatesFromStatusBar{
    NSArray *subviews;
    if([[[UIApplication sharedApplication] valueForKeyPath:@"_statusBar"] isKindOfClass:NSClassFromString(@"UIStatusBar_Modern")]) {
        // iPhone X
        subviews = [[[[[UIApplication sharedApplication] valueForKeyPath:@"_statusBar"] valueForKeyPath:@"_statusBar"] valueForKeyPath:@"foregroundView"] subviews];
        
    } else{
        subviews = [[[[UIApplication sharedApplication] valueForKeyPath:@"_statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    }
    int netType = -1;
    //获取到网络返回码
    for (id child in subviews) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏
            netType = [[child valueForKeyPath:@"dataNetworkType"]intValue];
            switch (netType) {
                case 0:
                    // 蜂窝无网络
                    break;
                case 1:
                    // 2G
                    break;
                case 2:
                    // 3G
                    break;
                case 3:
                    // 4G
                    break;
                case 5:
                {
                    // wifi
                    break;
                default:
                    netType = -2;
                    break;
                }
            }
        }
    }
    return netType;
}

#pragma mark -推送权限
+ (void)AuthForPush:(AuthBlock)hasAuthBlock noAuth:(NoAuthBlock)noAuthBlock {
    if (@available(iOS 10.0, *)) {
        [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay completionHandler:^(BOOL granted, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) {
                    if (hasAuthBlock) {
                        hasAuthBlock(YES);
                    }
                } else {
                    [self alertWithAuthType:DYAuthType_Push handle:^(BOOL isGoToResetAuth) {
                        if (noAuthBlock) {
                            noAuthBlock(isGoToResetAuth);
                        }
                    }];
                }
            });
        }];
    } else  if(@available(iOS 8.0 , *)) {
        UIUserNotificationSettings * setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (setting.types == UIUserNotificationTypeNone) {
            // 没权限
            UIApplication * application = [UIApplication sharedApplication];
            [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil]];
            [application registerForRemoteNotifications];
        }else {
            if (hasAuthBlock) {
                hasAuthBlock(NO);
            }
        }
    }
}
#pragma mark -相机权限
+ (void)AuthForCamera:(AuthBlock)hasAuthBlock noAuth:(NoAuthBlock)noAuthBlock{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted == YES) {
                    if (hasAuthBlock) {
                        hasAuthBlock(YES);
                    }
                } else {
                    [self alertWithAuthType:DYAuthType_Camera handle:^(BOOL isGoToResetAuth) {
                        if (noAuthBlock) {
                            noAuthBlock(isGoToResetAuth);
                        }
                    }];
                }
            });
        }];
    } else if (status == AVAuthorizationStatusAuthorized) {
        if (hasAuthBlock) {
            hasAuthBlock(NO);
        }
    } else {
        [self alertWithAuthType:DYAuthType_Camera handle:^(BOOL isGoToResetAuth) {
            if (noAuthBlock) {
                noAuthBlock(isGoToResetAuth);
            }
        }];
    }
}
#pragma mark -相册权限
+ (void)AuthForPhotoLibrary:(AuthBlock)hasAuthBlock noAuth:(NoAuthBlock)noAuthBlock {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (status == PHAuthorizationStatusAuthorized) {
                    if (hasAuthBlock) {
                        hasAuthBlock(YES);
                    }
                } else {
                    [self alertWithAuthType:DYAuthType_PhotoLibrary handle:^(BOOL isGoToResetAuth) {
                        if (noAuthBlock) {
                            noAuthBlock(isGoToResetAuth);
                        }
                    }];
                }
            });
        }];
    } else if (status == AVAuthorizationStatusAuthorized) {
        
        if (hasAuthBlock) {
            hasAuthBlock(NO);
        }
    } else {
        
        [self alertWithAuthType:DYAuthType_PhotoLibrary handle:^(BOOL isGoToResetAuth) {
            if (noAuthBlock) {
                noAuthBlock(isGoToResetAuth);
            }
        }];
    }
}
#pragma mark -相册写入权限
+ (void)AuthForAddPhotoLibrary:(AuthBlock)hasAuthBlock noAuth:(NoAuthBlock)noAuthBlock{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (status == PHAuthorizationStatusAuthorized) {
                    if (hasAuthBlock) {
                        hasAuthBlock(YES);
                    }
                } else {
                    [self alertWithAuthType:DYAuthType_AddPhotoLibrary handle:^(BOOL isGoToResetAuth) {
                        if (noAuthBlock) {
                            noAuthBlock(isGoToResetAuth);
                        }
                    }];
                }
            });
        }];
    } else if (status == AVAuthorizationStatusAuthorized) {
        if (hasAuthBlock) {
            hasAuthBlock(NO);
        }
    } else {
        [self alertWithAuthType:DYAuthType_AddPhotoLibrary handle:^(BOOL isGoToResetAuth) {
            if (noAuthBlock) {
                noAuthBlock(isGoToResetAuth);
            }
        }];
    }
}
#pragma mark -麦克风权限
+ (void)AuthForMicrophone:(AuthBlock)hasAuthBlock noAuth:(NoAuthBlock)noAuthBlock {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (authStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) {
                    if (hasAuthBlock) {
                        hasAuthBlock(YES);
                    }
                } else {
                    [self alertWithAuthType:DYAuthType_Microphone handle:^(BOOL isGoToResetAuth) {
                        if (noAuthBlock) {
                            noAuthBlock(isGoToResetAuth);
                        }
                    }];
                }
            });
        }];
        
    } else if(authStatus == AVAuthorizationStatusAuthorized){
        if (hasAuthBlock) {
            hasAuthBlock(NO);
        }
    } else {
        [self alertWithAuthType:DYAuthType_Microphone handle:^(BOOL isGoToResetAuth) {
            if (noAuthBlock) {
                noAuthBlock(isGoToResetAuth);
            }
        }];
    }
}

#pragma mark -通讯录权限
+ (void)AuthForContacts:(AuthBlock)hasAuthBlock noAuth:(NoAuthBlock)noAuthBlock{
    CNContactStore * contactStore = [[CNContactStore alloc]init];
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] ;
    if (status== CNAuthorizationStatusNotDetermined) {
        [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error) {
                    if (noAuthBlock) {
                        noAuthBlock(NO);
                    }
                    return;
                }
                if (granted) {
                    if (hasAuthBlock) {
                        hasAuthBlock(YES);
                    }
                } else {
                    [self alertWithAuthType:DYAuthType_Contacts handle:^(BOOL isGoToResetAuth) {
                        if (noAuthBlock) {
                            noAuthBlock(isGoToResetAuth);
                        }
                    }];
                }
            });
        }];
    } else  if (status== CNAuthorizationStatusAuthorized){
        if (hasAuthBlock) {
            hasAuthBlock(NO);
        }
    } else {
        [self alertWithAuthType:DYAuthType_Contacts handle:^(BOOL isGoToResetAuth) {
            if (noAuthBlock) {
                noAuthBlock(isGoToResetAuth);
            }
        }];
    }
}
#pragma mark -日历权限
+ (void)AuthForCalendar:(AuthBlock)hasAuthBlock noAuth:(NoAuthBlock)noAuthBlock{
    EKAuthorizationStatus eventStatus = [EKEventStore  authorizationStatusForEntityType:EKEntityTypeEvent];
    if (eventStatus == EKAuthorizationStatusAuthorized) {
        // 已授权，可使用
        if (hasAuthBlock) {
            hasAuthBlock(NO);
        }
    }else if(eventStatus == EKAuthorizationStatusNotDetermined){
        // 未进行授权选择
        __block  BOOL isGranted = NO;
        __block  NSError *isError;
        EKEventStore *store = [[EKEventStore alloc] init];
        [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
            isGranted = granted;
            isError = error;
            if (granted) {
                if (hasAuthBlock) {
                    hasAuthBlock(YES);
                }
            }else{
                [self alertWithAuthType:DYAuthType_Calendar handle:^(BOOL isGoToResetAuth) {
                    if (noAuthBlock) {
                        noAuthBlock(isGoToResetAuth);
                    }
                }];
            }
        }];
    }else{
        // 未授权
        [self alertWithAuthType:DYAuthType_Calendar handle:^(BOOL isGoToResetAuth) {
            if (noAuthBlock) {
                noAuthBlock(isGoToResetAuth);
            }
        }];
    }
}

#pragma mark -定位权限
+ (void)AuthForLocation:(id)cotr hasAuthBlock:(AuthBlock)hasAuthBlock noAuth:(NoAuthBlock)noAuthBlock; {
    //确定用户的位置服务是否启用,位置服务在设置中是否被禁用
    BOOL enable      =[CLLocationManager locationServicesEnabled];
    NSInteger status =[CLLocationManager authorizationStatus];
    
    if(  !enable || status< 2){
        //尚未授权位置权限
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8){
            //系统位置授权弹窗
            AppDelegate *delegates = (AppDelegate *)[UIApplication sharedApplication].delegate;
            delegates.locationManager = [CLLocationManager new];
            delegates.locationManager.delegate = cotr;
            [delegates.locationManager requestAlwaysAuthorization];
            [delegates.locationManager requestWhenInUseAuthorization];
        }
    }else{
        
        if (status == kCLAuthorizationStatusDenied) {
            
            [self alertWithAuthType:DYAuthType_Location handle:^(BOOL isGoToResetAuth) {
                if (noAuthBlock) {
                    noAuthBlock(isGoToResetAuth);
                }
            }];
        }else{
            if (hasAuthBlock) {
                hasAuthBlock(NO);
            }
        }
    }
}

#pragma mark -提醒事项权限
+ (void)AuthForReminder:(AuthBlock)hasAuthBlock noAuth:(NoAuthBlock)noAuthBlock {
    EKAuthorizationStatus eventStatus = [EKEventStore  authorizationStatusForEntityType:EKEntityTypeReminder];
    if (eventStatus == EKAuthorizationStatusAuthorized) {
        // 已授权，可使用
        if (hasAuthBlock) {
            hasAuthBlock(NO);
        }
    }else if(eventStatus == EKAuthorizationStatusNotDetermined){
        // 未进行授权选择
        __block  BOOL isGranted = NO;
        __block  NSError *isError;
        EKEventStore *store = [[EKEventStore alloc] init];
        [store requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError * _Nullable error) {
            isGranted = granted;
            isError = error;
            if (granted) {
                if (hasAuthBlock) {
                    hasAuthBlock(YES);
                }
            }else{
                [self alertWithAuthType:DYAuthType_Reminder handle:^(BOOL isGoToResetAuth) {
                    if (noAuthBlock) {
                        noAuthBlock(isGoToResetAuth);
                    }
                }];
            }
        }];
    }else{
        // 未授权
        [self alertWithAuthType:DYAuthType_Reminder handle:^(BOOL isGoToResetAuth) {
            if (noAuthBlock) {
                noAuthBlock(isGoToResetAuth);
            }
        }];
    }
}
#pragma mark -媒体资料库权限
+ (void)AuthForAppleMusic:(AuthBlock)hasAuthBlock noAuth:(NoAuthBlock)noAuthBlock {
    
}


@end

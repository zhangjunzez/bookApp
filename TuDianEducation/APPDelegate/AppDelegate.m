//
//  AppDelegate.m
//  TuDianEducation
//
//  Created by 大新的电脑 on 2020/4/3.
//  Copyright © 2020 郑州大點哥. All rights reserved.
//

#import "AppDelegate.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "AvoidCrash.h"

#import "WXApi.h"
#import <Bugly/Bugly.h>

#import <UShareUI/UShareUI.h>
#import <UMCommon/UMCommon.h>

#import <UserNotifications/UserNotifications.h>

#import "SSKJ_TabbarController.h"
#import <AlipaySDK/AlipaySDK.h>

#ifdef DEBUG
BOOL const pushStatus = YES;
#else
BOOL const pushStatus = NO;
#endif
@interface AppDelegate ()<UNUserNotificationCenterDelegate,WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDarkContent];
    SSKJUserDefaultsSET(@"1", @"launch");
    sleep(1.0);
    ///配置写在这里面
    [AMapServices sharedServices].apiKey = @"03ae930fd4bdb46f5213047304738d43";
    
    
#ifdef DEBUG
    [self aviodCreash];

#else
    [self aviodCreash];
    
#endif
    
    [self windowSet];
    
    

    self.window.rootViewController = [SSKJ_TabbarController new];
    
    ///realm
    {
        RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
        NSLog(@"fileURL--------%@", config.fileURL);
        config.schemaVersion = 5;
        [RLMRealmConfiguration setDefaultConfiguration:config];
    }
    
    
    ///微信
    {
//        BOOL ret = [WXApi registerApp:@"" universalLink:@""];
////        BOOL ret = [WXApi registerApp:@"wxf3ed7a84b64973ec" enableMTA:YES];
//        if (!ret) {
//            NSLog(@"WXApi start failed!");
//        }
//        [WXApi startLogByLevel:WXLogLevelNormal logBlock:^(NSString *log) {
//            NSLog(@"log : %@", log);
//        }];
        //cace44f8947eafe765c7c47db93d5a93
    }
    
    ///Bugly
    {
        [Bugly startWithAppId:@""];
    }

    
    ///
    {
       
    }
    
    ///
    {
        
//        [UMConfigure initWithAppkey:@"5eb67a01895ccabdaa00002d" channel:@"App Store"];
//        UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
//        entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionSound|UMessageAuthorizationOptionAlert;
//        if (@available(iOS 10.0, *)) {
//            [UNUserNotificationCenter currentNotificationCenter].delegate=self;
//        } else {
//        }
//
//        [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity     completionHandler:^(BOOL granted, NSError * _Nullable error) {
//            if (granted) {
//            }else{
//            }
//        }];
//        [UMessage openDebugMode:pushStatus];
        
    }
    [UMConfigure initWithAppkey:@"5f85103694846f78a970ad67" channel:@"App Store"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1111169377" appSecret:@"T21OMkNmYRIXH5wE" redirectURL:@"https://com.lxkj.zsgcsgcsd/"];
   // [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1111032243" appSecret:@"IdAQTuhwVgIEaTcK" redirectURL:@"https://com.lxkj.huoyunhuozhu/"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxfc65587bce2cbe67" appSecret:@"7a410d0cb3bcb943acc38d367bd3b1dc" redirectURL:@"https://com.lxkj.zsgcsgcsd/"];
    
    
    [WXApi registerApp:@"wxfc65587bce2cbe67" universalLink:@"https://com.lxkj.zsgcsgcsd/"];
    //
    self.window.rootViewController = [SSKJ_TabbarController new];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application shouldAllowExtensionPointIdentifier:(NSString *)extensionPointIdentifier
{
    if ([extensionPointIdentifier isEqualToString:@"com.apple.keyboard-service"]) {
        
        if ([SSKJUserDefaultsGET(@"thire.keyboard") isEqual:@"0"]) {
            return NO;
        }
        return YES;
    }
    return YES;
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    ///注册 DeviceToken
    if (![deviceToken isKindOfClass:[NSData class]]) return;
   
    
    const unsigned *tokenBytes = (const unsigned *)[deviceToken bytes];
    NSString *hexToken = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                          ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                          ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                          ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    NSLog(@"deviceToken:%@",hexToken);
    kSetDeviceToken(hexToken);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"DeviceToken 获取失败，原因：%@",error);
}

//iOS10以下使用这两个方法接收通知，
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
  
    if([[[UIDevice currentDevice] systemVersion]intValue] < 10){
        //[UMessage didReceiveRemoteNotification:userInfo];
        completionHandler(UIBackgroundFetchResultNewData);
    }
    
    if ([userInfo[@"type"] intValue] == 1) {
        [TDUserDBManager userLoginOut];
        UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
        if ([vc isKindOfClass:[SSKJ_TabbarController class]]) {
            SSKJ_TabbarController *tabbarVC = (SSKJ_TabbarController *)vc;
           UINavigationController *nav = tabbarVC.selectedViewController;
            [nav popToRootViewControllerAnimated:NO];
            [tabbarVC setSelectedIndex:0];
        }
    }
    
    completionHandler(UIBackgroundFetchResultNewData);
    
}

#pragma mark - 提醒用户账号被登录


//iOS10新增：处理前台收到通知的代理方法
//应用活跃
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受
        //关闭U-Push自带的弹出框
     
        
    }else{
        //应用处于前台时的本地推送接受
    }
    //当应用处于前台时提示设置，需要哪个可以设置哪一个
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}


//iOS10新增：处理后台点击通知的代理方法
//从外边点击
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
      //  [UMessage didReceiveRemoteNotification:userInfo];
        
    }else{
        //应用处于后台时的本地推送接受
    }
}


- (void)disposeNotification:(NSDictionary *)userInfo{
    
    DYLog(@"---收到通知:%@", userInfo);
    
    if (!kUserID.length) {
        return;
    }
    
}





-(void)aviodCreash
{
    [AvoidCrash makeAllEffective];
    
    
    //================================================
    //   1、unrecognized selector sent to instance（方式1）
    //================================================
    
    //若出现unrecognized selector sent to instance并且控制台输出:
    //-[__NSCFConstantString initWithName:age:height:weight:]: unrecognized selector sent to instance
    //你可以将@"__NSCFConstantString"添加到如下数组中，当然，你也可以将它的父类添加到下面数组中
    //比如，对于部分字符串，继承关系如下
    //__NSCFConstantString --> __NSCFString --> NSMutableString --> NSString
    //你可以将上面四个类随意一个添加到下面的数组中，建议直接填入 NSString
    
    
    //我所开发的项目中所防止unrecognized selector sent to instance的类有下面几个，主要是防止后台数据格式错乱导致的崩溃。个人觉得若要防止后台接口数据错乱，用下面的几个类即可。
    
    NSArray *noneSelClassStrings = @[
                                     @"NSNull",
                                     @"NSNumber",
                                     @"NSString",
                                     @"NSDictionary",
                                     @"NSArray"
                                     ];
    [AvoidCrash setupNoneSelClassStringsArr:noneSelClassStrings];
    
    
    //================================================
    //   2、unrecognized selector sent to instance（方式2）
    //================================================
    
    //若需要防止某个前缀的类的unrecognized selector sent to instance
    //比如你所开发项目中使用的类的前缀:CC、DD
    //你可以调用如下方法
    [AvoidCrash setupNoneSelClassStringPrefixsArr:@[@"LX",@"UM"]];
}
- (void)windowSet {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    self.window.backgroundColor = [DYColorHelper sysBGColor];
    self.window.backgroundColor = WHITE_COLOR;
    [self.window makeKeyAndVisible];
    
}
///该回调方法仅支持iOS9以上系统
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    return [self callBackResultWithUrl:url options:options];
}
- (BOOL)callBackResultWithUrl:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
        if ([url.host isEqualToString:@"pay"]){ //微信支付的回调
            return  [WXApi handleOpenURL:url delegate:self];
        }
        if ([url.host isEqualToString:@"safepay"]) {
            //跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"支付宝支付result ===== %@",resultDic);
                [[NSNotificationCenter defaultCenter]postNotificationName:@"AlipayPaySend" object:resultDic];
            }];
            return YES;
        }
        if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回 authCode
            [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"支付宝支付result = %@",resultDic);
                [[NSNotificationCenter defaultCenter]postNotificationName:@"AlipayPaySend" object:resultDic];
            }];
            return YES;
        }
    }
    return result;
}

#pragma mark - UISceneSession lifecycle


//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options  API_AVAILABLE(ios(13.0)){
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions  API_AVAILABLE(ios(13.0)){
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}


@end

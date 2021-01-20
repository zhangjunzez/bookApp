//
//  CommonDefine.h
//  SSKJ
//
//  Created by James on 2018/6/13.
//  Copyright © 2018年 James. All rights reserved.
//
///tools

#import "WLTools.h"

#import "UIView+Extension.h"

#import "NotificationDefine.h"
#import "ConfigurationDefine.h"

#import <SDWebImage.h>
#import "MJExtension.h"
//用户数据管理
#import "TDUserModel.h"
#import "TDUserDBManager.h"

#import "LocationTool.h"

//
#import "TDMediaModel.h"
#import "TDMediaManager.h"


#import "TDOSSUploadDataTool.h"

#import "UIImage+Extension.h"
#import "UIImage+direction.h"

#import "UILabel+SSKJ.h"
#import "UIButton+SSKJ.h"
#import "UITextField+SSKJ.h"

#import "CustomGifFooter.h"

#import "CustomGifHeader.h"

#import "SSKJ_NoDataView.h"
// 键盘弹出
#import "IQKeyboardManager.h"
//请求
#import "HttpRequstApiManger.h"

#import "NetWorkTools.h"

#import "MBProgressHUD.h"

#import "MBProgressHUD+FR.h"

#import "SSKJLocalized.h"

#import "URLDefine.h"

#define kPage_Size 10

static NSString * const AppLanguage = @"appLanguage";

#define ScreenWidth     ([[UIScreen mainScreen] bounds].size.width)

#define ScreenHeight    ([[UIScreen mainScreen] bounds].size.height)

#define kUserDefaults [NSUserDefaults standardUserDefaults]

#define kNotificationCenter  [NSNotificationCenter defaultCenter]

#define kUserID [kUserDefaults objectForKey:@"id"]?:@""

#define kToken [kUserDefaults objectForKey:@"uid"]?:@""

#define kMessageSucessShow  [MBProgressHUD showError:@"操作成功"];

#define kLogin [TDUserDBManager userIsLogin]

#define kIsTeacher [[TDUserDBManager userType] intValue] == 1


#define kDeviceToken [[NSUserDefaults standardUserDefaults] objectForKey:@"DeviceToken"] ?:@"0"
#define kSetDeviceToken(token) [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"DeviceToken"]


//各屏幕尺寸比例
#define ScaleW(width)  (width*ScreenWidth/375.f)

//判断是否是ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//判断iPhone4系列
#define kiPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone5系列
#define kiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone6系列
#define kiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iphone6+系列
#define kiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneX
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)

// 判断是否是iPhoneX系列
#define IS_IPHONE_X_ALL (IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES)

//iPhoneX系列
#define Height_StatusBar [UIApplication sharedApplication].statusBarFrame.size.height

#define Height_NavBar ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 88.0 : 64.0)
#define Height_TabBar ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 83.0 : 49.0)
///
#define ImageBaseServer  ProductBaseServer
///
//weakSelf
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self

//写
#define SSKJUserDefaultsSET(object,key) [[NSUserDefaults standardUserDefaults] setObject:object forKey:key]

// 取
#define SSKJUserDefaultsGET(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]?:@""

// 删
#define SSKJUserDefaultsRemove(key) [[NSUserDefaults standardUserDefaults] removeObjectForKey:key]

// 存
#define SSKJUserDefaultsSynchronize [[NSUserDefaults standardUserDefaults] synchronize]

#define kIsX [UIApplication sharedApplication].statusBarFrame.size.height > 20

//获取当前iOS系统版本号
#define kSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]

//获取当前APP版本号
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

// 加密
#define Encrypt(string) [AES_SecurityUtil aes128EncryptWithContent:string]

// 解密
#define Dencrypt(string) [AES_SecurityUtil aes128DencryptWithContent:string]

// 语言国际化
//#define SSKJLocalized(key, comment) [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"]] ofType:@"lproj"]] localizedStringForKey:(key) value:@"" table:nil]
#define SSKJLocalized(key, comment) key
// 语言国际化
#define SSKJLanguage(key) SSKJLocalized(key, nil)

// 语言中文
#define kIsCN [[[SSKJLocalized sharedInstance] currentLanguage] isEqualToString:@"zh-Hans"]

//系统字体对应字号
#define systemFont(x) [UIFont systemFontOfSize:x]

// 粗体
#define systemBoldFont(s) [UIFont fontWithName:@"Helvetica-Bold" size:s]

// 细体
#define systemThinFont(s) [UIFont systemFontOfSize:s weight:UIFontWeightThin]

//对应调整大小后普通字号
#define kFont(x) [UIFont systemFontOfSize:x]

//对应调整大小后粗体字号
#define kBoldFont(x) [UIFont fontWithName:@"Helvetica-Bold" size:ScaleW(x)]

//对应调整大小后细体字号
#define kThinFont(x) [UIFont systemFontOfSize:ScaleW(x) weight:UIFontWeightThin]
///
///腾讯云sdkID
#define sdkAppid 1400466358

///测试腾讯账号
#define tencentAccount [kUserDefaults objectForKey:@"VideoTengcentAccount"]?:@""

///测试腾讯Token
#define tencentToken  [kUserDefaults objectForKey:@"VideoTengcentAccountToken"]?:@""
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

#ifdef DEBUG
//#define SSLog(format, ...) printf("\n%s [第%d行] %s\n", __PRETTY_FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);

#define SSLog(format, ...) NSLog((@"\n%s [第%d行]\n" format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#else
#define SSLog(format, ...)
#endif


#define kFUNCTION SSLog(@"--------");

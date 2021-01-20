//
//  DYLogicHelper.m
//  XILAIBANG
//
//  Created by ff on 2019/9/9.
//  Copyright © 2019 大點哥. All rights reserved.
//

#import "DYLogicHelper.h"
//#import "SSKeychain.h"
#import <CommonCrypto/CommonCrypto.h>
#import "DYKeychainHelper.h"
#import <AVFoundation/AVFoundation.h>
//#import <DongtuStoreSDK/DongtuStoreSDK.h>
@implementation DYLogicHelper

// 适配(文字,等等)
+(CGFloat)sizeFitWithiphoneTypeByMaxValue:(CGFloat)mv {
    if (iPhone5SE) {
        return mv*0.64;
    }else if (iPhone6_6s) {
        return mv*0.8;
    }else if (iPhone6Plus_6sPlus) {
        return mv;
    }else if (iPhoneX) {
        return mv;
    }else if (iPhoneXSMax) {
        return mv;
    }else {
        
    }
    return mv;
}

// toast
//+(void)showMsg:(NSString *)msg {
//    DYProgressHUDConfig *config = [DYProgressHUDConfig new];
//    config.boardColor = UIColorRGBA(0, 0, 0, 0.5);
//    config.contentColor = WHITE_COLOR;
//    [DYProgressHUD makeConfig:config];
//    [MBProgressHUD showError:msg];
//}

//+ (NSString *)uuidString {
//    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
//    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
//    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
//    CFRelease(uuid_ref);
//    CFRelease(uuid_string_ref);
//    [SSKeychain setPassword: [NSString stringWithFormat:@"%@", [uuid lowercaseString]]
//                 forService:KEYCHAIN_SERVICE account:@"PTuuid"];
//    return [uuid lowercaseString];
//}

+ (UIViewController *)findCurrentViewController {
    UIWindow* window = nil;
    if (@available(iOS 13.0, *)){
        for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive){
                window = windowScene.windows.firstObject;
                break;
            }
        }
    }else{
        window = [UIApplication sharedApplication].keyWindow;
    }
    UIViewController *topViewController = [window rootViewController];
    while (true) {
        if (topViewController.presentedViewController) {
            topViewController = topViewController.presentedViewController;
        } else if ([topViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)topViewController topViewController]) {
            topViewController = [(UINavigationController *)topViewController topViewController];
        } else if ([topViewController isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tab = (UITabBarController *)topViewController;
            topViewController = tab.selectedViewController;
        } else {
            break;
        }
    }
    return topViewController;
}

#pragma mark -退登
+(void)quit {
//    [JMSGUser logout:^(id resultObject, NSError *error) {
//
//    }];
    
    [DYRealmHelper newRefreshToken:nil AccessToken:nil];
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary]
                                objectForKey:@"CFBundleShortVersionString"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:currentVersion forKey:LAST_RUN_VERSION_KEY];
//    [KEYWINDOW setRootViewController:[DYLoginHomeViewController new]];
}

// 表情云配置
+(void)DTSet:(nullable NSString *)uid {
//    if (uid != nil) {
//        DTUser *user  = [DTUser new];
//        user.userId = uid;
//        DongtuStore *store = [DongtuStore sharedInstance];
//        [store setUser:user];
//        [store setSdkLanguage:[[[DY_LanguageManager shareManager]currentLanguage]isEqualToString:@"Chinese"]==YES?DTLanguageChinese:DTLanguageEnglish];
//    }else {
//        [[DongtuStore sharedInstance]setUser:nil];
//    }
    
}

// 首次登录
+ (BOOL) isFirstLoad{
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary]
                                objectForKey:@"CFBundleShortVersionString"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastRunVersion = [defaults objectForKey:LAST_RUN_VERSION_KEY];
    if (!lastRunVersion) {
        [defaults setObject:currentVersion forKey:LAST_RUN_VERSION_KEY];
        return YES;
    }
    if (![lastRunVersion isEqualToString:currentVersion]) {
        [defaults setObject:currentVersion forKey:LAST_RUN_VERSION_KEY];
        return YES;
    }
    return NO;
}

+ (BOOL) isFirstLoadwithOutChageState{
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary]
                                objectForKey:@"CFBundleShortVersionString"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastRunVersion = [defaults objectForKey:LAST_RUN_VERSION_KEY];
    if (!lastRunVersion) {
        return YES;
    }
    if (![lastRunVersion isEqualToString:currentVersion]) {
        // 新版本不用清token
        return NO;
    }
    return NO;
}

#pragma mark - 32位 小写
+(NSString *)MD5ForLower32Bate:(NSString *)str{
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) { [digest appendFormat:@"%02x", result[i]]; } return digest; }
#pragma mark - 32位 大写
+(NSString *)MD5ForUpper32Bate:(NSString *)str{
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2]; for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }
    return digest;
}
#pragma mark - 16位 大写
+(NSString *)MD5ForUpper16Bate:(NSString *)str{ NSString *md5Str = [self MD5ForUpper32Bate:str];
    NSString *string; for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    } return string;
}
#pragma mark - 16位小写
+(NSString *)MD5ForLower16Bate:(NSString *)str{
    NSString *md5Str = [self MD5ForLower32Bate:str];
    NSString *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    } return string;
}

// 签名
+(NSString *)signStr:(NSMutableDictionary*)dict {
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [dict allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        if (![[NSString stringWithFormat:@"%@",[dict objectForKey:categoryId]] isEqualToString:@""]
            && ![[NSString stringWithFormat:@"%@",[dict objectForKey:categoryId]] isEqualToString:@"sign"]
            && ![[NSString stringWithFormat:@"%@",[dict objectForKey:categoryId]] isEqualToString:@"key"]
            ){
            [contentString appendFormat:@"%@=%@&", categoryId, [dict objectForKey:categoryId]];
        }
    }
    if ([contentString hasSuffix:@"&"]) {
        [contentString replaceCharactersInRange:(NSMakeRange(contentString.length-1, 1)) withString:@""];
    }
    //HMACMD5
    //    DYLog(@"----%@",contentString);
    NSString *signStr = [DYLogicHelper MD5ForUpper32Bate:contentString];
    return signStr;
}

+(NSString *)getNowTimestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    return timeSp;
}

+(NSString *)getNowTimestamp10{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    return timeSp;
}

+ (BOOL)isBlankString:(NSString *)string{
    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+(NSString*)getCurrentTimes{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制

    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];

    //现在时间,你可以输出来看下是什么格式

    NSDate *datenow = [NSDate date];

    //----------将nsdate按formatter格式转成nsstring

    NSString *currentTimeString = [formatter stringFromDate:datenow];

    DYLog(@"currentTimeString =  %@",currentTimeString);

    return currentTimeString;

}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding]; NSError *err; NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        DYLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+ (NSData *)JSONData:(id)obj{
    return [NSJSONSerialization dataWithJSONObject:obj options:0 error:nil];
}

+ (NSString *)JSONString:(id)obj{
    if (![NSJSONSerialization isValidJSONObject:obj]) {
        return @"";
    }
    return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
}

+ (id)objectFromJSONString:(NSString *)jsonString{
    return [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
}

+ (nullable id)objectFromJSONData:(nullable NSData *)jsonData{
    return [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
}

//传入 秒  得到  xx分钟xx秒
+ (NSString *)getMMSSFromSS:(NSString *)totalTime{
    NSInteger seconds = [totalTime integerValue];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",seconds/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    //    NSLog(@"format_time : %@",format_time);
    return format_time;
}

// 图片格式
+ (NSString *)typeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
    case 0xFF:
    return @"jpeg";
    case 0x89:
    return @"png";
    case 0x47:
    return @"gif";
    case 0x49:
    case 0x4D:
    return @"tiff";
    }
    return nil;
}

+ (UIImage *)xy_getVideoThumbnail:(NSData *)data
{
    NSURL *sourceURL = [NSURL URLWithDataRepresentation:data relativeToURL:nil];
    AVAsset *asset = [AVAsset assetWithURL:sourceURL];
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc]initWithAsset:asset];
    imageGenerator.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMake(0, 1);
    NSError *error;
    CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:NULL error:&error];
    UIImage *thumbnail = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);  // CGImageRef won't be released by ARC
    return thumbnail;
}

+ (NSString *)getVideoTimeByUrlString:(NSString*)urlString {
    NSURL*videoUrl = [NSURL URLWithString:urlString];
    AVURLAsset *avUrl = [AVURLAsset assetWithURL:videoUrl];
    CMTime time = [avUrl duration];
    long seconds = ceil(time.value/time.timescale);
    return [self getMMSSFromSS:[NSString stringWithFormat:@"%ld",seconds]];
}



+ (BOOL) isEqualToColor:(UIColor*)colorA anotherColor:(UIColor*)colorB
{
    if (CGColorEqualToColor(colorA.CGColor, colorB.CGColor)) {
        return YES;
   }else {
           return NO;
   }
}

+(NSString *)getTimeFromTimestamp:(double)time{
    NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter * formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *timeStr=[formatter stringFromDate:myDate];
    return timeStr;
}

@end

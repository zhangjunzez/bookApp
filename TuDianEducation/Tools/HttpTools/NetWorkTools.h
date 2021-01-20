//
//  NetWorkTools.h
//  iOSStudy
//
//  Created by chenguandong on 15/1/31.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPSessionManager.h>

//李鹏本地
//static NSString *const kBaseUrlIP = @"http://122.114.49.11:9008";
//
//static NSString *const kBaseUrl = @"http://122.114.49.11:9008/lazycityorder/api/service?";
//
//static NSString *const kImgBaseUrl = @"http://122.114.49.11:9008/lazycityorder/api/addimg";
//
//static NSString *const kImgBaseUrls = @"http://122.114.49.11:9008/lazycityorder/api/addimgs";

//服务器地址
static NSString *const kBaseUrlIP = @"http://139.224.73.213";

static NSString *const kBaseUrl = @"http://139.224.73.213/supplyanddemand/api";

static NSString *const kImgBaseUrl = @"http://139.224.73.213/supplyanddemand/api/uploadoneFile";

static NSString *const kImgBaseUrls = @"http://139.224.73.213/supplyanddemand/api/uploadmanyFile";



static NSString *const kSMSBaseUrl = @"https://v.juhe.cn/sms/send";

static NSString *const KShareUrl = @"http://feigexinxi.com/index";


typedef void(^isNetwork) (BOOL isNetwork);

typedef void(^success)(NSURLSessionDataTask *task, id responseObject) ;
typedef void(^error)(NSURLSessionDataTask *task, NSError *error);

@interface NetWorkTools : NSObject



+ (instancetype)sharedInstance;

///**
// *  从SSKeychain 获取用户名密码
// *
// *  @param userName 用户名
// *  @param password 密码
// */
//+(void)getUserNameAndPassWordFromSSKeychain:(void(^)(NSString*userName)) userName password:(void(^)(NSString*password))password;


/**
 *  SMS
 *
 *  @param parameters   <#parameters description#>
 *  @param success      <#success description#>
 *  @param error        <#error description#>
 *  @param isNetworking <#isNetworking description#>
 */
+(void)postHttpToSMS :(id)parameters success:(success)success error:(error)error isNetworking:(isNetwork)isNetworking;

#pragma mark - 发送图片
+(void)postHttpImgFile :(id)parameters  firstName:(NSString *)firstName  firstImageArr:(UIImage*)imgArr success:(success)success error:(error)error isNetworking:(isNetwork)isNetworking;
//多张
+(void)postHttpMoreImagess:(NSString *)firstName  firstImageArr:(NSArray*)imgArr success:(success)success error:(error)error isNetworking:(isNetwork)isNetworking;

#pragma mark - 发送多张图片
+(void)postHttpMoreImage:(NSString *)firstName  firstImageArr:(NSArray*)imgArr success:(success)success error:(error)error isNetworking:(isNetwork)isNetworking;

#pragma mark - 上传视频
+(void)postHttpVideo:(NSString *)firstName  firstImageArr:(UIImage*)image  withData:(NSData *)data success:(success)success error:(error)error isNetworking:(isNetwork)isNetworking;

+ (void)postConJSONWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)(NSError * error))fail;
/**
 *  发送请求
 *
 *  @param parameters   参数
 fileName   路径名
 *  @param success      成功回调
 *  @param error        失败回调
 *  @param isNetworking 网络回调
 */
+ (void)postImageAddDataWith:(id)parm filName:(NSString *)fileName ImageArr:(UIImage*)img withIconKey:(NSString *)key success:(success)success error:(error)error isNetworking:(isNetwork)isNetworking;

/**
 *  发送Http请求
 *
 *  @param parameters   参数
 *  @param success      成功回调
 *  @param error        失败回调
 *  @param isNetworking 网络回调
 */
+(void)postHttp :(id)parameters success:(success)success error:(error)error isNetworking:(isNetwork)isNetworking;

/**
 *  上传图片请求
 *
 *  @param parameters   参数
 *  @param success      成功回调
 *  @param error        失败回调
 *  @param isNetworking 网络回调
 */
+(void)postHttpForImageUpload :(id)parameters success:(success)success error:(error)error isNetworking:(isNetwork)isNetworking ;

+(void)postHttpForFileUpload :(id)parameters  firstName:(NSString *)firstName  firstImageArr:(NSArray<UIImage*>*)firstImageArr secondName:(NSString *)secondName  secondImageArr:(NSArray<UIImage*>*)secondImageArr businessLogoName:(NSString *)businessLogoName  businessLogoImageArr:(NSArray<UIImage*>*)businessLogoImageArr wechatName:(NSString *)wechatName  wechatImageArr:(NSArray<UIImage*>*)wechatImageArr success:(success)success error:(error)error isNetworking:(isNetwork)isNetworking;
+(void)postHttpForFileUpload :(id)parameters  firstName:(NSString *)firstName  firstImageArr:(NSArray<UIImage*>*)firstImageArr secondName:(NSString *)secondName  secondImageArr:(NSArray<UIImage*>*)secondImageArr  success:(success)success error:(error)error isNetworking:(isNetwork)isNetworking;
/*
 *检查网络连接注册通知
 */
+(void)checkNetworking:(isNetwork)isNetwork;



/**
 *  上传多图片
 *
 *  @param parameters   参数
 *  @param success      成功回调
 *  @param error        失败回到
 *  @param isNetworking 没有网络回调
 */
+(void)postHttpForFileUpload :(id)parameters  name:(NSString *)name  imageArr:(NSArray<UIImage*>*)imageArr success:(success)success error:(error)error isNetworking:(isNetwork)isNetworking;

+ (void)getWuLiuXinXi:(NSString *)url withDict:(id)parameters success:(success)success error:(error)error;


    
@end

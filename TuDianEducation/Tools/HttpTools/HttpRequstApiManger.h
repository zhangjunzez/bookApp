//
//  HttpRequstApiManger.h
//  TuDianEducation
//
//  Created by 张本超 on 2020/4/10.
//  Copyright © 2020 郑州大點哥. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,RequestType){
    
    RequestTypeGet,
    RequestTypePost,
    RequestTypeDelete
    
};

typedef void(^CallBack)(id responseObject);
typedef void(^RequestFailure)(NSError *error) ;


@interface HttpRequstApiManger : NSObject

//单例类创建方法


+ (instancetype)shareManager;

/**
 * 取消所有网络请求
 */

-(void)cancleAllTask;


/**
 *  第三方AFNetWorking请求接口
 *  @param URLString  请求的URL
 *  @param parameters      登录需要传的参数   字典形式，若为Get请求可传空
 *  @param type       请求方式(GET,POST)
 *  @param success    成功回调,id对象 自行转换数组或字典
 *  @param failure    失败回调,返回NSError对象
 */

//用AFNetWorking第三方请求接口 （带请求头)
- (void)requestWithURL_HTTPCode:(NSString*)URLString RequestType:(RequestType )type Parameters:(NSDictionary*)parameters Success:(void(^)(NSInteger statusCode,id responseObject))success Failure:(void(^)(NSError *error,NSInteger statusCode,id responseObject))failure;

/**
 *  系统自带Get请求接口
 *  @param path  请求的URL
 *  @param params      登录需要传的参数   字典形式，若为Get请求可传空
 *  @param callback    成功回调,id对象 自行转换数组或字典
 *  @param failure     失败回调,返回NSError对象
 */

//用系统自带的NSURLSession请求 GET接口
-(void)getddByUrlPath:(NSString *)path
            andParams:(NSString *)params
             CallBack:(CallBack)callback
              Failure:(RequestFailure)failure;


/**
 *  系统自带POST请求接口
 *  @param path  请求的URL
 *  @param params      登录需要传的参数   字典形式，若为Get请求可传空
 *  @param callback    成功回调,id对象 自行转换数组或字典
 *  @param failure     失败回调,返回NSError对象
 */
//用系统自带的请求   POST请求
-(void)postddByByUrlPath:(NSString *)path
                  Params:(NSDictionary*)params
                CallBack:(CallBack)callback
                 Failure:(void(^)(NSError *error))failure;


/**
 *  第三方AFNetWorking图片上传接口
 *  @param URLString   请求的URL
 *  @param imageName   上传图片名
 *  @param params      登录需要传的参数   字典形式，若为Get请求可传空
 *  @param image       要上传的图片
 *  @param callback    成功回调,id对象 自行转换数组或字典
 *  @param failure     失败回调,返回NSError对象
 */


-(void)upLoadImageByUrl:(NSString *)URLString
              ImageName:(NSString*)imageName
                 Params:(NSDictionary *)params
                  Image:(UIImage*)image
               CallBack:(CallBack)callback
                Failure:(void(^)(NSError *error))failure;

/**
 *  第三方AFNetWorking图片上传接口
 *  @param URLString   请求的URL
 *  @param ImageNameArray   上传图片名
 *  @param params      登录需要传的参数   字典形式，若为Get请求可传空
 *  @param image       要上传的图片
 *  @param callback    成功回调,id对象 自行转换数组或字典
 *  @param failure     失败回调,返回NSError对象
 */


-(void)upLoadImageByUrl:(NSString *)URLString
              ImageNameArray:(NSArray *)imageNameArray
                 Params:(NSDictionary *)params
                  Image:(UIImage*)image
               CallBack:(CallBack)callback
                Failure:(void(^)(NSError *error))failure;

/**
 *  第三方AFNetWorking图片上传接口
 *  @param URLString   请求的URL
 *  @param params      登录需要传的参数   字典形式，若为Get请求可传空
 *  @param imageDic    要上传的图片以及对应字段
 *  @param callback    成功回调,id对象 自行转换数组或字典
 *  @param failure     失败回调,返回NSError对象
 */


-(void)upLoadImageByUrl:(NSString *)URLString
                 Params:(NSDictionary *)params
               imageDic:(NSDictionary *)imageDic
               CallBack:(CallBack)callback
                Failure:(void(^)(NSError *error))failure;


//监测网络的可链接性
-(BOOL) netWorkReachability;


/**
 application/json EOS币种请求
 */
- (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
@end


NS_ASSUME_NONNULL_END

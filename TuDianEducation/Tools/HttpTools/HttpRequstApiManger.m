//
//  HttpRequstApiManger.m
//  TuDianEducation
//
//  Created by 张本超 on 2020/4/10.
//  Copyright © 2020 郑州大點哥. All rights reserved.
//

#import "HttpRequstApiManger.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "SSKJ_Logout_AlertView.h"
#import "WL_Network_Model.h"
#define TimeOutSecond 30

@interface HttpRequstApiManger ()
@property (nonatomic, strong) SSKJ_Logout_AlertView *logoutAlertView;
@end

@implementation HttpRequstApiManger

#pragma mark - 创建单例方法
+ (instancetype)shareManager
{
    static HttpRequstApiManger *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HttpRequstApiManger alloc]init];
    });
    return manager;
}

#pragma mark - 取消所有网络请求
-(void)cancleAllTask
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.operationQueue cancelAllOperations];
}


#pragma mark - 第三方AFNetWorking请求接口
/**
 *  第三方AFNetWorking请求接口
 *  @param URLString  请求的URL
 *  @param parameters      登录需要传的参数   字典形式，若为Get请求可传空
 *  @param type       请求方式(GET,POST)
 *  @param success    成功回调,id对象 自行转换数组或字典
 *  @param failure    失败回调,返回NSError对象
 */
- (void)requestWithURL_HTTPCode:(NSString*)URLString RequestType:(RequestType )type Parameters:(NSDictionary*)parameters Success:(void(^)(NSInteger statusCode,id responseObject))success Failure:(void(^)(NSError *error,NSInteger statusCode,id responseObject))failure{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 30;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",nil];
    
    //获取当前APP时间戳
    NSString *currentTimeStamp=[WLTools getOrderTrSeq];
    //获取当前处理后的时间戳
    NSString *TimeStamp=[NSString stringWithFormat:@"%lld",[currentTimeStamp longLongValue]];
    //获取当前设置UUID
    NSString *Uuid=[WLTools getIPhoneUUID];
    //获取处理后的TOKEN
    NSString *Token= @"";//[[SSKJ_User_Tool sharedUserTool] getToken];
    if ([Token isEqual:[NSNull null]] || Token == nil) {
        Token = @"";
    }
    NSString *userID = kUserID;
    if ([userID isEqual:[NSNull null]] || userID == nil) {
        userID = @"";
    }
    
    
    NSString *language = @"";//[[SSKJLocalized sharedInstance]currentLanguage];
    NSString *languageType;
    if ([language isEqualToString:@"en"]) {
        languageType = @"eu";
    }else if ([language isEqualToString:@"zh-Hant"]) {
        languageType = @"tw";
    }else if ([language isEqualToString:@"ko"]) {
        languageType = @"kr";
    }else if ([language isEqualToString:@"ja"]) {
        languageType = @"jp";
    }else{
        languageType = @"cn";
    }
    
    //模拟头部参数数据
    [manager.requestSerializer setValue:TimeStamp forHTTPHeaderField:@"Timestamp"];
    [manager.requestSerializer setValue:Token forHTTPHeaderField:@"token"];
    [manager.requestSerializer setValue:userID forHTTPHeaderField:@"loginUserId"];
    [manager.requestSerializer setValue:@"APP" forHTTPHeaderField:@"systemType"];
    [manager.requestSerializer setValue:kAppVersion forHTTPHeaderField:@"version"];
    [manager.requestSerializer setValue:languageType forHTTPHeaderField:@"language"];
    //设备唯一标识
    [manager.requestSerializer setValue:Uuid forHTTPHeaderField:@"uuid"];
    NSMutableDictionary *pams = [NSMutableDictionary dictionary];
           
           [pams setValuesForKeysWithDictionary:parameters];
           
           if (kLogin) {
               [pams setObject:kToken forKey:@"uid"];
           }
           
           parameters = pams;

           URLString = [NSString stringWithFormat:@"%@/%@",kBaseUrl,URLString];
//    SSLog(@"\r头部请求参数：%@",manager.requestSerializer.HTTPRequestHeaders);
    SSLog(@"\rURL:%@\n请求参数：%@", URLString, parameters);
    WS(weakSelf);
    if (type == RequestTypeGet)
    {
        [manager GET:URLString parameters:parameters headers:@{} progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              
              NSHTTPURLResponse *res = (NSHTTPURLResponse *)task.response;
              
              if (success)
              {
                  WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
                  
                  if ([network_Model.result integerValue]==401)
                  {
                      //[MBProgressHUD showError:network_Model.msg];
        
                      [weakSelf showLogoutViewWithMessage:network_Model.resultNote];
                      
                      NSMutableDictionary *res = [NSMutableDictionary dictionaryWithDictionary:responseObject];
                      [res setObject:@"" forKey:@"msg"];
                      
                      responseObject = res;
                  }
                  
                  success(res.statusCode,responseObject);
                  
                  if (network_Model.resultNote.length == 0 && network_Model.result.integerValue != 200) {
                      [MBProgressHUD showError:SSKJLocalized(@"网络异常",nil)];
                  }
              }
              
          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
    }
    else if(type == RequestTypeDelete)
    {
        [manager DELETE:URLString parameters:parameters headers:@{} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSHTTPURLResponse *res = (NSHTTPURLResponse *)task.response;
            if (success)
            {
                success(res.statusCode,responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSHTTPURLResponse *res = (NSHTTPURLResponse *)task.response;
            //失败error也通过block传出
            if (failure)
            {
                failure(error,res.statusCode,res);
            }
        }];
    }
    else
    {
        
        [manager POST:URLString parameters:parameters headers:@{} progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSHTTPURLResponse *res = (NSHTTPURLResponse *)task.response;
            if (success)
            {
                WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
               
                if ([network_Model.result integerValue]==401)
                {
                    //[MBProgressHUD showError:network_Model.msg];

                    [weakSelf showLogoutViewWithMessage:network_Model.resultNote];
                    
                    NSMutableDictionary *res = [NSMutableDictionary dictionaryWithDictionary:responseObject];
                    [res setObject:@"" forKey:@"msg"];
                    
                    responseObject = res;
                }
                
                success(res.statusCode,responseObject);
                
                if (network_Model.resultNote.length == 0 && network_Model.result.integerValue != 200) {
                    [MBProgressHUD showError:SSKJLocalized(@"网络异常",nil)];
                }
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSHTTPURLResponse *res = (NSHTTPURLResponse *)task.response;
            if (failure)
            {
                failure(error,res.statusCode,res);
            }
        }];
        
    }
}



/**
 application/json EOS币种请求
 */
- (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    
    if (params == nil) {
        params = [[NSDictionary alloc] init];
    }
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:params error:nil];
    
    NSString *Token=  @"";
    if ([Token isEqual:[NSNull null]] || Token == nil) {
        Token = @"";
    }
    [request setTimeoutInterval:30.0];
    [request setValue:Token forHTTPHeaderField:@"token"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    if ([[SSKJLocalized sharedInstance].currentLanguage isEqualToString:@"en"])
    {
        [request setValue:@"en" forHTTPHeaderField:@"language"];
    }
    else
    {
        [request setValue:@"ch" forHTTPHeaderField:@"language"];
    }
    
    
    
    
    // 2.发送请求
    SSLog(@"请求地址:%@\n请求Token:%@",url,Token);
    
    // 2.发送请求
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            //            WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
            
            //            if ([network_Model.status isEqualToString:@"-401"] || [network_Model.status isEqualToString:@"-403"])
            //            {
            //                [TigerSwitchHelper switchLoginViewController:[DCURLRouter sharedDCURLRouter].currentViewController];
            
            //            }else{
            //
            if (success)
            {
                success(responseObject);
            }
            //            }
            
        }else{
            //网络错误
            if (failure) {
                failure(error);
                //                [MBProgressHUD showError:NetError];
                
            }
        }
    }];
    
    [task resume];
}
-(SSKJ_Logout_AlertView *)logoutAlertView
{
    if (nil == _logoutAlertView) {
        _logoutAlertView = [[SSKJ_Logout_AlertView alloc]init];
        _logoutAlertView.confirmBlock = ^{
            NSDictionary *dic = [NSDictionary dictionaryWithObject:@"401" forKey:@"status"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginToken" object:nil userInfo:dic];
        };
    }
    return _logoutAlertView;
}

-(void)showLogoutViewWithMessage:(NSString *)message
{
    if (!self.logoutAlertView.isShow) {
        [self.logoutAlertView showWithMessage:message];
    }
}

#pragma mark - 系统自带Get请求接口
/**
 *  系统自带Get请求接口
 *  @param path  请求的URL
 *  @param params      登录需要传的参数   字典形式，若为Get请求可传空
 *  @param callback    成功回调,id对象 自行转换数组或字典
 *  @param failure     失败回调,返回NSError对象
 */
-(void)getddByUrlPath:(NSString *)path andParams:(NSString *)params CallBack:(CallBack)callback Failure:(RequestFailure)failure{
    
    if (params)
    {
        [path stringByAppendingString:[NSString stringWithFormat:@"?%@",params]];
    }
    
    NSString*  pathStr = [path  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:pathStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.timeoutInterval = TimeOutSecond;
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          
                                          
                                          id jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:Nil];
                                          
                                          if (callback)
                                          {
                                              callback(jsonData);
                                          }
                                          
                                          if (error)
                                          {
                                              
                                              if (failure)
                                              {
                                                  failure(error);
                                              }
                                          }
                                      });
                                  }];
    [task resume];
}

#pragma mark - 系统自带POST请求接口
/**
 *  系统自带POST请求接口
 *  @param path  请求的URL
 *  @param params      登录需要传的参数   字典形式，若为Get请求可传空
 *  @param callback    成功回调,id对象 自行转换数组或字典
 *  @param failure     失败回调,返回NSError对象
 */
-(void)postddByByUrlPath:(NSString *)path Params:(NSDictionary*)params CallBack:(CallBack)callback Failure:(void(^)(NSError *error))failure{
    
    NSURL *url = [NSURL URLWithString:path];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval = TimeOutSecond;
    [request setHTTPMethod:@"POST"];
    
    if ([NSJSONSerialization isValidJSONObject:params])
    {
        NSData *jsonData = [self getDataFromDic:params];
        [request  setHTTPBody:jsonData];
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                id  jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:Nil];
                
                if (callback)
                {
                    callback(jsonData);
                }
                
                if (error)
                {
                    if (failure)
                    {
                        failure(error);
                    }
                }
            });
        }];
        //开始请求
        [task resume];
    }
}

#pragma mark - 数据字典转换二进制流
- (NSData*)getDataFromDic:(NSDictionary *)dic
{
    NSString *string = nil;
    NSArray *array = [dic allKeys];
    for (int i = 0; i<array.count; i++)
    {
        NSString *key = [array objectAtIndex:i];
        NSString *value = [dic valueForKey:key];
        if (i == 0)
        {
            string = [NSString stringWithFormat:@"%@=%@",key,value];
        }
        else
        {
            string = [NSString stringWithFormat:@"%@&%@=%@",string,key,value];
        }
    }
    return [string dataUsingEncoding:NSUTF8StringEncoding];
}

#pragma mark - 第三方AFNetWorking图片上传接口
/**
 *  第三方AFNetWorking图片上传接口
 *  @param URLString   请求的URL
 *  @param imageName   上传图片名
 *  @param params      登录需要传的参数   字典形式，若为Get请求可传空
 *  @param image       要上传的图片
 *  @param callback    成功回调,id对象 自行转换数组或字典
 *  @param failure     失败回调,返回NSError对象
 */
-(void)upLoadImageByUrl:(NSString *)URLString ImageName:(NSString*)imageName Params:(NSDictionary *)params Image:(UIImage*)image CallBack:(CallBack)callback Failure:(void(^)(NSError *error))failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    
    //获取当前APP时间戳
    NSString *currentTimeStamp=[WLTools getOrderTrSeq];
    
    //获取当前处理后的时间戳
    NSString *TimeStamp=[NSString stringWithFormat:@"%lld",[currentTimeStamp longLongValue]];
    
    //获取当前设置UUID
    NSString *Uuid=[WLTools getIPhoneUUID];
    
    //    //获取处理后的TOKEN
    NSString *Token=@"";
    
    //    //获取用户的UID
    NSString *Account=@"";
    
    
    //模拟头部参数数据
    
    [manager.requestSerializer setValue:TimeStamp forHTTPHeaderField:@"Timestamp"];
    
    [manager.requestSerializer setValue:Token forHTTPHeaderField:@"token"];
    
    [manager.requestSerializer setValue:Account forHTTPHeaderField:@"account"];
    
    [manager.requestSerializer setValue:@"IOS" forHTTPHeaderField:@"platform"];
    
    [manager.requestSerializer setValue:kAppVersion forHTTPHeaderField:@"version"];
    
    //设备唯一标识
    [manager.requestSerializer setValue:Uuid forHTTPHeaderField:@"uuid"];
    
    [manager POST:URLString parameters:params headers:@{} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData*  imageData = UIImageJPEGRepresentation(image, 0.8);
        [formData appendPartWithFileData:imageData name:imageName fileName:[NSString stringWithFormat:@"image.jpg"] mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (callback)
        {
            callback(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure)
        {
            failure(error);
        }
    }];
    
   
}

-(void)upLoadImageByUrl:(NSString *)URLString
         ImageNameArray:(NSArray *)imageNameArray
                 Params:(NSDictionary *)params
                  Image:(UIImage*)image
               CallBack:(CallBack)callback
                Failure:(void(^)(NSError *error))failure
{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer.timeoutInterval = TimeOutSecond;
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",nil];
    
    
    //获取处理后的TOKEN
    NSString *Token=@"";
    
    [manager.requestSerializer setValue:Token forHTTPHeaderField:@"token"];
    
    [manager POST:URLString parameters:params headers:@{} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    
            for (int i = 0; i < imageNameArray.count; i++) {
                UIImage *image = [imageNameArray objectAtIndex:i];
                NSData *data = UIImageJPEGRepresentation(image, .1);
                [formData appendPartWithFileData:data
                                            name:[NSString stringWithFormat:@"imgs%d",i+1]
                                        fileName:[NSString stringWithFormat:@"image%d.png",i+1]
                                        mimeType:@"image/png"];
            }
    
        } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (callback)
        {
            callback(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure)
        {
            failure(error);
        }
    }];
    
}






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
                Failure:(void(^)(NSError *error))failure{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    
    //获取当前APP时间戳
    NSString *currentTimeStamp=[WLTools getOrderTrSeq];
    
    //获取当前处理后的时间戳
    NSString *TimeStamp=[NSString stringWithFormat:@"%lld",[currentTimeStamp longLongValue]];
    
    //获取当前设置UUID
    NSString *Uuid=[WLTools getIPhoneUUID];
    
    //    //获取处理后的TOKEN
    NSString *Token=@"";
    
    //    //获取用户的UID
    NSString *Account=@"";
    
    
    //模拟头部参数数据
    
    [manager.requestSerializer setValue:TimeStamp forHTTPHeaderField:@"Timestamp"];
    
    [manager.requestSerializer setValue:Token forHTTPHeaderField:@"token"];
    
    [manager.requestSerializer setValue:Account forHTTPHeaderField:@"account"];
    
    [manager.requestSerializer setValue:@"IOS" forHTTPHeaderField:@"platform"];
    
    [manager.requestSerializer setValue:kAppVersion forHTTPHeaderField:@"version"];
    
    //设备唯一标识
    [manager.requestSerializer setValue:Uuid forHTTPHeaderField:@"uuid"];
    
    [manager POST:URLString parameters:params headers:@{} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSArray *keys = [imageDic allKeys];
        if (keys && keys.count > 0) {
            
            for (NSInteger i = 0; i<keys.count; i ++) {
                
                NSString *key = keys[i];
                [formData appendPartWithFileData:imageDic[key] name:key fileName:[NSString stringWithFormat:@"%@.jpg",key] mimeType:@"image/jpeg"];
                
            }
            
            
        }
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (callback)
        {
            callback(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure)
        {
            failure(error);
        }
    }];
}


#pragma 监测网络的可链接性
-(BOOL) netWorkReachability
{
    __block BOOL netState = NO;
    
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                netState = YES;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                netState = NO;
            default:
                break;
        }
        
    }];
    
    return netState;
}

@end

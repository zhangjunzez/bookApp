//
//  NetWorkTools.m
//  iOSStudy
//
//  Created by chenguandong on 15/1/31.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import "NetWorkTools.h"
#import "JsonTools.h"
#import "DSLoginViewController.h"
@implementation NetWorkTools


+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });

    return sharedInstance;
}

/**
 *  SMS
 *
 *  @param parameters   <#parameters description#>
 *  @param success      <#success description#>
 *  @param error        <#error description#>
 *  @param isNetworking <#isNetworking description#>
 */
+(void)postHttpToSMS :(id)parameters success:(success)success error:(error)error isNetworking:(isNetwork)isNetworking {
    
    
    
        //  准备请求
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];//@"text/plain",
        
     // NSDictionary *dic = @{@"json":[JsonTools jsonDicToString:parameters]};
        manager.responseSerializer=[AFHTTPResponseSerializer serializer];
        
        //[manager GET:kSMSBaseUrl parameters:parameters progress:nil success:success failure:error];
   
    [manager GET:kSMSBaseUrl parameters:parameters headers:@{} progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:success failure:error];
        
}

+(void)postHttp :(id)parameters success:(success)success error:(error)errord isNetworking:(isNetwork)isNetworking {
    
//    if (SharedApp.isNetworking) {
        //  准备请求
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];

        manager.responseSerializer=[AFHTTPResponseSerializer serializer];
        
        NSDictionary *dic = @{@"json":[JsonTools jsonDicToString:parameters]};
        
        //[manager POST:kBaseUrl parameters:dic progress:nil success:success failure:errord];
    [manager POST:kBaseUrl parameters:dic headers:@{} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:success failure:errord];
        
//    }else{
//
//        isNetworking(false);
//
//        NSLog(@"REACHABLE!");
//
////         [MBProgressHUD showHUDWithTextAutoHidden:@"无网络连接"];
//
//    }
}

+ (void)postConJSONWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)(NSError * error))fail
    {
        
        NSDictionary *dict = (NSDictionary *)parameters;
        
        NSMutableDictionary *pams = [NSMutableDictionary dictionary];
        
        [pams setValuesForKeysWithDictionary:dict];
        
        if (kLogin) {
            [pams setObject:kToken forKey:@"uid"];
        }
        
        dict = pams;

        NSString *url = [NSString stringWithFormat:@"%@/%@",kBaseUrl,urlStr];
        
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];

//        NSString *str = [JsonTools jsonDicToString:parameters];
        
        NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:dict error:nil];
        
//        NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:dic error:nil];
        
        request.timeoutInterval = 10.f;
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        NSURLSessionDataTask *task  =  [manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
            
        } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
            
        } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
              if (!error) {
                  
                            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                                NSString *resultNote = responseObject[@"resultNote"];
                                if ([resultNote hasPrefix:@"该账号已冻结"]&&![[self topViewController] isKindOfClass:[UIAlertController class]]&&![[self topViewController] isKindOfClass:[DSLoginViewController class]]) {
                                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:resultNote preferredStyle:UIAlertControllerStyleAlert];
                                     UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                                        

                                             BaseNavigationViewController *lvc = [[BaseNavigationViewController alloc]initWithRootViewController:[DSLoginViewController new]];
                                             //LXLoginViewController *vc = [[LXLoginViewController alloc]init];
                                             lvc.modalPresentationStyle = UIModalPresentationFullScreen;
                                            
                                             [[self topViewController]  presentViewController:lvc animated:YES completion:^{
                                                
                                            
                                             }];
                                        }];
                                    
                                    [alert addAction:action1];
                                    [[self topViewController]  presentViewController:alert animated:YES completion:nil];
                                }
                                // 请求成功数据处理
                                if (success) {
                                   success(responseObject);
                                }
                            }
                            
                        } else {
            //                showAlert(@"请求失败");
                            if (fail) {
                                fail(error);
                            }
                        }
        }];
        
//        NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//
////            NSLog(@"——responseObject===%@+++++",responseObject);
//
//        }];
        
        [task resume];
}



+(void)postHttpForImageUpload :(id)parameters success:(success)success error:(error)error isNetworking:(isNetwork)isNetworking {
    
    
        //  准备请求
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];//@"text/plain",

        NSDictionary *dic = @{@"json":[JsonTools jsonDicToString:parameters]};
        
        manager.responseSerializer=[AFHTTPResponseSerializer serializer];

//        [manager POST:kBaseUrl parameters:dic success:success failure:error];
    [manager POST:kBaseUrl parameters:dic headers:@{} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:success failure:error];
}




+(void)postHttpForFileUpload :(id)parameters  name:(NSString *)name  imageArr:(NSArray<UIImage*>*)imageArr success:(success)success error:(error)error isNetworking:(isNetwork)isNetworking {

   
        //  准备请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
        
    [manager POST:kBaseUrl parameters:parameters headers:@{} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:success failure:error];
//        [manager POST:kBaseUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//
//                for (id  tu in imageArr) {
//                    if ([tu isKindOfClass:[UIImage class]]) {
//                        [formData appendPartWithFileData:UIImageJPEGRepresentation(tu,0.5) name:name fileName:@"test.jpg" mimeType:@"image/jpg"];
//                    }
//                }
//             NSLog(@"77777777777%@********",formData);
//
//        } progress:nil success:success failure:error];
//
     
    
}

+(void)postHttpForFileUpload :(id)parameters  firstName:(NSString *)firstName  firstImageArr:(NSArray<UIImage*>*)firstImageArr secondName:(NSString *)secondName  secondImageArr:(NSArray<UIImage*>*)secondImageArr businessLogoName:(NSString *)businessLogoName  businessLogoImageArr:(NSArray<UIImage*>*)businessLogoImageArr wechatName:(NSString *)wechatName  wechatImageArr:(NSArray<UIImage*>*)wechatImageArr success:(success)success error:(error)error isNetworking:(isNetwork)isNetworking {
    
        //  准备请求
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        //        [manager setSecurityPolicy:securityPolicy];
        //        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        //        NSString *voicePath = [NSString stringWithFormat:@"%@selfRecord.wav", NSTemporaryDirectory()];
        
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
        
        //        [manager POST:kBaseUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //
        //            /*
        //            [formData appendPartWithFileURL:[NSURL fileURLWithPath:voicePath isDirectory:NO]
        //                                       name:@"talk.file"//talkMessage@"amr"
        //                                   fileName:@"selfRecord.wav"
        //                                   mimeType:@"image/jpg"
        //                                      error:nil];
        //
        //             */
        //
        //
        //            for (UIImage *uploadImage in imageArr) {
        //
        //                [formData appendPartWithFileData:UIImagePNGRepresentation(uploadImage) name:@"talk.file" fileName:@"test.jpg" mimeType:@"image/jpg"];
        //            }
        //
        //
        //
        //        } success:success failure:error]; 已废弃
        //  [manager GET:kBaseUrl parameters:dic success:success failure:error];
        
    [manager POST:kBaseUrl parameters:parameters headers:@{} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
          for (id  tu in firstImageArr) {
                        if ([tu isKindOfClass:[UIImage class]]) {
                            [formData appendPartWithFileData:UIImageJPEGRepresentation(tu,0.5) name:firstName fileName:@"test.jpg" mimeType:@"image/jpg"];
                        }
                        //                    else if ([tu isKindOfClass:[NSString class]]){
                        //
                        //                    }
                        
                    }
                    for (id  tu in secondImageArr) {
                        if ([tu isKindOfClass:[UIImage class]]) {
                            [formData appendPartWithFileData:UIImageJPEGRepresentation(tu,0.5) name:secondName fileName:@"test.jpg" mimeType:@"image/jpg"];
                        }
                    }
                    for (id  tu in businessLogoImageArr) {
                        if ([tu isKindOfClass:[UIImage class]]) {
                            [formData appendPartWithFileData:UIImageJPEGRepresentation(tu,0.5) name:businessLogoName fileName:@"test.jpg" mimeType:@"image/jpg"];
                        }
                    }
        //            for (id  tu in wechatImageArr) {
        //                if ([tu isKindOfClass:[UIImage class]]) {
        //                    [formData appendPartWithFileData:UIImageJPEGRepresentation(tu,0.5) name:wechatName fileName:@"test.jpg" mimeType:@"image/jpg"];
        //                }
        //            }
                    // for (UIImage *uploadImage in imageArr) {
                    //   [formData appendPartWithFileData:UIImagePNGRepresentation(uploadImage) name:name fileName:@"test.jpg" mimeType:@"image/jpg"];
                    // }
                    
                    NSLog(@"77777777777%@********",formData);
                    
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:success failure:error];
       
        
}

+(void)postHttpImgFile :(id)parameters  firstName:(NSString *)firstName  firstImageArr:(UIImage*)img success:(success)success error:(error)error isNetworking:(isNetwork)isNetworking
{

        //  准备请求
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
        
        [manager POST:kImgBaseUrl parameters:parameters headers:@{} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
              
              
                  if ([img isKindOfClass:[UIImage class]]) {
                      
                      [formData appendPartWithFileData:UIImageJPEGRepresentation(img,0.5) name:firstName fileName:@"test.jpg" mimeType:@"image/jpg"];
                  }
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:success failure:error];
   
}

+(void)postHttpVideo:(NSString *)firstName  firstImageArr:(UIImage*)image  withData:(NSData *)data success:(success)success error:(error)error isNetworking:(isNetwork)isNetworking
{

        //  准备请求
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
        
//        [manager POST:kImgBaseUrl parameters:[NSDictionary dictionary] constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//
//            [formData appendPartWithFileData:UIImageJPEGRepresentation(image,0.5) name:firstName fileName:@"test.jpg" mimeType:@"image/jpg"];
//
//            [formData appendPartWithFileData:data name:@"file" fileName:firstName mimeType:@"video/mpeg"];
//
//        } progress:nil success:success failure:error];
        
    [manager POST:kImgBaseUrl parameters:[NSDictionary dictionary] headers:@{} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
          
          
        [formData appendPartWithFileData:UIImageJPEGRepresentation(image,0.5) name:firstName fileName:@"test.jpg" mimeType:@"image/jpg"];
              
            [formData appendPartWithFileData:data name:@"file" fileName:firstName mimeType:@"video/mpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:success failure:error];
}

+(void)postHttpMoreImage:(NSString *)firstName  firstImageArr:(NSArray*)imgArr success:(success)success error:(error)error isNetworking:(isNetwork)isNetworking
{
   
        //  准备请求
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    
    [manager POST:kImgBaseUrl parameters:[NSMutableDictionary dictionary] headers:[NSDictionary dictionary] constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
         for (id  tu in imgArr) {
             
             if ([tu isKindOfClass:[UIImage class]]) {
                 
                 [formData appendPartWithFileData:UIImageJPEGRepresentation(tu,0.5) name:firstName fileName:@"test.jpg" mimeType:@"image/jpg"];
                 
             }
         }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:success failure:error];
        
}

+(void)postHttpMoreImagess:(NSString *)firstName  firstImageArr:(NSArray*)imgArr success:(success)success error:(error)error isNetworking:(isNetwork)isNetworking
{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    [manager POST:kImgBaseUrls parameters:[NSDictionary dictionary] headers:[NSDictionary dictionary] constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (id  tu in imgArr) {
            
            if ([tu isKindOfClass:[UIImage class]]) {
                
                [formData appendPartWithFileData:UIImageJPEGRepresentation(tu,0.5) name:firstName fileName:@"test.jpg" mimeType:@"image/jpg"];
                
            }
        }
        
    }  progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:success failure:error];
        
        
}

+ (void)postImageAddDataWith:(id)parm filName:(NSString *)fileName ImageArr:(NSArray*)imgArr withIconKey:(NSString *)key success:(success)success error:(error)error isNetworking:(isNetwork)isNetworking
{
    __weak typeof(self) weakSelf = self;
    
        //  准备请求
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
        
        NSDictionary *dicc = [NSDictionary dictionary];
    [manager POST:kImgBaseUrl parameters:dicc headers:[NSDictionary dictionary] constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (id  tu in imgArr) {
            
            if ([tu isKindOfClass:[UIImage class]]) {
                
                [formData appendPartWithFileData:UIImageJPEGRepresentation(tu,0.5) name:fileName fileName:@"test.jpg" mimeType:@"image/jpg"];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [JsonTools getJsonNSDictionary:responseObject];

                   NSLog(@"%@",dic);
                   
                   [weakSelf postDatasss:parm withArr:dic[@"imgUrl"] withIconKey:key success:success error:error isNetworking:isNetworking];
    } failure:error];
        
  
    
}

#pragma mark - 上传资料
- (void)postDatasss:(id)dict withArr:(NSArray *)imgArr withIconKey:(NSString *)key success:(success)success error:(error)error isNetworking:(isNetwork)isNetworking
{
        //  准备请求
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSMutableDictionary *dicc = [NSMutableDictionary dictionaryWithDictionary:dict];
        
        [dicc setValue:imgArr forKey:key];
        
        NSLog(@"%@",dicc);
        
        NSDictionary *dic = @{@"json":[JsonTools jsonDicToString:dicc]};
        
        //[manager POST:kBaseUrl parameters:dic progress:nil success:success failure:error];
        
    [manager POST:kBaseUrl parameters:dic headers:[NSDictionary dictionary] progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:success failure:error];
}


+(void)postHttpForFileUpload :(id)parameters  firstName:(NSString *)firstName  firstImageArr:(NSArray<UIImage*>*)firstImageArr secondName:(NSString *)secondName  secondImageArr:(NSArray<UIImage*>*)secondImageArr  success:(success)success error:(error)error isNetworking:(isNetwork)isNetworking {
    
        //  准备请求
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];

        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    
    [manager POST:kBaseUrl parameters:parameters headers:[NSDictionary dictionary] constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (id  tu in firstImageArr) {
             if ([tu isKindOfClass:[UIImage class]]) {
                 [formData appendPartWithFileData:UIImageJPEGRepresentation(tu,0.5) name:firstName fileName:@"test.jpg" mimeType:@"image/jpg"];
             }

         }
         for (id  tu in secondImageArr) {
             if ([tu isKindOfClass:[UIImage class]]) {
                 [formData appendPartWithFileData:UIImageJPEGRepresentation(tu,0.5) name:secondName fileName:@"test.jpg" mimeType:@"image/jpg"];
             }
         }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:success failure:error];
        
        
   
    
}

/**
 * 检查网络连接
 */
+(void)checkNetworking:(isNetwork)isNetwork{
    

    NSURL *baseURL = [NSURL URLWithString:@"http://www.baidu.com/"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    
    NSOperationQueue *operationQueue = manager.operationQueue;
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
//                SharedApp.isNetworking = YES;
//
//                isNetwork(YES);
                
                break;
            case AFNetworkReachabilityStatusNotReachable:
//                SharedApp.isNetworking = NO;
//
//                isNetwork(NO);
                
            default:
                [operationQueue setSuspended:YES];
                
                break;
        }
    }];
    
    [manager.reachabilityManager startMonitoring];
}


+ (void)getWuLiuXinXi:(NSString *)url withDict:(id)parameters success:(success)success error:(error)error
{
    //  准备请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:parameters headers:[NSDictionary dictionary] progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:success failure:error];
    //[manager POST:url parameters:parameters progress:nil success:success failure:error];
}

+(UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
}
@end

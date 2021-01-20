//
//  TDOSSUploadDataTool.m
//  TuDianEducation
//
//  Created by zpz on 2020/4/20.
//  Copyright © 2020 郑州大點哥. All rights reserved.
//

#import "TDOSSUploadDataTool.h"
#import <AliyunOSSiOS/OSSService.h>

@interface TDOSSUploadDataTool()

@property(nonatomic, copy)NSString *SecurityToken;
@property(nonatomic, copy)NSString *Expiration;
@property(nonatomic, copy)NSString *keyId;
@property(nonatomic, copy)NSString *keySecret;

@property(nonatomic, strong)NSArray *datas;
@property(nonatomic, strong)NSArray *urls;

@property(nonatomic, strong)OSSClient *client;

@property (nonatomic,copy)void(^completeBlock)(BOOL, NSArray *);

@property(nonatomic, strong)NSArray *linksArray;
@end

@implementation TDOSSUploadDataTool

+ (TDOSSUploadDataTool *)sharedInstance{
    static TDOSSUploadDataTool *tool=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[TDOSSUploadDataTool alloc] init];
    });
    return tool;
}

- (void)startUploadWithDatas:(NSArray<OSSFormData *> *)datas Completion:(void (^)(BOOL, NSArray * _Nonnull))completion{
    
    
    NSMutableArray *links = [NSMutableArray array];
    NSMutableArray *arrs = [NSMutableArray array];

    for (int i = 0; i < datas.count; i++) {
        TDMediaModel *data = [TDMediaManager getImageDataWithLink:datas[i].link];
        if (data) {
            NSDictionary *dic = @{@"index":@(i),
                                  @"url":data.url
            };
            [links addObject:dic];
        }else{
            [arrs addObject:datas[i]];
        }
    }
    self.datas = [arrs copy];
    self.linksArray = [links copy];

    if (!self.datas.count) {
        NSMutableArray *result = [NSMutableArray array];
        for (NSDictionary *dic in self.linksArray) {
            [result addObject:dic[@"url"]];
        }
        completion(YES, [result copy]);
        return;
    }
    
    
//    if (datas.count == 1) {
//        TDMediaModel *data = [TDMediaManager getImageDataWithLink:datas.firstObject.link];
//        if (data) {
//            completion(YES, @[data.url]);
//            return;
//        }
//    }
//
//    //
//    self.datas = datas;
    self.completeBlock = completion;

    [self updateInfoWithSuccess:^{
        [self uploadData];
    }fail:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(NO, @[]);
        });
//        completion(NO, @[]);
    }];
}

- (void)updateInfoWithSuccess:(void (^)(void))success fail:(void (^)(void))fail{
    
    NSDictionary *pama = @{@"token":SSKJUserDefaultsGET(@"token")};

//    [DYHttpHepler requOSSInfoHpara:nil para:pama showMsg:NO enableView:nil data:^(long code, id  _Nullable result) {
//        
//        self.SecurityToken = result[@"SecurityToken"];
//        self.keyId = result[@"keyId"];
//        self.keySecret = result[@"keySecret"];
//        success();
//    } error:^(long code, id  _Nullable result) {
//        fail();
//    }];
    
}

- (void)uploadData{
    
    NSDictionary *dic = @{
        @"Credentials":@{@"AccessKeyId":self.keyId,
                         @"AccessKeySecret":self.keySecret,
                         @"SecurityToken":self.SecurityToken
        },

    };
    
    NSMutableArray *dataSource = [NSMutableArray array];
    for (OSSFormData *data in self.datas) {
        NSDictionary *dic = @{
          @"data":data.data,
          @"filename":data.fileAddress,
        };
        [dataSource addObject:dic];
    }
    
    
//    [DYHttpHepler aliyunUploadBypara:dic dataSoure:dataSource showMsg:NO enableView:nil data:^(long code, id  _Nullable result) {
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//            NSMutableArray *urls = [NSMutableArray arrayWithArray:result];
//            for (NSDictionary *dic in self.linksArray) {
//                [urls insertObject:dic[@"url"] atIndex:[dic[@"index"] integerValue]];
//            }
//
//            !self.completeBlock?:self.completeBlock(YES, [urls copy]);
//        });
//
//
//    } error:^(long code, id  _Nullable result) {
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            !self.completeBlock?:self.completeBlock(NO, @[]);
//        });
//    }];
}

- (void)startDownWithURLs:(NSArray *)urls Completion:(void (^)(BOOL, NSArray * _Nonnull))completion{
    
    self.urls = urls;
    self.completeBlock = completion;
//    [self updateInfoWithSuccess:^{
//        [self downData];
//    }];
    
}

- (void)downData{
    
    OSSGetObjectRequest * request = [OSSGetObjectRequest new];
    request.bucketName = @"tudianedu";
    request.objectKey = @"5/head.png";
    request.downloadProgress = ^(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        NSLog(@"%lld, %lld, %lld", bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
    };
    
    
    NSString *endpoint = @"https://oss-cn-beijing.aliyuncs.com";
    id<OSSCredentialProvider> credential = [[OSSStsTokenCredentialProvider alloc] initWithAccessKeyId:self.keyId secretKeyId:self.keySecret securityToken:self.SecurityToken];//以上三个参数都是后台给的
        
    self.client = [[OSSClient alloc] initWithEndpoint:endpoint credentialProvider:credential];
    
    OSSTask * getTask = [self.client getObject:request];
    [getTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            NSLog(@"download object success!");
            OSSGetObjectResult * getResult = task.result;
            NSLog(@"download result: %@", getResult.downloadedData);
            NSData *data = getResult.downloadedData;
            
            !self.completeBlock?:self.completeBlock(YES, @[data]);

        } else {

            !self.completeBlock?:self.completeBlock(NO, @[]);

        }
        return nil;
    }];
    // 如果需要阻塞等待任务完成
    // [task waitUntilFinished];
}


@end


@implementation OSSFormData

- (NSString *)fileAddress{
    if (!_fileAddress) {
        
        NSString *type = @"";
        switch (self.dataType) {
            case OSSDataTypeZiZhi:
                type = @"IDENTITY";
                break;
                case OSSDataTypeFengCai:
                type = @"ALBUM";
                break;
                case OSSDataTypeKeTi:
                type = @"TOPIC";
                break;
                case OSSDataTypeYiJian:
                type = @"ADVICE";
                break;
                case OSSDataTypeTouXiang:
                type = @"AVATAR";
                break;
                case OSSDataTypeIdCard:
                type = @"IDCARD";
                break;
            default:
                type = @"others";
                break;
        }
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *comps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
        NSInteger year = [comps year];
        NSInteger month = [comps month];
        NSInteger day = [comps day];
        
        NSString *name = [NSString stringWithFormat:@"%@%@", self.name ?: @"", [self return32LittleString]];
                
        NSString *ext = self.ext;
        if (!ext.length) {
            switch (self.mimeType) {
                case OSSDataMIMETypeImage:
                    ext = @"png";
                    break;
                    case OSSDataMIMETypeVoice:
                    ext = @"wav";
                    break;
                    case OSSDataMIMETypeVideo:
                    ext = @"mp4";
                    break;
                default:
                    ext = @"png";
                    break;
            }
        }
        
        _fileAddress = [NSString stringWithFormat:@"%@/%zd/%02d/%02d/%@.%@",type,year,month,day,name,ext];
        
    }
    

    
    return _fileAddress;
}

- (NSString *)return32LittleString{
    char data[32];
    for (int x=0;x<32;data[x++] = (char)('a'+ (arc4random_uniform(26))));
    return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
}


@end

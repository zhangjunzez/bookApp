//
//  TDOSSUploadDataTool.h
//  TuDianEducation
//
//  Created by zpz on 2020/4/20.
//  Copyright © 2020 郑州大點哥. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 public enum OssType {

     IDENTITY("资质",1),
     ALBUM("教师风采",2),
     TOPIC("课题",3),
     ADVICE("反馈意见",4),
     AVATAR("头像",5);
     IDCARD(身份证)
 }
 */

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger, OSSDataMIMEType) {
    OSSDataMIMETypeImage,
    OSSDataMIMETypeVoice,
    OSSDataMIMETypeVideo
};

typedef NS_ENUM(NSInteger, OSSDataType) {
    OSSDataTypeZiZhi,
    OSSDataTypeFengCai,
    OSSDataTypeKeTi,
    OSSDataTypeYiJian,
    OSSDataTypeTouXiang,
    OSSDataTypeIdCard
};

@interface OSSFormData : NSObject

///数据源
@property (nonatomic, strong) NSData *data;
///文件名
@property (nonatomic, copy) NSString *name;
/**
 文件类型:
 voice
 video
 image
 */
@property (nonatomic) OSSDataMIMEType mimeType;
///数据类型
@property (nonatomic) OSSDataType dataType;
///本地链接
@property(nonatomic, copy)NSString *link;

///文件地址
@property(nonatomic, copy)NSString *fileAddress;

///后缀
@property(nonatomic, copy)NSString *ext;

@end

@interface TDOSSUploadDataTool : NSObject

+ (TDOSSUploadDataTool *)sharedInstance;

- (void)startUploadWithDatas:(NSArray<OSSFormData *> *)datas Completion:(void (^)(BOOL result,NSArray * urls))completion;

- (void)startDownWithURLs:(NSArray *)urls Completion:(void (^)(BOOL result,NSArray * datas))completion;

@end



NS_ASSUME_NONNULL_END

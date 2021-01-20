//
//  DYDBUserIM_Resource.h
//  XILAIBANG
//
//  Created by ff on 2019/9/20.
//  Copyright © 2019 大點哥. All rights reserved.
//

#import "RLMObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface DYDBUserIM_Resource : RLMObject

// 用户唯一标识
@property NSString *xlb_uid;
// 多媒体唯一标识(主键,视频用的视频URL的mediaid)
@property NSString *mediaID;
// 媒体类型
@property NSString *type;
// data
@property NSData *mediaData;
// 缩略图data
@property NSData *smallMediaData;
// 预览图data
@property NSData *middleMediaData;
// 文件格式
@property NSString *extension;
// url
@property NSString *url;
// 下载状态[0=下载失败,1=下载成功]
@property NSNumber <RLMInt> *status;
//
// 视频专用
@property NSString *videoCoverMediaID;
// data
@property NSData *videoCoverData;
// url
@property NSString *videoCoverUrl;
// 文件格式
@property NSString *videoCoverextension;
// 时长
@property NSString *duration;
// 音效类型
@property NSNumber <RLMInt> *timbre;
// 扩展字段
@property NSString *ext;

@end

NS_ASSUME_NONNULL_END

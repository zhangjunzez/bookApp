//
//  TDMediaModel.h
//  TuDianEducation
//
//  Created by zpz on 2020/4/25.
//  Copyright © 2020 郑州大點哥. All rights reserved.
//

#import "RLMObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface TDMediaModel : RLMObject

@property(nonatomic, copy)NSString *url;

@property(nonatomic, copy)NSString *link;

@property(nonatomic, copy)NSString *fileType;

@property(nonatomic, copy)NSString *originalName;

@property(nonatomic, copy)NSString *middleName;

@property(nonatomic, copy)NSString *smallName;

@end

NS_ASSUME_NONNULL_END

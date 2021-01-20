//
//  TDImageDataModel.h
//  TuDianEducation
//
//  Created by zpz on 2020/4/25.
//  Copyright © 2020 郑州大點哥. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDImageDataModel : NSObject

@property(nonatomic, copy)NSString *url;

@property(nonatomic, copy)NSString *link;

@property(nonatomic, strong)UIImage *originalImage;
@property(nonatomic, strong)UIImage *middleImage;
@property(nonatomic, strong)UIImage *smallImage;

@end

NS_ASSUME_NONNULL_END

//
//  MediaModel.h
//  tudianjiaoyu
//
//  Created by 张本超 on 2020/4/5.
//  Copyright © 2020 张本超. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MediaModel : NSObject
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *imgName;
@property (nonatomic, strong) UIImage *img;
@end

NS_ASSUME_NONNULL_END

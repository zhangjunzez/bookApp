//
//  LXRealNameUploadItemView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/24.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXRealNameUploadItemView : UIView
-(instancetype)initWithTop:(CGFloat)top name:(NSString *)name;
@property (nonatomic,strong) UIImageView *uploadImgeView;
@property (nonatomic,copy) void(^uploadBlcok)(void);
@property (nonatomic,strong) NSString *currentUrl;
@end

NS_ASSUME_NONNULL_END

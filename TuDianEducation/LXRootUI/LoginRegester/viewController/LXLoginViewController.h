//
//  LXLoginViewController.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/22.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "BaseViewController.h"
typedef NS_ENUM(NSInteger,LoginType) {
    LoginTypeMessage,
    LoginTypePassWord,
};
NS_ASSUME_NONNULL_BEGIN

@interface LXLoginViewController : BaseViewController
@property (nonatomic,assign) LoginType loginType;
@end

NS_ASSUME_NONNULL_END

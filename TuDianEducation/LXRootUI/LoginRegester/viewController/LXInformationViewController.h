//
//  LXInformationViewController.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/11/5.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXInformationViewController : BaseViewController
@property (nonatomic,copy) void(^gobackBlcok)(void);
@property (nonatomic,strong) NSMutableDictionary *pamaDic;
@end

NS_ASSUME_NONNULL_END

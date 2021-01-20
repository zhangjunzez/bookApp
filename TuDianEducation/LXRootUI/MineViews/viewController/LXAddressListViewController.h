//
//  LXAddressListViewController.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/28.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "BaseViewController.h"
#import "LXAddressModel.h"
typedef NS_ENUM(NSUInteger,AddressListType) {
    AddressListTypeNone,
    AddressListTypeEdting,
    
};
NS_ASSUME_NONNULL_BEGIN

@interface LXAddressListViewController : BaseViewController
@property (nonatomic,assign) AddressListType type;

@property (nonatomic,copy) void(^callBackBlock)(LXAddressModel *model);

@end

NS_ASSUME_NONNULL_END

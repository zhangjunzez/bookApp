//
//  LXAddAddressViewController.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/28.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,AddressEdtingType) {
    AddressEdtingTypeEdting,
    AddressEdtingTypeAdding,
    AddressEdtingTypeSee,
};
@class LXAddressModel;
@interface LXAddAddressViewController : BaseViewController
@property (nonatomic,assign) AddressEdtingType edtingType;
@property (nonatomic,strong) NSString *addressNums;
@property (nonatomic,strong) LXAddressModel *model;

@property (nonatomic,copy) void(^callBackBlock)(void);
@end

NS_ASSUME_NONNULL_END

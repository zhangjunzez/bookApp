//
//  LXAddressListTableViewCell.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/28.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class LXAddressModel;
@interface LXAddressListTableViewCell : UITableViewCell
@property (nonatomic,copy) void(^edtingBlock)(void);
@property (nonatomic,copy) void(^deleteBlock)(void);
@property (nonatomic,strong) LXAddressModel *model;
@property (nonatomic,copy) void(^setDefultBlock)(BOOL isSelect);
@end

NS_ASSUME_NONNULL_END

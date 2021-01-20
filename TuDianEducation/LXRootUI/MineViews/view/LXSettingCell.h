//
//  LXSettingCell.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/24.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXSettingCell : UITableViewCell
@property (nonatomic, copy) void(^changeStatusBlock)(UISwitch *s);
@property (nonatomic,strong) UISwitch *swithUnknow;
@property (nonatomic,strong) UIImageView *gotoImg;
@property (nonatomic, strong) UILabel *subNameLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@end

NS_ASSUME_NONNULL_END

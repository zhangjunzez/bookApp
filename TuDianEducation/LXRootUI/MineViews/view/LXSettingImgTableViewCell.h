//
//  LXSettingImgTableViewCell.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/1.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface LXSettingImgTableViewCell : UITableViewCell
@property (nonatomic, copy) void(^changeStatusBlock)(UISwitch *s);

@property (nonatomic,strong) UIImageView *gotoImg;
@property (nonatomic,strong) UIImageView *headerImgView;
@property (nonatomic, strong) UILabel *nameLabel;
@end
NS_ASSUME_NONNULL_END

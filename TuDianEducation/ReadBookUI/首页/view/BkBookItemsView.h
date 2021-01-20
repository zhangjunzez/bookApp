//
//  BkBookItemsView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/12.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BkBookItemsView : UIView
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *subNameLabel;
@property (nonatomic,strong) UIImageView *bookImgView;
@property (nonatomic,copy) void(^selctBlock)(BkBookItemsView *sender);
@end

NS_ASSUME_NONNULL_END

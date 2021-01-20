//
//  LXRealNameSelectView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/24.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXRealNameSelectView : UIView
@property (nonatomic,assign) BOOL isEdting;
@property (nonatomic,strong) UIImageView *gotoImg;
@property (nonatomic, strong) UILabel *subNameLabel;
@property (nonatomic,strong) UITextField *subTextFild;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic,copy) void(^gotoBlock)(void);
@end

NS_ASSUME_NONNULL_END

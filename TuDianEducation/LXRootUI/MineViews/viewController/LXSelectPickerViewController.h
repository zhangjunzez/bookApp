//
//  LXSelectPickerViewController.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/8/19.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXSelectPickerViewController : BaseViewController
@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,copy) void(^selecedTypeBlock)(NSString *type);
@property (nonatomic,strong) NSArray *dataArray;
@end

NS_ASSUME_NONNULL_END

//
//  MineEdtingViewController.h
//  TuDianEducation
//
//  Created by 张本超 on 2020/4/21.
//  Copyright © 2020 郑州大點哥. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineEdtingViewController : BaseViewController
@property (nonatomic, strong) UITextField *inputTextFied;
@property (nonatomic, copy) void (^sucessEdtingBlock)(NSString *string);
@end

NS_ASSUME_NONNULL_END

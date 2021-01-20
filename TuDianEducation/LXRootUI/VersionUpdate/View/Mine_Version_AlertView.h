//
//  HeBi_Version_AlertView.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/19.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mine_Version_Model.h"
NS_ASSUME_NONNULL_BEGIN

@interface Mine_Version_AlertView : UIView
+(void)showWithModel:(Mine_Version_Model *)model confirmBlock:(void(^)(void))confirmblock cancleBlock:(void(^)(void))cancleBlock;
@end

NS_ASSUME_NONNULL_END

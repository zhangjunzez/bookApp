//
//  TouchBtn.h
//  XILAIBANG
//
//  Created by ff on 2019/9/9.
//  Copyright © 2019 大點哥. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TouchBtn : UIButton
@property(nonatomic,copy)void(^pointBlock)(CGPoint point);


@end

NS_ASSUME_NONNULL_END

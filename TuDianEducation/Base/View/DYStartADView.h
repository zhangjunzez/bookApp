//
//  DYStartADView.h
//  XILAIBANG
//
//  Created by ff on 2019/9/12.
//  Copyright © 2019 大點哥. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    DYADType_FullADScreen,
    DYADType_SquareADScreen,
    DYADType_CustomADScreen,
} DYADType;

typedef void(^ADDoneBlock)(_Nullable id obj);

@interface DYStartADView : UIView

- (instancetype)initWithType:(DYADType)type Para:(NSDictionary *)para complate:(ADDoneBlock)complate;

- (void)show;

@end

NS_ASSUME_NONNULL_END

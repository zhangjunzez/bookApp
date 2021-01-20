//
//  BkFaceDetailSelectView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/12.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BkFaceDetailSelectView : UIView
@property (nonatomic,strong) UIButton *allCommendsBtn;
@property (nonatomic,strong) UIButton *onlyAuthsBtn;
@property (nonatomic,strong) UIButton *timeShowBtn;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,copy) void(^timeShowBlock)(void);
@end

NS_ASSUME_NONNULL_END

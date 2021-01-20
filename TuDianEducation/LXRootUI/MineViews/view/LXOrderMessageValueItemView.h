//
//  LXOrderMessageValueItemView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/29.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXOrderMessageValueItemView : UIView
-(instancetype)initWithTop:(CGFloat)top  titleString:(NSString *)titleString valueString:(NSString *)valueString isRedValue:(BOOL)isRedValue;
@property (nonatomic,strong) UILabel *valueLabel;
@property (nonatomic,strong) UILabel *titleLabel;

@end

NS_ASSUME_NONNULL_END

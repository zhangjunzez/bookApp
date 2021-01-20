//
//  BookItemsView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/7.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BookItemsView : UIView
-(instancetype)initWithTop:(CGFloat)top x:(CGFloat)x name:(NSString *)name subName:(NSString *)subName bgImg:(NSString *)bgImg;
@property (nonatomic,copy) void(^gotoBlock)(void);
@end

NS_ASSUME_NONNULL_END

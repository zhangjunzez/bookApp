//
//  LXApplyGetMoneyItemView.h
//  TuDianEducation
//  Created by lixinkeji on 2020/6/28.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXApplyGetMoneyItemView : UIView
-(instancetype)initWithTitle:(NSString *)title top:(CGFloat)top  placeHolder:(NSString *)placeHolder;

-(instancetype)initWithTitle:(NSString *)title top:(CGFloat)top  placeHolder:(NSString *)placeHolder redHidden:(BOOL)redHidden;

-(instancetype)initWithTitle:(NSString *)title top:(CGFloat)top  placeHolder:(NSString *)placeHolder redHidden:(BOOL)redHidden isgGotoAction:(BOOL)isgGotoAction;

@property (nonatomic,copy) void(^gotoInforActionBlock)(void);

@property (nonatomic,strong) UITextField *textFied;
@end
NS_ASSUME_NONNULL_END

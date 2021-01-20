//
//  LoginInputView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/23.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface LoginInputView : UIView
@property (nonatomic,strong) UITextField *textFied;
-(instancetype)initWithTop:(CGFloat)top  placeHolder:(NSString *)placeHolder hasGetCode:(BOOL)hasgetCode;
@property (nonatomic,copy) void(^getCodeBlock)(UIButton *btn);
@property (nonatomic,strong) UIButton *getCodeBtn;
@property (nonatomic,strong) UIButton *lookPswBtn;
@end
NS_ASSUME_NONNULL_END

//
//  RegesiterItemView.h
//  HuaYiHuangCheng
//
//  Created by lixinkeji on 2020/10/28.
//  Copyright © 2020 lixinkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RegesiterItemView : UIView
@property (nonatomic,strong) UITextField *inputTextFiled;
-(instancetype)initWithTop:(CGFloat)top isPhoneAccount:(BOOL)isAccount placeHolder:(NSString *)placeHolder;
-(instancetype)initWithTop:(CGFloat)top isPhoneAccount:(BOOL)isAccount placeHolder:(NSString *)placeHolder red:(BOOL)red;
@end

NS_ASSUME_NONNULL_END

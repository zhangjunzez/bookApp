//
//  LoginUserView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/22.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginUserView : UIView
-(instancetype)initWithTop:(CGFloat)top headerImg:(UIImage *)headerImg placeHolder:(NSString *)placeHolder hasGetCode:(BOOL)hasgetCode;
@property (nonatomic,copy) void(^getCodeBlock)(UIButton *btn);
@property (nonatomic,strong) UIButton *getCodeBtn;

@property (nonatomic,strong) UITextField *textFied;


@end

NS_ASSUME_NONNULL_END

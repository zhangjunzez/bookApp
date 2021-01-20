//
//  JZLoginItemsView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/8/28.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface JZLoginItemsView : UIView
@property (nonatomic,strong) UITextField *textFied;
@property (nonatomic,strong) UILabel *titleLabel;
-(instancetype)initWithTop:(CGFloat)top titleString:(NSString *)titleString placeHolder:(NSString *)placeHolder hasGetCode:(BOOL)hasgetCode;
@property (nonatomic,copy) void(^getCodeBlock)(UIButton *btn);
@property (nonatomic,strong) UIButton *getCodeBtn;
@property (nonatomic,strong) UIButton *eyeBtn;
@end
NS_ASSUME_NONNULL_END

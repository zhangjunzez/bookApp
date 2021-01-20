//
//  LXAddAddressItemView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/28.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface LXAddAddressItemView : UIView
-(instancetype)initWithTitle:(NSString *)title top:(CGFloat)top  placeHolder:(NSString *)placeHolder gotoImgString:(NSString *)gotoImgString;
@property (nonatomic,copy) void(^gotoNextBlock)(void);
@property (nonatomic,strong) UIButton *gotoBtn;
@property (nonatomic,strong) UITextField *textFied;
@property (nonatomic,strong) UIView *bottomLine;
@end
NS_ASSUME_NONNULL_END

//
//  JZPayWaysItemsView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/9/2.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JZPayWaysItemsView : UIView
-(instancetype)initWiteTop:(CGFloat)top headerImg:(NSString *)headerImg name:(NSString *)name subName:(NSString*)subName;
@property (nonatomic,strong) UIButton *beSelectBtn;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UITextField *subNameLabel;
@property (nonatomic,strong) UIImageView *headerImgView;
@property (nonatomic,copy)void(^selectBlock)(BOOL isSelected);
@end

NS_ASSUME_NONNULL_END

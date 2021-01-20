//
//  BkAgeItemsView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/12.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BkAgeItemsView : UIView
@property (nonatomic,strong) UIButton *selectBtn;
@property (nonatomic,strong) UIImageView *headerImgView;
@property (nonatomic,strong) UILabel *messageLabel;
@property (nonatomic,copy) void(^selectBlock)(BkAgeItemsView *sender);

-(void)setItemsSelct:(BOOL)selct;

@end

NS_ASSUME_NONNULL_END

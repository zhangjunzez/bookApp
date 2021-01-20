//
//  QBWShowNoDataView.h
//  ZYW_MIT
//
//  Created by 张本超 on 2018/4/28.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSKJ_NoDataView : UIView
//主视图
@property(nonatomic,strong)UIImageView *img;
//添加主视图（偏移量）
+(instancetype)showNoData:(BOOL)haveData toView:(UIView *)view offY:(CGFloat) offY;

//添加主视图（固定frame）
+(instancetype)showNoData:(BOOL)haveData toView:(UIView *)view frame:(CGRect)frame;
///自定义信息图片
+(instancetype)showNoData:(BOOL)haveData toView:(UIView *)view offY:(CGFloat) offY message:(NSString *)message imge:(UIImage *)img;
@end

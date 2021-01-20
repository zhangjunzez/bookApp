//
//  MBProgressHUD+MJ.h
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (FR)

+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view;

+ (void)showSuccess:(NSString *)success;
#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toViewLong:(UIView *)view;
+ (void)showError:(NSString *)error;

+ (void)showError:(NSString *)error WithColor:(UIColor *)color;
+ (void)HUDShowViewWith:(UIColor *)color;
+ (void)HUDShowView;
+ (void)hideHUD;


+ (instancetype)showHUDAddedTo:(UIView *)view animated:(BOOL)animated;

+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated;

+ (instancetype)showHUDSSAddedTo:(UIView *)view animated:(BOOL)animated;

@end

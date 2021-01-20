//
//  MBProgressHUD+MJ.m
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "MBProgressHUD+FR.h"

#import "UIImage+GIF.h"

@implementation MBProgressHUD (FR)

+ (void)HUDShowViewWith:(UIColor *)color{
    
    if (color ==nil) {
        color = [UIColor clearColor];
    }
    
    UIView* view = [UIApplication sharedApplication].keyWindow ;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    hud.animationType =  MBProgressHUDAnimationFade;
    hud.bezelView.color = color;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.color = [UIColor blackColor];
    hud.backgroundView.alpha = 1;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    hud.button.hidden = YES;
    
    UIImageView * loading = [[UIImageView alloc]init];
    
    
    loading.image = [UIImage imageNamed:@"TD20001"];
    NSMutableArray *progressImages = [NSMutableArray array];
    for (int i = 1; i < 10; i++) {
        
        NSString *imageName = [NSString stringWithFormat:@"TD2000%d",i++];
        UIImage *image = [UIImage imageNamed:imageName];
        [progressImages addObject:image];
        
    }
    hud.customView = [[UIImageView alloc] init];
    
    ((UIImageView *)hud.customView).animationImages = progressImages;
    ((UIImageView *)hud.customView).animationRepeatCount = 0;
    
    [((UIImageView *)hud.customView) startAnimating];
    
    
    [hud hideAnimated:NO afterDelay:7.0];
}


+ (void)HUDShowView{
    
    UIView* view = [UIApplication sharedApplication].keyWindow ;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    hud.animationType =  MBProgressHUDAnimationFade;
    hud.bezelView.color = [UIColor whiteColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    hud.button.hidden = YES;
    UIImageView * loading = [[UIImageView alloc]init];
    loading.image = [UIImage imageNamed:@"image_00"];
    NSMutableArray *progressImages = [NSMutableArray array];
    for (int i = 0; i < 60; i++) {
        
        NSString *imageName = [NSString stringWithFormat:@"image_%.2d",i++];
        UIImage *image = [UIImage imageNamed:imageName];
        [progressImages addObject:image];
        
    }
    hud.customView = [[UIImageView alloc] init];
    
    ((UIImageView *)hud.customView).animationImages = progressImages;
    ((UIImageView *)hud.customView).animationRepeatCount = 0;
    
    [((UIImageView *)hud.customView) startAnimating];
    
    [hud hideAnimated:NO afterDelay:7.0];
}


#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow ;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    //    hud.label.text = [NSString stringWithFormat:@"\r\n\r\n%@",text];
    hud.label.text = text;
    hud.label.numberOfLines = 0;
    // 设置图片
    hud.bezelView.color = [UIColor blackColor];
    hud.contentColor = [UIColor whiteColor];
    hud.mode = MBProgressHUDModeText;
    hud.button.hidden = YES;
    // 再设置模式
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 1秒之后再消失
    [hud hideAnimated:NO afterDelay:1.5];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow ;
    // 快速显示一个提示信息
    //    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // 设置图片
    MBProgressHUD *hud = [[self alloc] initWithView:view];
    [view addSubview:hud];
    [hud showAnimated:YES];
    
    hud.bezelView.color = [UIColor blackColor];
    hud.contentColor = [UIColor whiteColor];
    //    hud.contentColor = kSubTitleColor;
    
    hud.label.text = error;
    hud.label.numberOfLines = 0;
    hud.square = NO;
    hud.button.hidden = YES;
    
    
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 1秒之后再消失
    [hud hideAnimated:NO afterDelay:1.5];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // 设置图片
    //    hud.label.text =[NSString stringWithFormat:@"\r\n\r\n%@",success];
    hud.label.text = success;
    hud.bezelView.color = [UIColor blackColor];
    hud.contentColor = [UIColor whiteColor];
    hud.label.numberOfLines = 0;
    hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MBProgressHUD.bundle/success.png"]];
    hud.button.hidden = YES;
    
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 1秒之后再消失
    [hud hideAnimated:NO afterDelay:1.0];
    
}

+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toViewLong:(UIView *)view{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // 设置图片
    hud.bezelView.color = UIColorFromRGB(0x1a1b25);
    hud.contentColor = [UIColor whiteColor];
    
    hud.label.text = error;
    hud.label.numberOfLines = 0;
    hud.square = NO;
    hud.button.hidden = YES;
    
    
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 1秒之后再消失
    [hud hideAnimated:NO afterDelay:3];
}

+ (void)showError:(id)error
{
    NSString *Error = [NSString stringWithFormat:@"%@",error];
    
    if (Error.length != 0) {
        [self showError:Error toView:nil];
    }
}

+ (void)hideHUD
{
    UIView* view = [UIApplication sharedApplication].keyWindow;
    [self hideHUDForView:view animated:NO];
}

+ (void)showError:(NSString *)error WithColor:(UIColor *)color {
    
    UIView * view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    //    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // 设置图片
    
    MBProgressHUD *hud = [[self alloc] initWithView:view];
    [view addSubview:hud];
    [hud showAnimated:YES];
    
    
    hud.bezelView.color = color;
    //    hud.label.text = [NSString stringWithFormat:@"\r\n\r\n%@",error];
    hud.label.text = error;
    hud.label.numberOfLines = 0;
    hud.square = NO;
    hud.button.hidden = YES;
    hud.contentColor = [UIColor whiteColor];
    
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 消失
    [hud hideAnimated:NO afterDelay:3.0];
}



+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)newsize{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(newsize);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, newsize.width, newsize.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

+ (instancetype)showHUDSSAddedTo:(UIView *)view animated:(BOOL)animated;{
    for (UIView *v in view.subviews) {
        if ([v isKindOfClass:[MBProgressHUD class]]) {
            [v removeFromSuperview];
        }
    }
    MBProgressHUD *hud = [[self alloc] initWithView:view];
    hud.removeFromSuperViewOnHide = YES;
    [view addSubview:hud];
    [hud showAnimated:animated];
    return hud;
}

// 隐藏
//+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated
//{
//    MBProgressHUD *hud = [self HUDForView:view];
//    if (hud != nil) {
//        //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0), dispatch_get_main_queue(), ^{
//        hud.removeFromSuperViewOnHide = YES;
//        [hud hideAnimated:animated];
//        //        });
//        return YES;
//    }
//    return NO;
//}

//+ (instancetype)showHUDAddedTo:(UIView *)view animated:(BOOL)animated
//{
//    for (UIView *v  in  view.subviews) {
//        if ([v isKindOfClass:[MBProgressHUD class]]) {
//            [v removeFromSuperview];
//        }
//    }
//    MBProgressHUD *hud = [[self alloc] initWithView: view];
//    hud.removeFromSuperViewOnHide = YES;
//    hud.mode = MBProgressHUDModeCustomView;
//    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
//    hud.bezelView.color = [UIColor colorWithWhite:0 alpha:1];
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(70), ScaleW(70))];
//
//    NSMutableArray* frames=[[NSMutableArray alloc] init];
//    for (int i=1;i < 10; i++)
//    {
//        UIImage* imageName=[UIImage imageNamed:[NSString stringWithFormat:@"TD2000%d",i]];//将图片源转换成UIimageView能使用的图片源
//        imageName = [self OriginImage:imageName scaleToSize:CGSizeMake(80, 80)];
//        [frames addObject:imageName];//将图片加入数组中
//    }
//
//    imageView.animationImages = frames;
//    imageView.animationDuration = 1;
//    [imageView startAnimating];
//
//    hud.customView = imageView;
//    hud.square = YES;
//    [view addSubview:hud];
//    [hud showAnimated:animated];
//    return hud;
//}

+ (UIImage*)OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}


@end

//
//  MBHUD.m
//  SSKJ
//
//  Created by 姚立志 on 2019/6/14.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "MBHUD.h"
@interface MBHUD ()



@end

@implementation MBHUD




+(void)showHUDAddedTo:(UIView*)view
{
    [MBProgressHUD showHUDAddedTo:view animated:YES];
}


#pragma mark 从当前视图上移除
+(void)hideHUDForView:(UIView*)view
{
    [MBProgressHUD hideHUDForView:view animated:YES];
}

#pragma mark 显示提示信息
+(void)showError:(NSString*)title
{
   // [MBProgressHUD showError:title];
}

#pragma mark 显示提示信息
+(void)showSuccess:(NSString*)title
{
   // [MBProgressHUD showSuccess:title];
}



@end

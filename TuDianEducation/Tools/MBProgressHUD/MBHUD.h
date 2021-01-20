//
//  MBHUD.h
//  SSKJ
//
//  Created by 姚立志 on 2019/6/14.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"


NS_ASSUME_NONNULL_BEGIN

@interface MBHUD : NSObject

#pragma mark 显示当前视图
+(void)showHUDAddedTo:(UIView*)view;

#pragma mark 从当前视图上移除
+(void)hideHUDForView:(UIView*)view;

#pragma mark 显示提示信息
+(void)showError:(NSString*)title;

#pragma mark 显示提示信息
+(void)showSuccess:(NSString*)title;




@end

NS_ASSUME_NONNULL_END

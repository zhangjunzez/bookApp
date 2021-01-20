//
//  ETF_Logout_AlertView.h
//  SSKJ
//
//  Created by 刘小雨 on 2018/10/9.
//  Copyright © 2018年 James. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSKJ_Logout_AlertView : UIView
@property (nonatomic, copy) void (^confirmBlock)(void);
@property (nonatomic, assign) BOOL isShow;
-(void)showWithMessage:(NSString *)message;
@end

NS_ASSUME_NONNULL_END

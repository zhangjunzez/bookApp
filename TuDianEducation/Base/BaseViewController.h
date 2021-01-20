//
//  BaseViewController.h
//  TuDianEducation
//
//  Created by 大新的电脑 on 2020/4/5.
//  Copyright © 2020 郑州大點哥. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController
/*
 * 修改导航栏左侧按钮
 */
- (void)addLeftNavItemWithImage:(UIImage*)image;

/*
 * 修改导航栏左侧按钮
 */
- (void)addLeftNavItemWithTitle:(NSString*)title color:(UIColor *)color font:(UIFont *)font;

/*
 * 返回按钮点击事件
 */
- (void)leftBtnAction:(id)sender;

/*
 * 添加导航栏右侧按钮
 */
- (void)addRightNavItemWithTitle:(NSString*)title color:(UIColor *)color font:(UIFont *)font;

/*
 * 添加导航栏右侧按钮
 */
- (void)addRightNavgationItemWithImage:(UIImage*)image;

/*
 * 导航栏右侧按钮点击事件
 */
- (void)rigthBtnAction:(id)sender;

///去登陆

-(void)presentLoginAction;

-(void)loginOutAction;
///回到首页
-(void)backToHomeAction;
///消失
-(void)dissMissAction;
///模态
-(void)preasntVc:(UIViewController *)vc;
///push
-(void)naviPushVc:(UIViewController *)vc;

@property (nonatomic, copy) void(^loginSucessBlock)(void);


-(void)hiddenNavigationView;
///登录权限判断
-(BOOL)ifNoLoginGotoLoginAction;
///跳转网页
-(void)gotoWebWithUrl:(NSString *)url title:(NSString *)title;
@end

NS_ASSUME_NONNULL_END

//
//  BaseViewController.m
//  TuDianEducation
//
//  Created by 大新的电脑 on 2020/4/5.
//  Copyright © 2020 郑州大點哥. All rights reserved.
//

#import "BaseViewController.h"
#import "SSKJ_BaseNavigationController.h"
#import "AppDelegate.h"
#import "SSKJ_TabbarController.h"

//#import "MineCenterRootViewController.h"
//#import "MineWalletViewController.h"
//#import "HomePageRootViewController.h"
//#import "UserInforHelper.h"
//#import "MineSignViewController.h"
//#import "Mine_InviteViewController.h"
//#import "LXLoginViewController.h"
//#import "SearchHomeViewController.h"
#import "LXMineViewController.h"
#import "LXPublishAlertViewController.h"
#import "LXScoreMarkeDetailViewController.h"

#import "LXGetOrderViewController.h"
#import "LXNewsViewController.h"
#import "LXLearnningViewController.h"
#import "LXNewsListViewController.h"
#import "DSLoginViewController.h"
#import "SSKJ_H5Web_ViewController.h"
#import "BookMineViewController.h"


@interface BaseViewController ()<UINavigationControllerDelegate>
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [DYColorHelper sysBGColor];
    self.view.backgroundColor = WHITE_COLOR;
    [[UIView appearance] setExclusiveTouch:YES];
    //self.navigationController.navigationBar.subviews[0].subviews[0].hidden = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    //backArrow
    if (self.navigationController.viewControllers.count > 1) {
        UIImage *backImg = [UIImage imageNamed:@"fanhui"];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:backImg style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnAction:)];
        item.tintColor = kMainTxtColor;
        self.navigationItem.leftBarButtonItem = item;
    }
    
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showPublish) name:@"dissmissPublish" object:nil];
    
}



- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    if (DYApplication.applicationState == UIApplicationStateBackground) {
        DYLog(@"退后台");
        return;
    }
    if (![[NSUserDefaults standardUserDefaults]valueForKey:@"userInterfaceStyle"]) {
        DYLog(@"暗黑模式判断设置初始值");
        [[NSUserDefaults standardUserDefaults]setValue:[DYColorHelper isDarkSystemMode]==YES?@(2):@(1) forKey:@"userInterfaceStyle"];
    }
    if (previousTraitCollection == nil) {
        DYLog(@"无暗黑模式");
        return;
    }
    
    
    if (@available(iOS 12.0, *)) {
        if (previousTraitCollection.userInterfaceStyle == [[[NSUserDefaults standardUserDefaults]valueForKey:@"userInterfaceStyle"] intValue]) {
            DYLog(@"暗黑模式-模式没变");
            return;
        }else {
            [self setNeedsStatusBarAppearanceUpdate];
            DYLog(@"暗黑模式-模式变了-%ld",(long)previousTraitCollection.userInterfaceStyle);
                [self.view layoutIfNeeded];
                if (self.presentingViewController) {
                    [self dismissViewControllerAnimated:NO completion:nil];
                }else {
                    [self.navigationController popToRootViewControllerAnimated:NO];
                }
            [[NSUserDefaults standardUserDefaults]setValue:@(previousTraitCollection.userInterfaceStyle) forKey:@"userInterfaceStyle"];
        }
    } else {
        return;
    }
}
#pragma mark ****************************************************
/*
 * 修改导航栏左侧按钮
 */
- (void)addLeftNavItemWithImage:(UIImage*)image
{
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnAction:)];
    self.navigationItem.leftBarButtonItem = item;
}
/*
 * 修改导航栏左侧按钮
 */
- (void)addLeftNavItemWithTitle:(NSString*)title color:(UIColor *)color
 font:(nonnull UIFont *)font
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnAction:)];
    [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,
                                     color, NSForegroundColorAttributeName,
                                     nil]
                           forState:UIControlStateNormal];
       self.navigationItem.leftBarButtonItem = item;
    
}
/*
 * 返回按钮点击事件
 */
- (void)leftBtnAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

/*
 * 添加导航栏右侧按钮
 */
- (void)addRightNavItemWithTitle:(NSString*)title color:(UIColor *)color font:(UIFont *)font
{
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(rigthBtnAction:)];
    //    item.tintColor = color;
    [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kNavFont, NSFontAttributeName,
                                  color, NSForegroundColorAttributeName,
                                  nil]
                        forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = item;
    
}

/*
 * 添加导航栏右侧按钮
 */
- (void)addRightNavgationItemWithImage:(UIImage*)image
{
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(rigthBtnAction:)];
    self.navigationItem.rightBarButtonItem = item;
}

/*
 * 导航栏右侧按钮点击事件
 */
- (void)rigthBtnAction:(id)sender
{
    
}

- (void)presentLoginAction{

    BaseNavigationViewController *lvc = [[BaseNavigationViewController alloc]initWithRootViewController:[DSLoginViewController new]];
    //LXLoginViewController *vc = [[LXLoginViewController alloc]init];
    lvc.modalPresentationStyle = UIModalPresentationFullScreen;
   
    [self presentViewController:lvc animated:YES completion:^{
       
        //[self showPublish];
    }];
}

-(void)loginOutAction
{
//    NSString *token = kToken;
//    if (token.length == 0) {
//        SSKJ_BaseNavigationController *lvc = [[SSKJ_BaseNavigationController alloc]initWithRootViewController:[DYLoginViewController new]];
//           lvc.modalPresentationStyle = UIModalPresentationFullScreen;
//        [self presentViewController:lvc animated:YES completion:nil];
//    }
    //[UserInforHelper sharedLocationHelper] ;
    [TDUserDBManager userLoginOut];
    
    SSKJ_TabbarController *tabbarVC = (SSKJ_TabbarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = tabbarVC.selectedViewController;
    [nav popToRootViewControllerAnimated:NO];
    [tabbarVC setSelectedIndex:0];
        
//    BaseNavigationViewController *lvc = [[BaseNavigationViewController alloc]initWithRootViewController:[DYLoginViewController new]];
//    lvc.modalPresentationStyle = UIModalPresentationFullScreen;
//    self.view.window.rootViewController = tabbar;

//    [tabbar presentViewController:lvc animated:YES completion:nil];


    
//    SceneDelegate * appDelegate = (SceneDelegate*)[UIApplication sharedApplication].delegate;
//
//    UISceneSession *session = [UIApplication sharedApplication].connectedScenes
//
//    appDelegate.window.rootViewController = [SSKJ_TabbarController new];
    

}
-(void)backToHomeAction
{
    SSKJ_TabbarController *tabbar = [SSKJ_TabbarController new];
    self.view.window.rootViewController = tabbar;
    
};

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
     
    self.navigationController.delegate = self;
    
}


- (BOOL)needHiddenBarInViewController:(UIViewController*)viewController {

    BOOL needHideNaivgaionBar =NO;

 if([viewController isKindOfClass: [LXScoreMarkeDetailViewController class]] || [viewController isKindOfClass: [LXPublishAlertViewController class]] ||  [viewController isKindOfClass: [DSLoginViewController class]] ||[viewController isKindOfClass:[BookMineViewController class]]) {
        needHideNaivgaionBar =YES;
    }

    return needHideNaivgaionBar;

}
- (BOOL)needShowPublish:(UIViewController*)viewController {

    BOOL needShow =NO;
//[@"LXGetOrderViewController",@"LXNewsViewController",@"tempViewController",@"LXLearnningViewController",@"LXMineViewController"]
 if([viewController isKindOfClass: [LXGetOrderViewController class]] || [viewController isKindOfClass: [LXNewsViewController class]] || [viewController isKindOfClass: [LXLearnningViewController class]] || [viewController isKindOfClass: [LXMineViewController class]]|| [viewController isKindOfClass: [LXNewsListViewController class]]) {
        needShow =YES;
    }

    return needShow;

}


- (void)navigationController:(UINavigationController*)navigationController willShowViewController:(UIViewController*)viewController animated:(BOOL)animated {

    BOOL hide = [self needHiddenBarInViewController:viewController];
    if([navigationController isKindOfClass:[UIImagePickerController class]]) hide = YES;
    [self.navigationController setNavigationBarHidden:hide

                                             animated: animated];

    if ([viewController isKindOfClass:[LXMineViewController class]]) {
        [[UINavigationBar appearance] setBarTintColor:kMainBgColor];
    }else{
        [[UINavigationBar appearance] setBarTintColor:kWhiteColor];
    }
    
   
}
-(void)hiddenNavigationView{
    BOOL hide = [self needHiddenBarInViewController:self];
    if([self.navigationController isKindOfClass:[UIImagePickerController class]]) hide = YES;
       [self.navigationController setNavigationBarHidden:hide

                                                animated: YES];

       if ([self isKindOfClass:[LXMineViewController class]]) {
           [[UINavigationBar appearance] setBarTintColor:kMainBgColor];
       }else{
           [[UINavigationBar appearance] setBarTintColor:kWhiteColor];
       }
}
///消失
-(void)dissMissAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
};
-(void)preasntVc:(UIViewController *)vc
{
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
     [self.navigationController presentViewController:vc animated:YES completion:^{
         //
         vc.view.superview.backgroundColor = [UIColor clearColor];
     }];
}
-(void)naviPushVc:(UIViewController *)vc{
    [self.navigationController pushViewController:vc animated:YES];
}
-(BOOL)ifNoLoginGotoLoginAction
{
    if (!kLogin) {
        [self presentLoginAction];
    }
    return kLogin;
}
-(void)gotoWebWithUrl:(NSString *)url title:(NSString *)title{
    SSKJ_H5Web_ViewController *vc = [[SSKJ_H5Web_ViewController alloc]init];
    vc.url = url;
    vc.title = title;
    [self.navigationController pushViewController:vc animated:YES];
}
@end

//
//  BaseNavigationViewController.m
//  XILAIBANG
//
//  Created by ff on 2019/9/10.
//  Copyright © 2019 大點哥. All rights reserved.
//

#import "BaseNavigationViewController.h"

@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UINavigationBar appearance] setBarTintColor:kMainBgColor];
    [self.navigationBar setTranslucent:NO];
//    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationBar setShadowImage:[UIImage new]];
//    [self.navigationBar setTitleTextAttributes:@{
//        NSForegroundColorAttributeName : [DYColorHelper default_51_221_Color],
//        NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:20]}
//     ];
//    [self.navigationBar setTitleTextAttributes:@{
//       NSForegroundColorAttributeName : COLOR_51,
//       NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:20]}
//    ];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    if (DYApplication.applicationState == UIApplicationStateBackground) {
        return;
    }
    if (previousTraitCollection == nil) {
        return;
    }
//    [self.navigationBar setTitleTextAttributes:@{
//        NSForegroundColorAttributeName : [DYColorHelper default_51_153_Color],
//    NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:20]}
//    ];
//    [self.navigationBar setTitleTextAttributes:@{
//        NSForegroundColorAttributeName : COLOR_51,
//    NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:20]}
//    ];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (@available(iOS 11.0, *)) {
        //关键适配
        UIImage *backButtonImage = [[UIImage imageNamed:@"base_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.navigationBar.backIndicatorImage = backButtonImage;
        self.navigationBar.backIndicatorTransitionMaskImage = backButtonImage;
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-SCREEN_WIDTH, 0)forBarMetrics:UIBarMetricsDefault];//UIOffsetMake(-kScreenWidth, 0)zh只要横向偏移，纵向偏移返回图标也会偏移
    }
    else{
        //设置返回按钮的图片
        UIImage *backButtonImage = [[UIImage imageNamed:@"base_back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
        [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        //将返回按钮的文字position设置不在屏幕上显示
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-SCREEN_WIDTH, -SCREEN_HEIGHT)forBarMetrics:UIBarMetricsDefault];
    }
    self.interactivePopGestureRecognizer.delegate=(id)self;
    if (self.childViewControllers.count > 0) {
        //哥么你要想隐藏.那么必须在我push之前给我设置
        viewController.hidesBottomBarWhenPushed = YES;
    }
    //调用父类的方法
    [super pushViewController:viewController animated:animated];
}

-(void)back {
    [self popViewControllerAnimated:YES];
}

@end

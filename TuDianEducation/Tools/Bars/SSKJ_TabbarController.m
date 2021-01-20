//
//  SSKJ_TabbarController.m
//  SSKJ
//
//  Created by 刘小雨 on 2018/12/6.
//  Copyright © 2018年 刘小雨. All rights reserved.
//

#import "SSKJ_TabbarController.h"

#import "UIImage+RoundedRectImage.h"

#import "SSKJ_BaseNavigationController.h"

#import "DYStartADView.h"

//
//#import "JB_Main_Root_ViewController.h"
//
//#import "JB_FBC_Root_ViewController.h"
//
//#import "JB_BBTrade_Root_ViewController.h"
//
//#import "JB_Login_ViewController.h"
//
////
//#import "MineViewController.h"
//
//#import "MessageViewController.h"
//
//#import "PropertyViewController.h"

#define kControllerNameArray @[@"BookHomeViewController",@"BookMovieViewController",@"BookFaceViewController",@"BookShopCarViewController",@"BookMineViewController"]

#define kControllerTitleArray @[SSKJLocalized(@"首页", nil),SSKJLocalized(@"影音书", nil),SSKJLocalized(@"面对面", nil),SSKJLocalized(@"购物车", nil),@"我的"]
#define kImageNameArray @[@"shouye(moren)",@"yingyinshu(moren)",@"nianduimian(moren)",@"gouwuche(moren)",@"wode(moren)"]
#define kSelectedImageNameArray @[@"shouye",@"yingyinshu",@"mianduimian",@"gouwuche",@"wode"]

@interface SSKJ_TabbarController ()<UITabBarControllerDelegate>

{
    NSArray *sortedArray;
    NSMutableArray *selArr;
}
@property (nonatomic, copy)void (^sortBlock)(NSArray *arr);

@property (nonatomic ,strong)NSMutableArray * imagesArray;

@end

@implementation SSKJ_TabbarController

- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize

{
    UIGraphicsBeginImageContextWithOptions(newSize, 0, [UIScreen mainScreen].scale);
    //UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  newImage;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self settingTabrView];
//    self.imagesArray = [NSMutableArray array];
//    for (int i=0; i<5; i++) {
//        NSMutableArray *images = [NSMutableArray array];
//        switch (i) {
//            case 0:
//                for (int i= 1; i <17; i++) {
//                    NSString *str = [NSString stringWithFormat:@"100%02d",i];
//                    UIImage *im = BUNDLE_PNGIMG(@"base", str);
//                    [images addObject:(__bridge UIImage *)im.CGImage];
//                }
//                break;
//            case 1:
//                for (int i= 1; i <17; i++) {
//                    NSString *str = [NSString stringWithFormat:@"200%02d",i];
//                    UIImage *im = BUNDLE_PNGIMG(@"base", str);
//                    [images addObject:(__bridge UIImage *)im.CGImage];
//                }
//                break;
//            case 2:
//                for (int i= 1; i <68; i++) {
//                    NSString *str = [NSString stringWithFormat:@"tabbar_500%02d",i];
//                    UIImage *im = BUNDLE_PNGIMG(@"base", str);
//                    [images addObject:(__bridge UIImage *)im.CGImage];
//                }
//                break;
//                break;
//            case 3:
//                for (int i= 1; i <17; i++) {
//                    NSString *str = [NSString stringWithFormat:@"300%02d",i];
//                    UIImage *im = BUNDLE_PNGIMG(@"base", str);
//                    [images addObject:(__bridge UIImage *)im.CGImage];
//                }
//                break;
//            case 4:
//                for (int i= 1; i <17; i++) {
//                    NSString *str = [NSString stringWithFormat:@"400%02d",i];
//                    UIImage *im = BUNDLE_PNGIMG(@"base", str);
//                    [images addObject:(__bridge UIImage *)im.CGImage];
//                }
//                break;
//            default:
//                break;
//        }
//        [self.imagesArray addObject:images];
        
  //  }
    
    // 添加所有子控制器
    [self addAllChildViewController];
    self.delegate = self;
    

    if ([SSKJUserDefaultsGET(@"launch") isEqual:@"1"]) {
        self.view.hidden = YES;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
        for (int i= 1; i <= 50; i++) {
            [arr addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"100%02d.jpg",i] ofType:@""]]];
        }
        DYStartADView *adv = [[DYStartADView alloc]initWithType:(DYADType_FullADScreen) Para:@{@"img":arr} complate:^(id  _Nullable obj) {
            [[NSUserDefaults standardUserDefaults]setBool:0 forKey:@"onceLogin"];
            self.view.hidden = NO;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"adsDismissedAction" object:nil];
        }];
       // [adv show];
        SSKJUserDefaultsSET(@"0", @"launch");
    }

    self.selectedIndex = 0;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.selectedIndex = 0;
//    });
    
}
-(void)settingTabrView{
//    UIImage *img = [UIImage imageNamed:@"dibu_bg"];
//    self.tabBar.backgroundImage = img;
//
//    self.tabBar.shadowImage = [UIImage new];
    
// //添加阴影
    self.tabBar.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.tabBar.layer.shadowOffset = CGSizeMake(0, -5);
    self.tabBar.layer.shadowOpacity = 0.3;
}
/**
 *  当第一次使用这个类或者子类的时候调用，作用：初始化
 */
#pragma mark - 改变 tabbar 选中状态下的文字颜色
+ (void)initialize
{
    //获取当前这个类下面的所有 tabBarItem
    //    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    //
    //    NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
    //    //改变选中 tabbar 字体的颜色
    //    [mutDic setObject:kMainTextColor forKey:NSForegroundColorAttributeName];
    //    [item setTitleTextAttributes:mutDic forState:UIControlStateSelected];
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kGrayTxtColor, NSForegroundColorAttributeName, systemFont(11), NSFontAttributeName,nil] forState:UIControlStateNormal];
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kBlueColor, NSForegroundColorAttributeName, systemFont(11), NSFontAttributeName,nil] forState:UIControlStateSelected];
    
    UITabBar *tabBar = [UITabBar appearance];
    

    [tabBar setBarTintColor:kWhiteColor];
    tabBar.translucent = NO;
    
}

#pragma mark - 加载所有的子控制器
- (void)addAllChildViewController
{
    NSMutableArray *imgArr = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *selectImgArr = [NSMutableArray arrayWithCapacity:0];
//    for (int i=0; i<5; i++) {
//        if (i == 0) {
//            UIImage *im =
//            [self imageWithImageSimple:BUNDLE_PNGIMG(@"base", @"10001") scaledToSize:(CGSizeMake(32, 32))];
//            UIImage *imim = [self imageWithImageSimple:BUNDLE_PNGIMG(@"base", @"10016") scaledToSize:(CGSizeMake(34, 34))];
//            [imgArr addObject:im];
//            [selectImgArr addObject:imim];
//        }
//        if (i == 1) {
//            UIImage *im =
//            [self imageWithImageSimple:BUNDLE_PNGIMG(@"base", @"20001") scaledToSize:(CGSizeMake(32, 32))];
//            UIImage *imim = [self imageWithImageSimple:BUNDLE_PNGIMG(@"base", @"20017") scaledToSize:(CGSizeMake(34, 34))];
//            [imgArr addObject:im];
//            [selectImgArr addObject:imim];
//        }
//        if (i == 2) {
//            UIImage *im =
//            [self imageWithImageSimple:BUNDLE_PNGIMG(@"base", @"tabbar_50001") scaledToSize:(CGSizeMake(48, 48))];
//            UIImage *imim = [self imageWithImageSimple:BUNDLE_PNGIMG(@"base", @"tabbar_50067") scaledToSize:(CGSizeMake(50, 50))];
//            [imgArr addObject:im];
//            [selectImgArr addObject:imim];
//        }
//        if (i == 3) {
//            UIImage *im =
//            [self imageWithImageSimple:BUNDLE_PNGIMG(@"base", @"30001") scaledToSize:(CGSizeMake(32, 32))];
//            UIImage *imim = [self imageWithImageSimple:BUNDLE_PNGIMG(@"base", @"30017") scaledToSize:(CGSizeMake(34, 34))];
//            [imgArr addObject:im];
//            [selectImgArr addObject:imim];
//        }
//        if (i == 4) {
//            UIImage *im =
//            [self imageWithImageSimple:BUNDLE_PNGIMG(@"base", @"40001") scaledToSize:(CGSizeMake(32, 32))];
//            UIImage *imim = [self imageWithImageSimple:BUNDLE_PNGIMG(@"base", @"40017") scaledToSize:(CGSizeMake(34, 34))];
//            [imgArr addObject:im];
//            [selectImgArr addObject:imim];
//        }
//
//    }
    selArr = [NSMutableArray arrayWithArray:selectImgArr];
    for (int i = 0; i < kControllerNameArray.count; i++)
    {
        NSString *controllerStr = kControllerNameArray[i];
       NSString *title = kControllerTitleArray[i];
        UIImage *image = [UIImage imageNamed: kImageNameArray[i]];
        UIImage *selectedImage = [UIImage imageNamed: kSelectedImageNameArray[i]];
        id controller = [[NSClassFromString(controllerStr) alloc] init] ;
        [self addChildVC:controller title:title image:image selectedImage:selectedImage];
    }
    
}

/**
 *  添加子控制器
 *
 *  @param childVC      子控制器
 *  @param title        标题
 *  @param image        正常状态图片
 *  @param seletedImage 选中时的图片
 */
- (void)addChildVC:(UIViewController *)childVC title:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)seletedImage
{
    SSKJ_BaseNavigationController *naviVC = [[SSKJ_BaseNavigationController alloc] initWithRootViewController:childVC];
    childVC.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIImage *selectImg = BUNDLE_PNGIMG(@"base", seletedImage);

    childVC.tabBarItem.selectedImage = [seletedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    naviVC.tabBarItem.title = title;
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kGrayTxtColor, NSForegroundColorAttributeName, systemFont(12), NSFontAttributeName,nil] forState:UIControlStateNormal];


    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kGreenColor, NSForegroundColorAttributeName, systemFont(12), NSFontAttributeName,nil] forState:UIControlStateSelected];

    
    [self addChildViewController:naviVC];
    
}



- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    
//    SSKJ_BaseNavigationController *navc = (SSKJ_BaseNavigationController *)viewController;
//    
//    if ([navc.topViewController isKindOfClass:[JB_Account_Root_ViewController class]]) {
//        
//        if (!kLogin) {
//            JB_Login_ViewController *loginVc = [[JB_Login_ViewController alloc]init];
//            SSKJ_BaseNavigationController *loginNavc = [[SSKJ_BaseNavigationController alloc]initWithRootViewController:loginVc];
//            [self presentViewController:loginNavc animated:YES completion:nil];
//            return NO;
//        }
//    }
    return YES;
}

//- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
//   NSMutableArray *tabBarBtnArray = [NSMutableArray array];
//   int index = [NSNumber numberWithUnsignedInteger:[tabBar.items indexOfObject:item]].intValue;
//   // 获取UITabBarButton
//   for (int i = 0 ;i < self.tabBar.subviews.count; i++ ) {
//       UIView * tabBarButton = self.tabBar.subviews[i];
//       if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
//           [tabBarBtnArray addObject:tabBarButton];
//       }
//   }
//    NSArray *aa = [tabBarBtnArray sortedArrayUsingComparator:^(UIView *obj1,UIView *obj2){
//        return obj1.frame.origin.x < obj2.frame.origin.x == YES? NSOrderedAscending:NSOrderedDescending;
//    }];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self ani:index arr:aa];
//    });
//}

//- (void)ani:(int)index arr:(NSArray *)arr{
//    //获取当前的UITabBarButton
//            UIView *TabBarButton = arr[index];
//            NSArray *images = self.imagesArray[index];
//    //         DYLog(@"~~~%@~~~%d",sortedArray,index);
//            for (UIView *imageV in TabBarButton.subviews) {
//                if ([imageV isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
//                    DYLog(@"----%f",TabBarButton.frame.origin.x);
//                    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
//                    //animation.delegate = self;
//                    animation.values = images;
//                    animation.duration = 0.6;// images.count * 0.08;
//                    animation.calculationMode = kCAAnimationCubic;
//                    imageV.layer.backgroundColor = WHITE_COLOR.CGColor;
//                    [imageV.layer addAnimation:animation forKey:nil];
//                }
//            }
//}

@end

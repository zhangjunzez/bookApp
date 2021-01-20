//
//  BkDuihuanSucessViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/8.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "BkDuihuanSucessViewController.h"

@interface BkDuihuanSucessViewController ()

@end

@implementation BkDuihuanSucessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *duihuanchenggong = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"duihuanchenggong"]];
    duihuanchenggong.top = ScaleW(30);
    duihuanchenggong.centerX = ScreenWidth/2.f;
    _sucessLabel = [WLTools allocLabel:@"恭喜您成功兑换" font:systemFont(ScaleW(16)) textColor:kMainTxtColor frame:CGRectMake(0, ScaleW(20) + duihuanchenggong.bottom, ScreenWidth, ScaleW(16)) textAlignment:(NSTextAlignmentCenter)];
    [self.view addSubview:duihuanchenggong];
    [self.view addSubview:_sucessLabel];
    self.view.backgroundColor = kWhiteColor;
    UIButton *seeBtn = [WLTools allocButtonTitle:@"查看订单" font:systemFont(ScaleW(15)) textColor:kRedColor image:nil frame:CGRectMake(ScaleW(114), ScreenHeight - Height_NavBar - ScaleW(200), ScaleW(146), ScaleW(44)) sel:@selector(seeOrderBtn:) taget:self];
    seeBtn.backgroundColor = kSubBacColor;
    seeBtn.cornerRadius = seeBtn.height/2.f;
    [self.view addSubview:seeBtn];
    
}
-(void)seeOrderBtn:(UIButton *)sender
{
    
}


@end

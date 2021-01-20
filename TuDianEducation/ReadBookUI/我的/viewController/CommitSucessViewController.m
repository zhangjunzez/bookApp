//
//  CommitSucessViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/9.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "CommitSucessViewController.h"
#import "MoneyBackOrderViewController.h"
@interface CommitSucessViewController ()

@end

@implementation CommitSucessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *duihuanchenggong = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"duihuanchenggong"]];
    duihuanchenggong.top = ScaleW(30);
    duihuanchenggong.centerX = ScreenWidth/2.f;
    UILabel *sucessLabel = [WLTools allocLabel:@"提交成功" font:systemFont(ScaleW(16)) textColor:kMainTxtColor frame:CGRectMake(0, ScaleW(20) + duihuanchenggong.bottom, ScreenWidth, ScaleW(16)) textAlignment:(NSTextAlignmentCenter)];
    UILabel *subsucessLabel = [WLTools allocLabel:@"请联系商家尽快审核" font:systemFont(ScaleW(13)) textColor:kGrayTxtColor frame:CGRectMake(0, ScaleW(13) + sucessLabel.bottom, ScreenWidth, ScaleW(13)) textAlignment:(NSTextAlignmentCenter)];
    [self.view addSubview:duihuanchenggong];
    [self.view addSubview:sucessLabel];
    [self.view addSubview:subsucessLabel];
    self.view.backgroundColor = kWhiteColor;
    UIButton *seeBtn = [WLTools allocButtonTitle:@"确定" font:systemFont(ScaleW(15)) textColor:kRedColor image:nil frame:CGRectMake(ScaleW(114), ScreenHeight - Height_NavBar - ScaleW(200), ScaleW(146), ScaleW(44)) sel:@selector(seeOrderBtn:) taget:self];
    seeBtn.backgroundColor = kSubBacColor;
    seeBtn.cornerRadius = seeBtn.height/2.f;
    [self.view addSubview:seeBtn];
    
}
-(void)seeOrderBtn:(UIButton *)sender
{
    MoneyBackOrderViewController *vc = [[MoneyBackOrderViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end

//
//  MyServerTelViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/11.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "MyServerTelViewController.h"

@interface MyServerTelViewController ()
@property (nonatomic,strong) UILabel *telLabel;
@end

@implementation MyServerTelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"客服热线";
    self.view.backgroundColor = kWhiteColor;
    UIButton *telBtn = [WLTools allocButtonTitle:@"" font:systemFont(ScaleW(0)) textColor:kWhiteColor image:nil frame:CGRectMake(ScaleW(29), ScaleW(20), ScaleW(317), ScaleW(37)) sel:@selector(telAction) taget:self];
    telBtn.backgroundColor = kSubBacColor;
    [telBtn setBorderWithWidth:.5 andColor:kGrayTxtColor];
    _telLabel = [WLTools allocLabel:@"010-11111111" font:systemFont(ScaleW(12)) textColor:kGrayTxtColor frame:CGRectMake(ScaleW(20), ScaleW(0), ScaleW(200), telBtn.height) textAlignment:(NSTextAlignmentLeft)];
    [telBtn addSubview:_telLabel];
    telBtn.cornerRadius = ScaleW(5);
    [self.view addSubview:telBtn];
}
-(void)telAction{
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

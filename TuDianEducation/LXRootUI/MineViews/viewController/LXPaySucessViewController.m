//
//  LXPaySucessViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/30.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXPaySucessViewController.h"

@interface LXPaySucessViewController ()
@property (nonatomic, strong) UIImageView *sucessImg;
@property (nonatomic, strong) UILabel *sucessLabel;
@property (nonatomic, strong) UIButton *backBtn;

@property (nonatomic, strong) UIScrollView *scrollView;


@end

@implementation LXPaySucessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.view.backgroundColor = kWhiteColor;
    self.title = @"支付成功";
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.sucessImg];
    [self.scrollView addSubview:self.sucessLabel];
    [self.scrollView addSubview:self.backBtn];
   
    self.scrollView.contentSize = CGSizeMake(0, self.backBtn.bottom + ScaleW(100));
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    }
    return _scrollView;
}
-(UIImageView *)sucessImg{
    if (!_sucessImg) {
        _sucessImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, ScaleW(96), ScaleW(88), ScaleW(88))];
        _sucessImg.centerX = ScreenWidth/2.f;
        _sucessImg.image = BUNDLE_PNGIMG(@"mineCenter", @"sucess");
        
    }
    return _sucessImg;
}

-(UILabel *)sucessLabel{
    if (!_sucessLabel ) {
        _sucessLabel = [WLTools allocLabel:@"支付成功" font:systemFont(ScaleW(24)) textColor:kMainTxtColor frame:CGRectMake(0, ScaleW(17) + _sucessImg.bottom, ScreenWidth, ScaleW(24)) textAlignment:(NSTextAlignmentCenter)];
        
    }
    return _sucessLabel;
}



-(UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn btn:_backBtn font:ScaleW(15) textColor:kWhiteColor text:@"返回" image:nil sel:@selector(backAction:) taget:self];
        _backBtn.frame = CGRectMake(0, ScaleW(46) +_sucessLabel.bottom, ScaleW(204), ScaleW(44));
        _backBtn.centerX = ScreenWidth/2.f;
        _backBtn.backgroundColor = kBlueColor;
    }
    return _backBtn;
}

-(void)backAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
         //  !self.reloadDetailBlock?:self.reloadDetailBlock();
       }];
}

@end

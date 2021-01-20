//
//  LXGetOrderFailedNOIdViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/30.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//



#import "LXGetOrderFailedNOIdViewController.h"

@interface LXGetOrderFailedNOIdViewController ()<UITextViewDelegate>
@property (nonatomic, strong) UIView *bacView;
@property (nonatomic, strong) UILabel *lessNameLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contenLabel;
@property (nonatomic, strong) UIButton *commitBtn;
@property (nonatomic, strong) UIButton *cancellBtn;


@end

@implementation LXGetOrderFailedNOIdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.view.backgroundColor = kBacColor;
   
    [self.view addSubview:self.bacView];
    [self.bacView addSubview:self.titleLabel];
    [self.bacView addSubview:self.contenLabel];
    [self.bacView addSubview:self.commitBtn];
    [self.bacView addSubview:self.cancellBtn];
    
    
}
-(UIView *)bacView{
    if (!_bacView) {
        _bacView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(27), 0, ScaleW(320), ScaleW(185))];
        _bacView.centerY = ScreenHeight*2/5.f;
        [_bacView setCornerRadius:ScaleW(5)];
        _bacView.backgroundColor = kWhiteColor;
    }
    return _bacView;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //self.navigationController.navigationBarHidden = YES;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:@"抢单失败" font:systemBoldFont(19) textColor:kMainTxtColor frame:CGRectMake(0, ScaleW(30), _bacView.width, ScaleW(19)) textAlignment:(NSTextAlignmentCenter)];
        
    }
    return _titleLabel;
}

-(UILabel *)contenLabel{
    if (!_contenLabel) {
        _contenLabel = [WLTools allocLabel:@"请通过实名认证后，再进行抢单！" font:systemFont(14) textColor:kGrayTxtColor frame:CGRectMake(0, ScaleW(25) + _titleLabel.bottom, _bacView.width, ScaleW(14)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _contenLabel;
}

//RoundedRectangle

-(UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [WLTools allocButtonTitle:@"立即认证" font:systemBoldFont(14) textColor:kWhiteColor image:nil frame:CGRectMake(ScaleW(175), _bacView.height - ScaleW(33) - ScaleW(20), ScaleW(120), ScaleW(33)) sel:@selector(commitAction:) taget:self];
              _commitBtn.backgroundColor = kBlueColor;
              [_commitBtn setCornerRadius:_commitBtn.height/2.f];
    }
    return _commitBtn;
}
-(UIButton *)cancellBtn{
    if (!_cancellBtn) {
        _cancellBtn = [WLTools allocButtonTitle:@"取消" font:systemBoldFont(14) textColor:kBlueColor image:nil frame:CGRectMake(ScaleW(40), _bacView.height - ScaleW(33) - ScaleW(20), ScaleW(120), ScaleW(33)) sel:@selector(cancellAction:) taget:self];
        [_cancellBtn setBorderWithWidth:1 andColor:kBlueColor];
        [_cancellBtn setCornerRadius:_commitBtn.height/2.f];
    }
    return _cancellBtn;
}
-(void)commitAction:(UIButton *)sender
{
   [self dismissAction];
}
-(void)cancellAction:(UIButton *)sender{
    [self dismissAction];
}

-(void)dismissAction{
    [self dismissViewControllerAnimated:YES completion:nil];
    
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

//
//  LXRealCommitSucessAlertVc.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/24.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//


#import "LXRealCommitSucessAlertVc.h"

@interface LXRealCommitSucessAlertVc ()
@property (nonatomic, strong) UIView *bacView;
@property (nonatomic, strong) UILabel *lessNameLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *lessMessageLabel;
@property (nonatomic, strong) UIButton *commitBtn;



@end

@implementation LXRealCommitSucessAlertVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.view.backgroundColor = kBacColor;
   
    [self.view addSubview:self.bacView];
    [self.bacView addSubview:self.titleLabel];
    [self.bacView addSubview:self.lessMessageLabel];
    [self.bacView addSubview:self.commitBtn];
    
    
}
-(UIView *)bacView{
    if (!_bacView) {
        _bacView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(27), 0, ScaleW(320), ScaleW(170))];
        _bacView.centerY = ScreenHeight/3.f;
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
        _titleLabel = [WLTools allocLabel:@"提交成功" font:systemFont(ScaleW(16)) textColor:kMainTxtColor frame:CGRectMake(0, ScaleW(30), _bacView.width, ScaleW(16)) textAlignment:(NSTextAlignmentCenter)];
        
    }
    return _titleLabel;
}

-(UILabel *)lessMessageLabel{
    if (!_lessMessageLabel) {
        _lessMessageLabel = [WLTools allocLabel:@"发布成功，请耐心等待后台审核！" font:systemFont(ScaleW(14)) textColor:kGrayTxtColor frame:CGRectMake(0, ScaleW(20)+_titleLabel.bottom, _titleLabel.width, ScaleW(14)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _lessMessageLabel;
}

//RoundedRectangle

-(UIButton *)commitBtn{
    if (!_commitBtn) {
       _commitBtn = [WLTools allocButtonTitle:@"我知道了" font:systemBoldFont(14) textColor:kWhiteColor image:nil frame:CGRectMake(ScaleW(100), ScaleW(30) + _lessMessageLabel.bottom, ScaleW(120), ScaleW(33)) sel:@selector(commitAction:) taget:self];
              _commitBtn.backgroundColor = kBlueColor;
              [_commitBtn setCornerRadius:_commitBtn.height/2.f];
    }
    return _commitBtn;
}

-(void)commitAction:(UIButton *)sender
{
    !self.callBackBlcok?:self.callBackBlcok();
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

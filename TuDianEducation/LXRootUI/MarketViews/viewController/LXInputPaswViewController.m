//
//  LXInputPaswViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/2.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//


#import "LXInputPaswViewController.h"

@interface LXInputPaswViewController ()<UITextViewDelegate>
@property (nonatomic, strong) UIView *bacView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic,strong) UIButton *forgetPayPswBtn;
@property (nonatomic,strong) UITextField *inputTf;
@property (nonatomic, strong) UIButton *commitBtn;
@property (nonatomic, strong) UIButton *cancellBtn;


@end

@implementation LXInputPaswViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.view.backgroundColor = kBacColor;
   
    [self.view addSubview:self.bacView];
    [self.bacView addSubview:self.titleLabel];
    [self.bacView addSubview:self.forgetPayPswBtn];
    [self.bacView addSubview:self.inputTf];
    [self.bacView addSubview:self.commitBtn];
    [self.bacView addSubview:self.cancellBtn];
    
    
}
-(UIView *)bacView{
    if (!_bacView) {
        _bacView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(27), 0, ScaleW(320), ScaleW(220))];
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
        _titleLabel = [WLTools allocLabel:@"请输入交易密码" font:systemBoldFont(16) textColor:kMainTxtColor frame:CGRectMake(0, ScaleW(30), _bacView.width, ScaleW(16)) textAlignment:(NSTextAlignmentCenter)];
        
    }
    return _titleLabel;
}


-(UIButton *)forgetPayPswBtn{
    if (!_forgetPayPswBtn) {
        _forgetPayPswBtn = [WLTools allocButtonTitle:@"忘记支付密码" font:systemFont(ScaleW(15)) textColor:kBlueColor image:nil frame:CGRectMake(0, ScaleW(9) + _titleLabel.bottom, ScaleW(120), ScaleW(35)) sel:@selector(forgetPayPassWord:) taget:self];
        self.forgetPayPswBtn.centerX = _bacView.width/2.f;
    }
    return _forgetPayPswBtn;
}
-(UITextField *)inputTf
{
    if (!_inputTf) {
        _inputTf = [WLTools allocTextFieldTextFont:ScaleW(14) placeHolderFont:ScaleW(14) text:nil placeText:@"请输入支付密码" textColor:kMainTxtColor placeHolderTextColor:kGrayTxtColor frame:CGRectMake(ScaleW(38), ScaleW(14) + _forgetPayPswBtn.bottom, ScaleW(243), ScaleW(35))];
        [_inputTf setBorderWithWidth:1 andColor:kMainLineColor];
        _inputTf.cornerRadius = _inputTf.height/2.f;
        _inputTf.textAlignment = NSTextAlignmentCenter;
        _inputTf.secureTextEntry = YES;
        _inputTf.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _inputTf;
}
//RoundedRectangle

-(UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [WLTools allocButtonTitle:@"确认" font:systemBoldFont(14) textColor:kWhiteColor image:nil frame:CGRectMake(ScaleW(175), _bacView.height - ScaleW(33) - ScaleW(20), ScaleW(120), ScaleW(33)) sel:@selector(commitAction:) taget:self];
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
    NSString *message =@"";
    
    if (_inputTf.text) {
        message = [WLTools md5:_inputTf.text];
    }
    !self.callBackBlock?:self.callBackBlock(message);
   [self dismissAction];
}
-(void)cancellAction:(UIButton *)sender{
    [self dismissAction];
}

-(void)dismissAction{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)forgetPayPassWord:(UIButton *)sender
{
    WS(weakSelf);
    [self dismissViewControllerAnimated:YES completion:^{
        !weakSelf.forgetPayPassWordBlock?:weakSelf.forgetPayPassWordBlock();
    }];
}
@end

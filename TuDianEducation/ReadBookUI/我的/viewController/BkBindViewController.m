//
//  BkBindViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/11.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "BkBindViewController.h"
#import "RegesiterItemView.h"
#import "RegularExpression.h"

@interface BkBindViewController ()

@property (nonatomic,strong) RegesiterItemView *accountView;
@property (nonatomic,strong) RegesiterItemView *verCodeView;
@property (nonatomic,strong) UIButton *getCodeBtn;
@property (nonatomic,strong) UIButton *commitBtn;

@property (nonatomic, strong)NSTimer *timer;
@property(nonatomic)NSInteger timeCount;
@end

@implementation BkBindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定手机号";
    [self.view addSubview:self.accountView];
    [self.view addSubview:self.verCodeView];
    [self.view addSubview:self.commitBtn];
}

-(RegesiterItemView *)accountView{
    if (!_accountView) {
        _accountView = [[RegesiterItemView alloc]initWithTop: ScaleW(20) isPhoneAccount:YES placeHolder:@"请输入手机号" red:NO];
        _accountView.inputTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _accountView;
}
-(RegesiterItemView *)verCodeView{
    if (!_verCodeView) {
        _verCodeView = [[RegesiterItemView alloc]initWithTop: _accountView.bottom isPhoneAccount:NO placeHolder:@"验证码" red:NO];
        _verCodeView.inputTextFiled.keyboardType = UIKeyboardTypeNumberPad;
        [_verCodeView addSubview:self.getCodeBtn];
    }
    return _verCodeView;
}
-(UIButton *)getCodeBtn
{
    if (!_getCodeBtn) {
        _getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _getCodeBtn.frame = CGRectMake(0, 0, ScaleW(100), ScaleW(33));
        _getCodeBtn.centerY = _verCodeView.inputTextFiled.centerY;
        _getCodeBtn.right = ScreenWidth - ScaleW(32);
        [_getCodeBtn setCornerRadius:_getCodeBtn.height/2.f];
        [_getCodeBtn btn:_getCodeBtn font:ScaleW(15) textColor:kMainTxtColor text:@"获取验证码" image:nil sel:@selector(getCodeBtnAction:) taget:self];
       
        _getCodeBtn.backgroundColor = kGrayBtnBacColor;
        _getCodeBtn.cornerRadius = _getCodeBtn.height/2.f;
        
    }
    return _getCodeBtn;
}
-(UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [WLTools allocButtonTitle:@"立即绑定" font:systemFont(ScaleW(15)) textColor:kWhiteColor image:nil frame:CGRectMake(ScaleW(30), _verCodeView.bottom + ScaleW(50), ScaleW(316), ScaleW(40)) sel:@selector(commitBtnAction:) taget:self];
        _commitBtn.backgroundColor = kGreenColor;
        [_commitBtn setCornerRadius:_commitBtn.height/2.f];
    }
    return _commitBtn;
}
-(void)commitBtnAction:(UIButton *)sender
{
    
}
-(void)getCodeBtnAction:(UIButton *)sender
{
    [self getCodeRequst];
}
-(void)getCodeRequst{
   if (self.timeCount >= 1) {
        return;
    }
    
    if (!self.accountView.inputTextFiled.text.length) {
        [MBProgressHUD showError:SSKJLanguage(@"请输入手机号")];
        return;
    }
    
    if (![RegularExpression validateMobile:self.accountView.inputTextFiled.text]) {
        [MBProgressHUD showError:SSKJLanguage(@"手机号码格式错误")];
        return;
    }
    

    WS(weakSelf);
    [NetWorkTools postConJSONWithUrl:kGetCodeUrl parameters:@{@"phone":_accountView.inputTextFiled.text} success:^(id responseObject) {
        NSString *result = responseObject[@"result"];
        NSString *resultNote = responseObject[@"resultNote"];
        if ([result integerValue] == 0) {
            [weakSelf timerStart];
        }
        [MBProgressHUD showError:resultNote];
    } fail:^(NSError *error) {
        
    }];
}
- (void)timerAction:(NSTimer *)sender{
    self.timeCount--;
    if (self.timeCount >= 1) {
        [self.getCodeBtn setTitle:[NSString stringWithFormat:@"%02zdS", self.timeCount] forState:UIControlStateNormal];
    }else{
        
        [self timerStop];
    }
}

- (void)timerStart{
    [self timerStop];
    self.timeCount = 61;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    [self.timer fire];
  //  [self.verCodeView.getCodeBtn setTitle:@"" forState:UIControlStateNormal];

}

- (void)timerStop{
    if (!self.timer) {
        return;
    }
    self.timeCount = 0;
    [self.timer invalidate];
    self.timer = nil;
    //self.countLabel.text = @"";
    
    [self.getCodeBtn setTitle:SSKJLanguage(@"获取验证码") forState:UIControlStateNormal];

}

@end

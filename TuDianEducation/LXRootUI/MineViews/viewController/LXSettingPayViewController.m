//
//  LXSettingPayViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/4.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//



#import "LXSettingPayViewController.h"
#import "LoginInputView.h"
#import "RegularExpression.h"
@interface LXSettingPayViewController ()
@property (nonatomic,strong) LoginInputView *phoneNumView;
@property (nonatomic,strong) LoginInputView *verCodeView;
@property (nonatomic,strong) LoginInputView *settingLoginView;
@property (nonatomic,strong) LoginInputView *ensureLoginView;
@property (nonatomic,strong) UIButton *commitBtn;
@property (nonatomic, strong)NSTimer *timer;
@property(nonatomic)NSInteger timeCount;
@end

@implementation LXSettingPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"支付密码设置";
    [self viewConfig];
}

-(void)viewConfig{
    [self.view addSubview:self.phoneNumView];
    [self.view addSubview:self.verCodeView];
    [self.view addSubview:self.settingLoginView];
    [self.view addSubview:self.ensureLoginView];
    [self.view addSubview:self.commitBtn];
}
-(LoginInputView *)phoneNumView{
    if (!_phoneNumView) {
        _phoneNumView = [[LoginInputView alloc]initWithTop:ScaleW(20) placeHolder:@"请输入绑定手机号" hasGetCode:NO];
    }
    return _phoneNumView;
}
-(LoginInputView *)verCodeView{
    if (!_verCodeView) {
        _verCodeView = [[LoginInputView alloc]initWithTop:ScaleW(10) + _phoneNumView.bottom placeHolder:@"验证码" hasGetCode:YES];
        WS(weakSelf);
        _verCodeView.getCodeBlock = ^(UIButton * _Nonnull btn) {
            [weakSelf getCodeRequst];
        };
    }
    return _verCodeView;
}
-(LoginInputView *)settingLoginView{
    if (!_settingLoginView) {
        _settingLoginView = [[LoginInputView alloc]initWithTop:ScaleW(10) + _verCodeView.bottom placeHolder:@"6位数字" hasGetCode:NO];
        _settingLoginView.textFied.secureTextEntry = YES;
        _settingLoginView.textFied.keyboardType = UIKeyboardTypeNumberPad;
        _settingLoginView.lookPswBtn.hidden = NO;
    }
    return _settingLoginView;
}
-(LoginInputView *)ensureLoginView{
    if (!_ensureLoginView) {
        _ensureLoginView = [[LoginInputView alloc]initWithTop:ScaleW(10) + _settingLoginView.bottom placeHolder:@"6位数字" hasGetCode:NO];
        _ensureLoginView.textFied.secureTextEntry = YES;
        _ensureLoginView.lookPswBtn.hidden = NO;
        _settingLoginView.textFied.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _ensureLoginView;
}
-(UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [WLTools allocButtonTitle:@"确定" font:systemBoldFont(17) textColor:kWhiteColor image:nil frame:CGRectMake(ScaleW(37), ScaleW(80) + _ensureLoginView.bottom, ScaleW(300), ScaleW(50)) sel:@selector(commitAction:) taget:self];
        _commitBtn.backgroundColor = kBlueColor;
        [_commitBtn setCornerRadius:_commitBtn.height/2.f];
    }
    return _commitBtn;
}
//参数名    必选    类型    说明
//cmd    是    string    engineerforgetPwd
//phone    是    string    手机号
//password    是    string    新密码
//code    是    string    验证码
-(void)commitAction:(UIButton *)sender{
    if ([self pamasIsOkOrNot]) {
        NSString *passWord = [WLTools md5:_settingLoginView.textFied.text];
        NSDictionary *pamas = @{@"phone":_phoneNumView.textFied.text,@"paypassword":passWord,@"code":_verCodeView.textFied.text};
        WS(weakSelf);
           [NetWorkTools postConJSONWithUrl:kEngineeraddpaypasswordUrl parameters:pamas success:^(id responseObject) {
               
               NSString *result = responseObject[@"result"];
               NSString *resultNote = responseObject[@"resultNote"];
               if ([result integerValue] == 0) {
                   !weakSelf.gobackBlcok?:weakSelf.gobackBlcok();
                   [weakSelf.navigationController popViewControllerAnimated:YES];
               }
               [MBProgressHUD showError:resultNote];
              } fail:^(NSError *error) {
                  
        }];
    }
   
}

-(BOOL)pamasIsOkOrNot{
   
       if (!self.phoneNumView.textFied.text.length) {
          // [SSTool error:SSKJLanguage(@"请输入您的手机号")];
           [MBProgressHUD showError:@"请输入您的绑定手机号"];
           return NO;
       }

       if (!self.verCodeView.textFied.text.length) {
           [MBProgressHUD showError:SSKJLanguage(@"请输入验证码")];
          return NO;
       }
       
       if (![RegularExpression deptNumInputShouldNumber:self.verCodeView.textFied.text]) {
           [MBProgressHUD showError:SSKJLanguage(@"验证码格式不正确")];
           return NO;
       }

       
       if (!self.settingLoginView.textFied.text.length) {
           [MBProgressHUD showError:SSKJLanguage(@"请输入支付密码")];
           return NO;
       }
       
       if (![RegularExpression deptNumInputShouldSixNumber:self.settingLoginView.textFied.text]) {
           [MBProgressHUD showError:SSKJLanguage(@"支付密码格式不正确")];
          return NO;
       }
       
       if (!self.ensureLoginView.textFied.text.length) {
           [MBProgressHUD showError:SSKJLanguage(@"请输入确认支付密码")];
           return NO;
       }
       
       if (![self.ensureLoginView.textFied.text isEqualToString:self.settingLoginView.textFied.text]) {
           [MBProgressHUD showError:SSKJLanguage(@"密码不一致")];
           return NO;
       }
    return YES;
}
-(void)getCodeRequst{
   if (self.timeCount >= 1) {
        return;
    }
    
    if (!self.phoneNumView.textFied.text.length) {
        [MBProgressHUD showError:SSKJLanguage(@"请输入手机号")];
        return;
    }
    
    if (![RegularExpression validateMobile:self.phoneNumView.textFied.text]) {
        [MBProgressHUD showError:SSKJLanguage(@"手机号码格式错误")];
        return;
    }
    

    WS(weakSelf);
    [NetWorkTools postConJSONWithUrl:kGetCodeUrl parameters:@{@"phone":_phoneNumView.textFied.text} success:^(id responseObject) {
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
        [self.verCodeView.getCodeBtn setTitle:[NSString stringWithFormat:@"%02zdS", self.timeCount] forState:UIControlStateNormal];
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
    
    [self.verCodeView.getCodeBtn setTitle:SSKJLanguage(@"获取验证码") forState:UIControlStateNormal];

}
@end

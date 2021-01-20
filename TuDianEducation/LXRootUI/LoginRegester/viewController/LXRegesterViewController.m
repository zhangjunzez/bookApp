//
//  LXRegesterViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/23.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXRegesterViewController.h"
#import "LoginInputView.h"
#import "LoginDelegateView.h"

#import "RegularExpression.h"

@interface LXRegesterViewController ()
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) LoginInputView *phoneNumView;
@property (nonatomic,strong) LoginInputView *verCodeView;
@property (nonatomic,strong) LoginInputView *settingLoginView;
@property (nonatomic,strong) LoginInputView *ensureLoginView;
@property (nonatomic,strong) LoginInputView *invateView;
@property (nonatomic,strong) UIButton *agreeBtn;
@property (nonatomic, strong)LoginDelegateView *treatyView;
@property (nonatomic,strong) UIButton *commitBtn;

@property (nonatomic, strong)NSTimer *timer;
@property(nonatomic)NSInteger timeCount;
@property(nonatomic, strong)UILabel *countLabel;
@end

@implementation LXRegesterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"注册";
    [self viewConfig];
}

-(void)viewConfig{
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.phoneNumView];
    [self.scrollView addSubview:self.verCodeView];
    [self.scrollView addSubview:self.settingLoginView];
    [self.scrollView addSubview:self.ensureLoginView];
    [self.scrollView addSubview:self.invateView];
    [self.scrollView addSubview:self.agreeBtn];
    [self.scrollView addSubview:self.treatyView];
    [self.scrollView addSubview:self.commitBtn];
    if (ScreenHeight  < self.commitBtn.bottom + ScaleW(60)) {
        self.scrollView.contentSize = CGSizeMake(0, self.commitBtn.bottom + ScaleW(60));
    }else{
        self.scrollView.contentSize = CGSizeMake(0, ScreenHeight);
    }
}
    
-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar)];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;;
}
-(LoginInputView *)phoneNumView{
    if (!_phoneNumView) {
        _phoneNumView = [[LoginInputView alloc]initWithTop:ScaleW(20) placeHolder:@"请输入绑定手机号" hasGetCode:NO];
        _phoneNumView.textFied.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _phoneNumView;
}
-(LoginInputView *)verCodeView{
    if (!_verCodeView) {
        _verCodeView = [[LoginInputView alloc]initWithTop:ScaleW(10) + _phoneNumView.bottom placeHolder:@"验证码" hasGetCode:YES];
        _verCodeView.textFied.keyboardType = UIKeyboardTypeNumberPad;
        WS(weakSelf);
        _verCodeView.getCodeBlock = ^(UIButton * _Nonnull btn) {
            [weakSelf getCodeRequst];
        };
        [self countLabel];
    }
    return _verCodeView;
}
- (UILabel *)countLabel{
    if (_countLabel == nil) {
        _countLabel = [WLTools allocLabel:nil font:kFont(15) textColor:kWhiteColor frame:CGRectZero textAlignment:NSTextAlignmentCenter];
        [self.verCodeView addSubview:_countLabel];
        [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self.verCodeView.getCodeBtn);
        }];
    }
    return _countLabel;
}
-(LoginInputView *)settingLoginView{
    if (!_settingLoginView) {
        _settingLoginView = [[LoginInputView alloc]initWithTop:ScaleW(10) + _verCodeView.bottom placeHolder:@"（6-16个字母、数字区分大小写）" hasGetCode:NO];
        _settingLoginView.textFied.secureTextEntry = YES;
    }
    return _settingLoginView;
}
-(LoginInputView *)ensureLoginView{
    if (!_ensureLoginView) {
        _ensureLoginView = [[LoginInputView alloc]initWithTop:ScaleW(10) + _settingLoginView.bottom placeHolder:@"（6-16个字母、数字区分大小写）" hasGetCode:NO];
        _ensureLoginView.textFied.secureTextEntry = YES;
    }
    return _ensureLoginView;
}
-(LoginInputView *)invateView{
    if (!_invateView) {
        _invateView = [[LoginInputView alloc]initWithTop:ScaleW(10) + _ensureLoginView.bottom placeHolder:@"邀请码（选填）" hasGetCode:NO];
    }
    return _invateView;
}-(UIButton *)agreeBtn{
    if (!_agreeBtn) {
        _agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _agreeBtn.frame = CGRectMake(ScaleW(24), ScaleW(13) + _invateView.bottom, ScaleW(25), ScaleW(25));
        [_agreeBtn setImage:[UIImage imageNamed:@"denglu_weixuan"] forState:(UIControlStateNormal)];
        [_agreeBtn setImage:[UIImage imageNamed:@"denglu_yixuan"] forState:(UIControlStateSelected)];
        [_agreeBtn addTarget:self action:@selector(agreeAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _agreeBtn;
}
-(LoginDelegateView *)treatyView{
    if (!_treatyView) {
        _treatyView = [[LoginDelegateView alloc]initWithFrame:CGRectMake(_agreeBtn.right, ScaleW(18) + _invateView.bottom, ScaleW(180), ScaleW(12))];
    }
    return _treatyView;
}
-(UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [WLTools allocButtonTitle:@"注册" font:systemBoldFont(17) textColor:kWhiteColor image:nil frame:CGRectMake(ScaleW(37), ScaleW(80) + _treatyView.bottom, ScaleW(300), ScaleW(50)) sel:@selector(commitAction:) taget:self];
        _commitBtn.backgroundColor = kBlueColor;
        [_commitBtn setCornerRadius:_commitBtn.height/2.f];
    }
    return _commitBtn;
}
-(void)commitAction:(UIButton *)sender{
    if ([self pamasIsOkOrNot]) {
        NSString *passWord = [WLTools md5:_settingLoginView.textFied.text];
        NSDictionary *pamas = @{@"phone":_phoneNumView.textFied.text,@"password":passWord,@"code":_verCodeView.textFied.text,@"invitationcode":_invateView.textFied.text?:@""};
        WS(weakSelf);
           [NetWorkTools postConJSONWithUrl:kUserRegisterActionUrl parameters:pamas success:^(id responseObject) {
               
               
               NSString *result = responseObject[@"result"];
               NSString *resultNote = responseObject[@"resultNote"];
               if ([result integerValue] == 0) {
                   [weakSelf.navigationController popViewControllerAnimated:YES];
               }
               [MBProgressHUD showError:resultNote];
              } fail:^(NSError *error) {
                  
        }];
    }
   
}
-(void)agreeAction:(UIButton *)sender{
    sender.selected=!sender.selected;
}

///获取验证码
//参数名    必选    类型    说明
//cmd    是    string    getValidateCode
//phone    是    string    手机号

-(BOOL)pamasIsOkOrNot{
   
       if (!self.phoneNumView.textFied.text.length) {
          // [SSTool error:SSKJLanguage(@"请输入您的手机号")];
           [MBProgressHUD showError:@"请输入您的手机号"];
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
           [MBProgressHUD showError:SSKJLanguage(@"请输入密码")];
           return NO;
       }
       
       if (![RegularExpression validatePassword:self.settingLoginView.textFied.text]) {
           [MBProgressHUD showError:SSKJLanguage(@"密码格式不正确")];
          return NO;
       }
       
       if (!self.ensureLoginView.textFied.text.length) {
           [MBProgressHUD showError:SSKJLanguage(@"请输入确认密码")];
           return NO;
       }
       
       if (![self.ensureLoginView.textFied.text isEqualToString:self.settingLoginView.textFied.text]) {
           [MBProgressHUD showError:SSKJLanguage(@"密码不一致")];
           return NO;
       }
       
//       if (!self.invateView.textFied.text.length) {
//           [MBProgressHUD showError:SSKJLanguage(@"请输入邀请码")];
//           return NO;
//       }
       
       if (!self.agreeBtn.isSelected) {
           [MBProgressHUD showError:SSKJLanguage(@"请同意《用户服务协议》")];
           return NO;
       }
    return YES;
}
-(void)getCodeRequst{
   if (self.timeCount >= 1) {
        return;
    }
    
    if (!self.phoneNumView.textFied.text.length) {
        [MBProgressHUD showError:SSKJLanguage(@"请输入账号")];
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
        self.countLabel.text = [NSString stringWithFormat:@"%02zdS", self.timeCount];
    }else{
        
        [self timerStop];
    }
}

- (void)timerStart{
    [self timerStop];
    self.timeCount = 61;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    [self.timer fire];
    [self.verCodeView.getCodeBtn setTitle:@"" forState:UIControlStateNormal];
    self.countLabel.hidden = NO;
}

- (void)timerStop{
    if (!self.timer) {
        return;
    }
    [self.timer invalidate];
    self.timer = nil;
    self.countLabel.text = @"";
    
    [self.verCodeView.getCodeBtn setTitle:SSKJLanguage(@"获取验证码") forState:UIControlStateNormal];
    self.countLabel.hidden = YES;

}
@end

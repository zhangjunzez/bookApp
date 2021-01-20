//
//  DSRegiserViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/12/9.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//


#import "DSRegiserViewController.h"
#import "SSKJ_H5Web_ViewController.h"
#import "DSUserDelegeViewController.h"
#import "JZLoginItemsView.h"
#import "JZDelegateView.h"

#import "RegularExpression.h"

@interface DSRegiserViewController ()
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) JZLoginItemsView *phoneView;
@property (nonatomic,strong) JZLoginItemsView *verCodeView;

@property (nonatomic,strong) JZLoginItemsView *passWordView;
@property (nonatomic,strong) JZLoginItemsView *ensurePassWordView;
@property (nonatomic,strong) JZLoginItemsView *invateCodeView;

@property (nonatomic,strong) UIButton *commitBtn;
@property (nonatomic,strong) JZDelegateView *treatyView;
@property (nonatomic,strong) UIButton *selectUserBtn;



@property (nonatomic, strong)NSTimer *timer;
@property(nonatomic)NSInteger timeCount;
@property(nonatomic, strong)UILabel *countLabel;

@end

@implementation DSRegiserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    [self.view addSubview:self.scrollView];
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight- Height_NavBar)];
        [_scrollView addSubview:self.phoneView];
        [_scrollView addSubview:self.verCodeView];
        [_scrollView addSubview:self.passWordView];
        [_scrollView addSubview:self.ensurePassWordView];
        [_scrollView addSubview:self.invateCodeView];
        [_scrollView addSubview:self.treatyView];
        [_scrollView addSubview:self.selectUserBtn];
        [_scrollView addSubview:self.commitBtn];
       
        _scrollView.contentSize = CGSizeMake(0, self.treatyView.bottom + ScaleW(100));
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}
-(JZLoginItemsView *)phoneView{
    if (!_phoneView) {
        _phoneView = [[JZLoginItemsView alloc]initWithTop:ScaleW(54) titleString:@"手机号码" placeHolder:@"请输入手机号码" hasGetCode:NO];
        _phoneView.textFied.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _phoneView;
}


-(JZLoginItemsView *)verCodeView{
    if (!_verCodeView) {
        _verCodeView = [[JZLoginItemsView alloc]initWithTop:ScaleW(10) + _phoneView.bottom titleString:@"验证码" placeHolder:@"请输入验证码" hasGetCode:YES];
        WS(weakSelf);
        _verCodeView.getCodeBlock = ^(UIButton * _Nonnull btn) {
            [weakSelf getCodeRequst];
        };
        _verCodeView.textFied.keyboardType = UIKeyboardTypeNumberPad;
        [self countLabel];
    }
    return _verCodeView;
}
- (UILabel *)countLabel{
    if (_countLabel == nil) {
        _countLabel = [WLTools allocLabel:nil font:kFont(15) textColor:kMainTxtColor frame:CGRectZero textAlignment:NSTextAlignmentCenter];
        [self.verCodeView addSubview:_countLabel];
        [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self.verCodeView.getCodeBtn);
        }];
    }
    return _countLabel;
}
-(JZLoginItemsView *)passWordView{
    if (!_passWordView) {
        _passWordView = [[JZLoginItemsView alloc]initWithTop:ScaleW(10) + _verCodeView.bottom titleString:@"登录" placeHolder:@"请输入密码" hasGetCode:NO];
        _passWordView.textFied.secureTextEntry = YES;
        _passWordView.eyeBtn.hidden = NO;
    }
    return _passWordView;
}

-(JZLoginItemsView *)ensurePassWordView{
    if (!_ensurePassWordView) {
        _ensurePassWordView = [[JZLoginItemsView alloc]initWithTop:ScaleW(10) + _passWordView.bottom titleString:@"确认密码" placeHolder:@"请确认密码" hasGetCode:NO];
        _ensurePassWordView.textFied.secureTextEntry = YES;
        _ensurePassWordView.eyeBtn.hidden = NO;
    }
    return _ensurePassWordView;
}
-(JZLoginItemsView *)invateCodeView{
    if (!_invateCodeView) {
        _invateCodeView = [[JZLoginItemsView alloc]initWithTop:ScaleW(10) + _ensurePassWordView.bottom titleString:@"邀请码(选填)" placeHolder:@"请输入邀请码" hasGetCode:NO];
        _invateCodeView.textFied.secureTextEntry = NO;
        _invateCodeView.eyeBtn.hidden = YES;
        NSString *string = _invateCodeView.titleLabel.text;
        NSMutableAttributedString *atts = [[NSMutableAttributedString alloc] initWithString:string];
        [atts setAttributes:@{ NSForegroundColorAttributeName:kGrayTxtColor,NSFontAttributeName:systemFont(ScaleW(12))} range:NSMakeRange(string.length - 4,  4)];
        _invateCodeView.titleLabel.attributedText = atts;
    }
    return _invateCodeView;
}

-(UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [WLTools allocButtonTitle:@"注册" font:systemBoldFont(17) textColor:kWhiteColor image:nil frame:CGRectMake(ScaleW(37), ScaleW(49) + _treatyView.bottom, ScaleW(300), ScaleW(44)) sel:@selector(commitAction:) taget:self];
        _commitBtn.backgroundColor = kRedColor;
         _commitBtn.layer.cornerRadius = _commitBtn.height/2.f;
    }
    return _commitBtn;
}
-(JZDelegateView *)treatyView{
    if (!_treatyView) {
        _treatyView = [[JZDelegateView alloc]initWithFrame:CGRectMake(ScaleW(55), ScaleW(32) + _invateCodeView.bottom, ScreenWidth - ScaleW(74), ScaleW(12))];
        WS(weakSelf);
        _treatyView.userDelegateBlcok = ^{
//             NSString *url = [NSString stringWithFormat:@"%@/apiService/common/protocol/2",kBaseUrlIP];
//            [weakSelf gotoWebWithUrl:url title:@"用户协议"];
            DSUserDelegeViewController *vc = [[DSUserDelegeViewController alloc]init];
            [weakSelf preasntVc:vc];
            vc.callBackBlock = ^(BOOL isselect) {
                weakSelf.selectUserBtn.selected = isselect;
            };
        };
        _treatyView.agreeLabel.text = @"我已阅读并同意";
    }
    return _treatyView;
}
-(UIButton *)selectUserBtn{
    if (!_selectUserBtn) {
        _selectUserBtn = [WLTools allocButtonTitle:@"" font:systemFont(ScaleW(0)) textColor:kWhiteColor image:[UIImage imageNamed:@"完成"] frame:CGRectMake(ScaleW(30), 0, ScaleW(20), ScaleW(20)) sel:@selector(selectUserBtnAction:) taget:self];
        [_selectUserBtn setImage:[UIImage imageNamed:@"HTSCIT_完成"] forState:(UIControlStateSelected)];
        _selectUserBtn.centerY = _treatyView.centerY;
    }
    return _selectUserBtn;
}
-(void)selectUserBtnAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
}

-(void)commitAction:(UIButton *)sender{
    if ([self pamasIsOkOrNot]) {
        NSString *passWord = [WLTools md5:_passWordView.textFied.text];
         //NSString *payPassWord = [WLTools md5:_payPassWordView.textFied.text];
        NSDictionary *pamas = @{@"mobile":_phoneView.textFied.text,@"password":passWord,@"authCode":_verCodeView.textFied.text};
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

-(void)gotoWebWithUrl:(NSString *)url title:(NSString *)title{
    ///apiService/common/protocol/2
    SSKJ_H5Web_ViewController *vc = [[SSKJ_H5Web_ViewController alloc]init];
    vc.url = url;
    vc.title = title;
    [self.navigationController pushViewController:vc animated:YES];
}
///获取验证码
//参数名    必选    类型    说明
//cmd    是    string    getValidateCode
//phone    是    string    手机号

-(BOOL)pamasIsOkOrNot{
   
       if (!self.phoneView.textFied.text.length) {
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

       
       if (!self.passWordView.textFied.text.length) {
           [MBProgressHUD showError:SSKJLanguage(@"请输入密码")];
           return NO;
       }
       
       if (![RegularExpression validatePassword:self.passWordView.textFied.text]) {
           [MBProgressHUD showError:SSKJLanguage(@"密码格式不正确")];
          return NO;
       }
    if (![self.passWordView.textFied.text isEqualToString:self.ensurePassWordView.textFied.text]) {
        [MBProgressHUD showError:SSKJLanguage(@"两次密码输入不一致")];
       return NO;
    }
       if (!self.selectUserBtn.selected) {
         [MBProgressHUD showError:SSKJLanguage(@"请同意用户协议")];
       return NO;
     }

    return YES;
}
-(void)getCodeRequst{
   if (self.timeCount >= 1) {
        return;
    }
    
    if (!self.phoneView.textFied.text.length) {
        [MBProgressHUD showError:SSKJLanguage(@"请输入账号")];
        return;
    }
    
    if (![RegularExpression validateMobile:self.phoneView.textFied.text]) {
        [MBProgressHUD showError:SSKJLanguage(@"手机号码格式错误")];
        return;
    }

    WS(weakSelf);
    NSDictionary *pama =@{@"mobile":_phoneView.textFied.text};
    [NetWorkTools postConJSONWithUrl:kGetCodeUrl parameters:pama success:^(id responseObject) {
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

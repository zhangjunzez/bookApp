//
//  LXInformationViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/11/5.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//


#import "LXInformationViewController.h"
#import "LoginInputView.h"
#import "RegularExpression.h"
#import "LoginDelegateView.h"
#import "SSKJ_H5Web_ViewController.h"
@interface LXInformationViewController ()
@property (nonatomic,strong) LoginInputView *phoneNumView;
@property (nonatomic,strong) LoginInputView *verCodeView;

@property (nonatomic,strong) UIButton *commitBtn;
@property (nonatomic,strong) UIButton *agreeBtn;
@property (nonatomic, strong)LoginDelegateView *treatyView;
@property (nonatomic, strong)NSTimer *timer;
@property(nonatomic)NSInteger timeCount;
@end

@implementation LXInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"支付密码设置";
    [self viewConfig];
}

-(void)viewConfig{
    [self.view addSubview:self.phoneNumView];
    [self.view addSubview:self.verCodeView];
  
    [self.view addSubview:self.commitBtn];
    [self.view addSubview:self.agreeBtn];
    [self.view addSubview:self.treatyView];
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

-(UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [WLTools allocButtonTitle:@"确定" font:systemBoldFont(17) textColor:kWhiteColor image:nil frame:CGRectMake(ScaleW(37), ScaleW(80) + _verCodeView.bottom, ScaleW(300), ScaleW(50)) sel:@selector(commitAction:) taget:self];
        _commitBtn.backgroundColor = kBlueColor;
        [_commitBtn setCornerRadius:_commitBtn.height/2.f];
    }
    return _commitBtn;
}
-(UIButton *)agreeBtn{
    if (!_agreeBtn) {
        _agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _agreeBtn.frame = CGRectMake(ScaleW(84), ScaleW(13) + _commitBtn.bottom, ScaleW(25), ScaleW(25));
        [_agreeBtn setImage:[UIImage imageNamed:@"denglu_weixuan"] forState:(UIControlStateNormal)];
        [_agreeBtn setImage:[UIImage imageNamed:@"denglu_yixuan"] forState:(UIControlStateSelected)];
        [_agreeBtn addTarget:self action:@selector(agreeAction:) forControlEvents:(UIControlEventTouchUpInside)];
        _agreeBtn.selected = YES;
    }
    return _agreeBtn;
}
-(void)agreeAction:(UIButton *)sender{
    sender.selected=!sender.selected;
}
-(LoginDelegateView *)treatyView{
    if (!_treatyView) {
        _treatyView = [[LoginDelegateView alloc]initWithFrame:CGRectMake(_agreeBtn.right, ScaleW(18) + _commitBtn.bottom, ScaleW(180), ScaleW(12))];
        WS(weakSelf);
        _treatyView.userDelegateBlcok = ^{
            NSString *url = [NSString stringWithFormat:@"%@%@",kBaseRequstUrl,@"/display/agreement?id=5"];
            [weakSelf gotoWebWithUrl:url title:@"用户协议"];
        };
        _treatyView.securatyBlcok = ^{
            NSString *url = [NSString stringWithFormat:@"%@%@",kBaseRequstUrl,@"/display/agreement?id=6"];
            [weakSelf gotoWebWithUrl:url title:@"隐私政策"];
        };
    }
    return _treatyView;
}
-(void)gotoWebWithUrl:(NSString *)url title:(NSString *)title{
    SSKJ_H5Web_ViewController *vc = [[SSKJ_H5Web_ViewController alloc]init];
    vc.url = url;
    vc.title = title;
    [self.navigationController pushViewController:vc animated:YES];
}
//参数名    必选    类型    说明
//cmd    是    string    engineerforgetPwd
//phone    是    string    手机号
//password    是    string    新密码
//code    是    string    验证码
-(void)commitAction:(UIButton *)sender{
    if ([self pamasIsOkOrNot]) {
       
        NSDictionary *pamas = @{@"phone":_phoneNumView.textFied.text,@"code":_verCodeView.textFied.text};
        WS(weakSelf);
        [self.pamaDic setValuesForKeysWithDictionary:pamas];
           [NetWorkTools postConJSONWithUrl:@"engineerthreeLogin" parameters:self.pamaDic success:^(id responseObject) {
               
               NSString *result = responseObject[@"result"];
               NSString *resultNote = responseObject[@"resultNote"];
               NSString *uid = responseObject[@"uid"];
               NSString *isnewuser = responseObject[@"isnewuser"];
               if ([result integerValue] == 0) {
                   if (isnewuser.integerValue == 0) {
                      // [weakSelf requstBindPhoneWith:ifor withType:type];
                       LXInformationViewController *vc = [[LXInformationViewController alloc]init];
                       vc.pamaDic = [NSMutableDictionary dictionaryWithDictionary:pamas];
                       [self.navigationController pushViewController:vc animated:YES];
                   }else{
                       if (uid.length)
                       {
                           [kUserDefaults setObject:uid forKey:@"uid"];
                       }
                       [weakSelf backToHomeAction];
                   }
               }else{
                
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

//
//  LXLoginViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/22.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXLoginViewController.h"
#import "LoginUserView.h"
#import "thirdLoginItem.h"
#import "LoginDelegateView.h"
#import "LXFindBackViewController.h"
#import "LXRegesterViewController.h"
#import "SSKJ_H5Web_ViewController.h"
#import "LXInformationViewController.h"

#import "RegularExpression.h"
#import <UMShare/UMShare.h>
#import <AuthenticationServices/AuthenticationServices.h>

@interface LXLoginViewController ()<ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding>
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIButton *closeBtn;
@property (nonatomic,strong) UIButton *arrountBtn;
@property (nonatomic,strong) UIImageView *headImgView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIButton *msgBtn;
@property (nonatomic,strong) UIButton *pswBtn;

@property (nonatomic,strong) LoginUserView *phoneAccountView;
@property (nonatomic,strong) LoginUserView *verCodeView;
@property (nonatomic,strong) LoginUserView *passWordView;
@property (nonatomic,strong) UIButton *regiserBtn;
@property (nonatomic,strong) UIButton *forgetBtn;
@property (nonatomic,strong) UIButton *commitBtn;
@property (nonatomic,strong) UIButton *agreeBtn;
@property (nonatomic, strong)LoginDelegateView *treatyView;

@property (nonatomic,strong) UILabel *thirdLoginLabel;
@property (nonatomic,strong) thirdLoginItem *QQView;
@property (nonatomic,strong) thirdLoginItem *weChatView;
@property (nonatomic,strong) thirdLoginItem *appleView;

@property (nonatomic, strong)NSTimer *timer;
@property(nonatomic)NSInteger timeCount;



@end

@implementation LXLoginViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self viewConfig];
}
#pragma mark --viewConfig
-(void)viewConfig{
    [self.view addSubview:self.scrollView];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
   
    
}
-(UIButton *)closeBtn
{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.frame = CGRectMake(ScaleW(20), ScaleW(15) +Height_StatusBar, ScaleW(20), ScaleW(20));
        [_closeBtn btn:_closeBtn font:ScaleW(0) textColor:kWhiteColor text:@"" image:[UIImage imageNamed:@"denglu_guanbi"] sel:@selector(closeBtnAction:) taget:self];
    }
    return _closeBtn;
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        [_scrollView addSubview:self.closeBtn];
        [_scrollView addSubview:self.arrountBtn];
        [_scrollView addSubview:self.headImgView];
        [_scrollView addSubview:self.nameLabel];
        [_scrollView addSubview:self.msgBtn];
        [_scrollView addSubview:self.pswBtn];
        [_scrollView addSubview:self.phoneAccountView];
        [_scrollView addSubview:self.passWordView];
        [_scrollView addSubview:self.verCodeView];
        [_scrollView addSubview:self.regiserBtn];
        [_scrollView addSubview:self.forgetBtn];
        [_scrollView addSubview:self.commitBtn];
        [_scrollView addSubview:self.agreeBtn];
        [_scrollView addSubview:self.treatyView];
        [_scrollView addSubview:self.thirdLoginLabel];
        [_scrollView addSubview:self.QQView];
        [_scrollView addSubview:self.weChatView];
        [_scrollView addSubview:self.appleView];
        _scrollView.contentSize = CGSizeMake(0, self.appleView.bottom + ScaleW(60));
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}
-(UIButton *)arrountBtn{
    if (!_arrountBtn) {
        _arrountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _arrountBtn.frame = CGRectMake(ScreenWidth - ScaleW(85), _closeBtn.bottom + ScaleW(7), ScaleW(70), ScaleW(30));
        [_arrountBtn setCornerRadius:_arrountBtn.height/2.f];
        _arrountBtn.backgroundColor = kBlueBacColor;
        [_arrountBtn btn:_arrountBtn font:ScaleW(12) textColor:kBlueColor text:@"逛-逛" image:nil sel:@selector(arrountBtnAction) taget:self];
    }
    return _arrountBtn;
}
-(UIImageView *)headImgView
{
    if (!_headImgView) {
        _headImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, ScaleW(7) + _arrountBtn.bottom, ScaleW(105), ScaleW(105))];
        [_headImgView setCornerRadius:ScaleW(12)];
        _headImgView.image = [UIImage imageNamed:@"littleLogo"];
        _headImgView.centerX = ScreenWidth/2.f;
        
    }
    return _headImgView;
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [WLTools allocLabel:@"LOGO" font:systemFont(ScaleW(21)) textColor:kBlueColor frame:CGRectMake(0, ScaleW(19) + _headImgView.bottom, ScreenWidth, ScaleW(21)) textAlignment:(NSTextAlignmentCenter)];
        _nameLabel.hidden = YES;
    }
    return _nameLabel;
}
-(UIButton *)msgBtn{
    if (!_msgBtn) {
        _msgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _msgBtn.frame = CGRectMake(ScaleW(60), _nameLabel.bottom + ScaleW(50), ScaleW(112), ScaleW(40));
        [_msgBtn btn:_msgBtn font:ScaleW(20) textColor:kBlueColor text:@"短信登录" image:nil sel:@selector(changeIndexBtn:) taget:self];
        _msgBtn.titleLabel.font = systemBoldFont(ScaleW(20));
    }
    return _msgBtn;
}
-(UIButton *)pswBtn{
    if (!_pswBtn) {
        _pswBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _pswBtn.frame = CGRectMake(ScreenWidth-ScaleW(60)-ScaleW(112), _nameLabel.bottom + ScaleW(50), ScaleW(112), ScaleW(40));
        [_pswBtn btn:_pswBtn font:ScaleW(16) textColor:kMainTxtColor text:@"密码登录" image:nil sel:@selector(changeIndexBtn:) taget:self];
        _pswBtn.titleLabel.font = systemBoldFont(ScaleW(16));
    }
    return _pswBtn;
}
-(LoginUserView *)phoneAccountView{
    if (!_phoneAccountView) {
        _phoneAccountView = [[LoginUserView alloc]initWithTop:ScaleW(16) + _msgBtn.bottom headerImg:[UIImage imageNamed:@"denglu_shoujihao"] placeHolder:@"请输入手机号" hasGetCode:NO];
         _phoneAccountView.textFied.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _phoneAccountView;
}
-(LoginUserView *)passWordView{
    if (!_passWordView) {
        _passWordView = [[LoginUserView alloc]initWithTop:ScaleW(17) + _phoneAccountView.bottom headerImg:[UIImage imageNamed:@"denglu_mima"] placeHolder:@"（6-16个字母、数字区分大小写）" hasGetCode:NO];
        _passWordView.hidden = YES;
        _passWordView.textFied.secureTextEntry = YES;
    }
    return _passWordView;
}
-(LoginUserView *)verCodeView{
    if (!_verCodeView) {
        _verCodeView = [[LoginUserView alloc]initWithTop:ScaleW(17) + _phoneAccountView.bottom headerImg:nil placeHolder:@"请输入验证码" hasGetCode:YES];
        _verCodeView.hidden = NO;
        _verCodeView.textFied.keyboardType = UIKeyboardTypeNumberPad;
        WS(weakSelf);
        _verCodeView.getCodeBlock = ^(UIButton * _Nonnull btn) {
            [weakSelf getCodeRequst];
        };
    }
    return _verCodeView;
}
-(UIButton *)regiserBtn{
    if (!_regiserBtn) {
        _regiserBtn = [WLTools allocButtonTitle:@"注册" font:systemFont(14) textColor:kBlueColor image:nil frame:CGRectMake(ScaleW(8), ScaleW(15) + _passWordView.bottom, ScaleW(130), ScaleW(15)) sel:@selector(regsiterAction:) taget:self];
        _regiserBtn.hidden = YES;
    }
    return _regiserBtn;
}
-(UIButton *)forgetBtn{
    if (!_forgetBtn) {
        _forgetBtn = [WLTools allocButtonTitle:@"忘记密码" font:systemFont(14) textColor:kBlueColor image:nil frame:CGRectMake(ScreenWidth-ScaleW(32)-ScaleW(130), ScaleW(15) + _passWordView.bottom, ScaleW(130), ScaleW(15)) sel:@selector(forgetAction:) taget:self];
       _forgetBtn.hidden = YES;
    }
    return _forgetBtn;
}
-(UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [WLTools allocButtonTitle:@"登录" font:systemBoldFont(17) textColor:kWhiteColor image:nil frame:CGRectMake(ScaleW(37), ScaleW(45) + _verCodeView.bottom, ScaleW(300), ScaleW(50)) sel:@selector(commitAction:) taget:self];
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
-(UILabel *)thirdLoginLabel{
    if (!_thirdLoginLabel) {
        _thirdLoginLabel = [WLTools allocLabel:@"三方登录" font:systemFont(14) textColor:kMainTxtColor frame:CGRectMake(0, ScaleW(60) + _treatyView.bottom,ScreenWidth, ScaleW(14)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _thirdLoginLabel;
}

-(thirdLoginItem *)QQView{
    if (!_QQView) {
        _QQView = [[thirdLoginItem alloc]initWithImge:[UIImage imageNamed:@"denglu_qq"] message:@"QQ"];
        _QQView.left = ScaleW(22);
        _QQView.top = ScaleW(25) + _thirdLoginLabel.bottom;
        WS(weakSelf);
        _QQView.itemClickBlock = ^{
            [weakSelf gotoQQAction];
        };
    }
    return _QQView;
}
-(thirdLoginItem *)weChatView{
    if (!_weChatView) {
        _weChatView = [[thirdLoginItem alloc]initWithImge:[UIImage imageNamed:@"denglu_weixin"] message:@"微信"];
        _weChatView.centerX = ScreenWidth/2.f;;
        _weChatView.top = _QQView.top;
        WS(weakSelf);
        _weChatView.itemClickBlock = ^{
            [weakSelf gotoWechatAction];
        };
    }
    return _weChatView;
}
-(thirdLoginItem *)appleView{
    if (!_appleView) {
        _appleView = [[thirdLoginItem alloc]initWithImge:[UIImage imageNamed:@"denglu_iphone"] message:@"Apple"];
        _appleView.right = ScreenWidth- ScaleW(22);
        _appleView.top = _QQView.top;
        WS(weakSelf);
        _appleView.itemClickBlock = ^{
            [weakSelf gotoAppleAction];
        };
        
        
    }
    return _appleView;
}
#pragma mark --setter&&getter
-(void)setLoginType:(LoginType)loginType
{
    _loginType = loginType;
    
    if (_loginType == LoginTypeMessage) {
        ///短信登录
        [self.msgBtn setTitleColor:kBlueColor forState:(UIControlStateNormal)];
        self.msgBtn.titleLabel.font = systemBoldFont(21);
        [self.pswBtn setTitleColor:kMainTxtColor forState:(UIControlStateNormal)];
        self.pswBtn.titleLabel.font = systemBoldFont(16);
        self.verCodeView.hidden = NO;
        self.passWordView.hidden = YES;
        self.regiserBtn.hidden = YES;
        self.forgetBtn.hidden = YES;
        self.commitBtn.top = ScaleW(46) + _passWordView.bottom;
        [self reloadFrame];
        
    }
    if (_loginType == LoginTypePassWord) {
           ///密码登录
        [self.pswBtn setTitleColor:kBlueColor forState:(UIControlStateNormal)];
        self.pswBtn.titleLabel.font = systemBoldFont(21);
        [self.msgBtn setTitleColor:kMainTxtColor forState:(UIControlStateNormal)];
        self.msgBtn.titleLabel.font = systemBoldFont(16);
           self.verCodeView.hidden = YES;
           self.passWordView.hidden = NO;
           self.regiserBtn.hidden = NO;
           self.forgetBtn.hidden = NO;
           self.commitBtn.top = ScaleW(66) + _passWordView.bottom;
           [self reloadFrame];
       }
}
-(void)reloadFrame{
    self.agreeBtn.top = ScaleW(13) + _commitBtn.bottom;
    self.treatyView.top = ScaleW(18) + _commitBtn.bottom;
    self.thirdLoginLabel.top = ScaleW(60) + _treatyView.bottom;
    self.QQView.top = ScaleW(25) + _thirdLoginLabel.bottom;
    self.weChatView.top = self.QQView.top;
    self.appleView.top = self.QQView.top;
    self.scrollView.contentSize = CGSizeMake(0, self.appleView.bottom + ScaleW(60));
}
#pragma mark --Action

-(void)closeBtnAction:(UIButton *)sender
{
    [self dissMissAction];
}

-(void)arrountBtnAction{
    [self dissMissAction];
}
-(void)changeIndexBtn:(UIButton *)sender{
    if (sender == self.msgBtn) {
        ///短信登录
        self.loginType = LoginTypeMessage;
    }
    if (sender == self.pswBtn) {
        ///密码登录
        self.loginType = LoginTypePassWord;
    }
}
-(void)regsiterAction:(UIButton *)sender{
    LXRegesterViewController *vc = [[LXRegesterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)forgetAction:(UIButton *)sender{
    LXFindBackViewController *vc = [[LXFindBackViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
//参数名    必选    类型    说明
//cmd    是    string    engineerphoneLogin
//phone    是    string    手机号
//code    是    string    验证码
//token    是    string    极光token
-(void)commitAction:(UIButton *)sender{
    if ([self pamasIsOkOrNot]) {
        NSString *passWord = [WLTools md5:_passWordView.textFied.text];
        NSDictionary *pamas = @{@"phone":_phoneAccountView.textFied.text,@"password":passWord,@"code":_verCodeView.textFied.text};
        NSString *urlString = kUserMessageLoginUrl;
        if (self.loginType == LoginTypeMessage) {
            urlString = kUserMessageLoginUrl;
            pamas = @{@"phone":_phoneAccountView.textFied.text,@"code":_verCodeView.textFied.text};
        }
        if (self.loginType == LoginTypePassWord) {
            urlString = kUserPassWordLoginUrl;
            pamas = @{@"phone":_phoneAccountView.textFied.text,@"password":passWord};
        }
        WS(weakSelf);
           [NetWorkTools postConJSONWithUrl:urlString parameters:pamas success:^(id responseObject) {
               
               NSString *result = responseObject[@"result"];
               NSString *resultNote = responseObject[@"resultNote"];
               NSString *uid = responseObject[@"uid"];
               if ([result integerValue] == 0) {
                   //[weakSelf.navigationController popViewControllerAnimated:YES];
                   [kUserDefaults setObject:uid forKey:@"uid"];
                   [weakSelf dissMissAction];
               }
               [MBProgressHUD showError:resultNote];
              } fail:^(NSError *error) {
                  
        }];
    }
   
}

-(BOOL)pamasIsOkOrNot{
   
       if (!self.phoneAccountView.textFied.text.length) {
          // [SSTool error:SSKJLanguage(@"请输入您的手机号")];
           [MBProgressHUD showError:@"请输入您的手机号"];
           return NO;
       }
    if (![RegularExpression validateMobile:self.phoneAccountView.textFied.text]) {
          [MBProgressHUD showError:SSKJLanguage(@"手机号码格式错误")];
          return NO;
      }
    if (self.loginType == LoginTypeMessage) {
        if (!self.verCodeView.textFied.text.length) {
                  [MBProgressHUD showError:SSKJLanguage(@"请输入验证码")];
                 return NO;
              }
              
              if (![RegularExpression deptNumInputShouldNumber:self.verCodeView.textFied.text]) {
                  [MBProgressHUD showError:SSKJLanguage(@"验证码格式不正确")];
                  return NO;
              }
    }
      
    if (self.loginType == LoginTypePassWord) {
        if (!self.passWordView.textFied.text.length) {
            [MBProgressHUD showError:SSKJLanguage(@"请输入密码")];
            return NO;
        }
        
        if (![RegularExpression validatePassword:self.passWordView.textFied.text]) {
            [MBProgressHUD showError:SSKJLanguage(@"密码格式不正确")];
           return NO;
        }
        
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
    
    if (!self.phoneAccountView.textFied.text.length) {
        [MBProgressHUD showError:SSKJLanguage(@"请输入账号")];
        return;
    }
    
    if (![RegularExpression validateMobile:self.phoneAccountView.textFied.text]) {
        [MBProgressHUD showError:SSKJLanguage(@"手机号码格式错误")];
        return;
    }
    

    WS(weakSelf);
    [NetWorkTools postConJSONWithUrl:kGetCodeUrl parameters:@{@"phone":_phoneAccountView.textFied.text} success:^(id responseObject) {
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
    [self.timer invalidate];
    self.timer = nil;
    //self.countLabel.text = @"";
    
    [self.verCodeView.getCodeBtn setTitle:SSKJLanguage(@"获取验证码") forState:UIControlStateNormal];

}
-(void)agreeAction:(UIButton *)sender{
    sender.selected=!sender.selected;
}

-(void)gotoQQAction{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:self completion:^(id result, NSError *error) {
        NSLog(@"result ===== %@",result);
        if (error) {
            NSLog(@"<-- %s, %d -->  %@", __FUNCTION__, __LINE__, error);
            if (error.code == 2008) {
               // [QMUITips showError:@"应用未安装!" inView:self.view hideAfterDelay:2.0];
            }else{
                //[QMUITips showError:@"授权失败!" inView:self.view hideAfterDelay:2.0];
            }
        }else{
            [self requstBindPhoneWith:result withType:@"1"];
        }
    }];
}
-(void)gotoWechatAction{
    NSLog(@"result ===== ");
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:self completion:^(id result, NSError *error) {
        NSLog(@"result ===== %@",result);
        if (error) {
            NSLog(@"<-- %s, %d -->  %@", __FUNCTION__, __LINE__, error);
            if (error.code == 2008) {
               // [QMUITips showError:@"应用未安装!" inView:self.view hideAfterDelay:2.0];
            }else{
                //[QMUITips showError:@"授权失败!" inView:self.view hideAfterDelay:2.0];
            }
        }else{
            [self requstBindPhoneWith:result withType:@"0"];
        }
    }];
}
-(void)gotoAppleAction{
    if (@available(iOS 13.0, *)) {
        ASAuthorizationAppleIDProvider *appleIDProvider = [[ASAuthorizationAppleIDProvider alloc] init];
        // 通过 provider 创建一个 request
        ASAuthorizationAppleIDRequest *appleIDRequest = [appleIDProvider createRequest];
        // 要获取的内容
        appleIDRequest.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
        // 系统提供的 Controller，必须使用，需要传入 requests 数组
        ASAuthorizationController *authController = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[appleIDRequest/*, passwordRequest*/]];
        // 设置代理，接收登录成功/失败的回调
        authController.delegate = self;
        // 页面跳转相关的，通过一个代理方法传入一个 window
        authController.presentationContextProvider = self;

        [authController performRequests];
    }
}
-(void)requstBindPhoneWith:(id)result withType:(NSString *)type{
    UMSocialUserInfoResponse *ifor = result;
    
    NSDictionary *pamas = @{@"thirdid":ifor.openid
                            ,@"type":type
                            ,@"nickname":ifor.name
                            ,@"icon":ifor.iconurl
    };
    if ([type isEqualToString:@"2"]) {
        pamas = result;
    }
    NSString *urlString = @"engineerthreeLogin";
    WS(weakSelf);
    [NetWorkTools postConJSONWithUrl:urlString parameters:pamas success:^(id responseObject) {

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
        
        NSLog(@"error ===== %@",error);
        
    }];
}
///代理主要用于展示在哪里
-(ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller API_AVAILABLE(ios(13.0)){
return self.view.window;
}


-(void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization API_AVAILABLE(ios(13.0)){
    if([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]){
        ASAuthorizationAppleIDCredential *appleIDCredential = authorization.credential;
                NSString *user = appleIDCredential.user;
               
      NSDictionary *pama =  @{@"thirdid":[NSString stringWithFormat:@"app-%@",user],
                                         @"type":@"2",
                                         @"icon":@"",
                                         @"nickname":@""};
        [self requstBindPhoneWith:pama withType:@"2"];
        
    }
}
@end

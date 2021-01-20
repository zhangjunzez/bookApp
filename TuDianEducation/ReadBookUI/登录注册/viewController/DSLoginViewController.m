//
//  DSLoginViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/12/9.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "DSLoginViewController.h"
#import "DSRegiserViewController.h"
#import "DSResetPassWordViewController.h"
#import "DSUserDelegeViewController.h"

#import "RegesiterItemView.h"
#import "LoginInputView.h"
#import "thirdLoginItem.h"
#import "RegularExpression.h"
#import "JZDelegateView.h"
///腾讯云
#import "TUIKit.h"

@interface DSLoginViewController ()
@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) UIImageView *headImgView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) RegesiterItemView* accountView;
@property (nonatomic,strong) LoginInputView *passWordView;
@property (nonatomic,strong) UIButton *forgetBtn;
@property (nonatomic,strong) UIButton *commitBtn;
@property (nonatomic,strong) UIButton *regesterBtn;
@property (nonatomic,strong) UILabel *thirdLoginLabel;

@property (nonatomic,strong) thirdLoginItem *weChatView;
@property (nonatomic,strong) thirdLoginItem *qqView;
@property (nonatomic,strong) JZDelegateView *treatyView;
@property (nonatomic,strong) UIButton *selectUserBtn;


@end

@implementation DSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.closeBtn];
}

-(UIButton *)closeBtn
{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.frame = CGRectMake(ScaleW(20), ScaleW(15) +Height_StatusBar, ScaleW(20), ScaleW(20));
        [_closeBtn btn:_closeBtn font:ScaleW(0) textColor:kWhiteColor text:@"" image:[UIImage imageNamed:@"关闭_d"] sel:@selector(closeBtnAction:) taget:self];
    }
    return _closeBtn;
}
#pragma mark --dissMiss

-(void)closeBtnAction:(UIButton *)sender
{
    [self dissMissAction];
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];

        [_scrollView addSubview:self.headImgView];
        [_scrollView addSubview:self.nameLabel];
        [_scrollView addSubview:self.accountView];
        [_scrollView addSubview:self.passWordView];
        [_scrollView addSubview:self.forgetBtn];
        [_scrollView addSubview:self.regesterBtn];
        [_scrollView addSubview:self.commitBtn];
        [_scrollView addSubview:self.treatyView];
        [_scrollView addSubview:self.selectUserBtn];
        [_scrollView addSubview:self.thirdLoginLabel];
        [_scrollView addSubview:self.weChatView];
        [_scrollView addSubview:self.qqView];
        _scrollView.contentSize = CGSizeMake(0, self.weChatView.bottom + ScaleW(60));
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        
    }
    return _scrollView;
}

-(UIImageView *)headImgView
{
    if (!_headImgView) {
        _headImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, ScaleW(64), ScaleW(105), ScaleW(105))];
        _headImgView.image = [UIImage imageNamed:@"logo"];
        _headImgView.centerX = ScreenWidth/2.f;
        //_headImgView.backgroundColor = kBlueColor;
        
    }
    return _headImgView;
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [WLTools allocLabel:@"戴胜鸟图书" font:systemFont(ScaleW(21)) textColor:kMainTxtColor frame:CGRectMake(0, ScaleW(19) + _headImgView.bottom, ScreenWidth, ScaleW(21)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _nameLabel;
}
-(RegesiterItemView *)accountView{
    if (!_accountView) {
        _accountView = [[RegesiterItemView alloc]initWithTop:_nameLabel.bottom + ScaleW(60) isPhoneAccount:YES placeHolder:@"请输入手机号" red:NO];
        _accountView.inputTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _accountView;
}

-(LoginInputView *)passWordView{
    if (!_passWordView) {
        _passWordView = [[LoginInputView alloc]initWithTop:ScaleW(10) + _accountView.bottom placeHolder:@"请输入密码" hasGetCode:NO];
        _passWordView.textFied.secureTextEntry = YES;
        _passWordView.lookPswBtn.hidden = NO;
    }
    return _passWordView;
}
-(UIButton *)forgetBtn
{
    if (!_forgetBtn) {
        _forgetBtn = [WLTools allocButtonTitle:@"忘记密码？" font:systemFont(ScaleW(13)) textColor:kMainTxtColor image:nil frame:CGRectMake(ScaleW(25), ScaleW(20) + _passWordView.bottom, ScaleW(80), ScaleW(30)) sel:@selector(forgetBtnAction:) taget:self];
        _forgetBtn.right = self.scrollView.width - ScaleW(25);
    }
    return _forgetBtn;
}
#pragma mark ---忘记密码
-(void)forgetBtnAction:(UIButton *)sender
{
    DSResetPassWordViewController *vc = [[DSResetPassWordViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [WLTools allocButtonTitle:@"登录" font:systemBoldFont(17) textColor:kWhiteColor image:nil frame:CGRectMake(ScaleW(37), ScaleW(25) + _forgetBtn.bottom, ScaleW(300), ScaleW(40)) sel:@selector(commitAction:) taget:self];
        _commitBtn.backgroundColor = kGreenColor;
        [_commitBtn setCornerRadius:_commitBtn.height/2.f];
    }
    return _commitBtn;
}
-(JZDelegateView *)treatyView{
    if (!_treatyView) {
        _treatyView = [[JZDelegateView alloc]initWithFrame:CGRectMake(ScaleW(55), ScaleW(32) + _commitBtn.bottom, ScreenWidth - ScaleW(74), ScaleW(12))];
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
        _selectUserBtn = [WLTools allocButtonTitle:@"" font:systemFont(ScaleW(0)) textColor:kWhiteColor image:[UIImage imageNamed:@"完成"] frame:CGRectMake(ScaleW(34), 0, ScaleW(20), ScaleW(20)) sel:@selector(selectUserBtnAction:) taget:self];
        [_selectUserBtn setImage:[UIImage imageNamed:@"HTSCIT_完成"] forState:(UIControlStateSelected)];
        _selectUserBtn.centerY = _treatyView.centerY;
    }
    return _selectUserBtn;
}
-(void)selectUserBtnAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
}
#pragma mark --登录
-(void)commitAction:(UIButton *)sender
{
    if ([self pamasIsOkOrNot]) {
        NSString *passWord = [WLTools md5:_passWordView.textFied.text];
         //NSString *payPassWord = [WLTools md5:_payPassWordView.textFied.text];
        NSDictionary *pamas = @{@"type":@"1",@"mobile":_accountView.inputTextFiled.text,@"password":passWord,@"rid":@""};
        WS(weakSelf);
           [NetWorkTools postConJSONWithUrl:kUserPassWordLoginUrl parameters:pamas success:^(id responseObject) {
               NSString *result = responseObject[@"result"];
               NSString *mid = responseObject[@"mid"];
               NSString *nickname = responseObject[@"nickname"];
               NSString *avatar = responseObject[@"avatar"];
               NSString *resultNote = responseObject[@"resultNote"];
               if (result.intValue == 0) {
                   [kUserDefaults setObject:mid forKey:@"mid"];
                   [weakSelf dissMissAction];
                   [weakSelf requstTencentUserSignWithMid:mid nickName:nickname?:@"" icon:avatar?:@""];
               }else{
                   [MBProgressHUD showError:resultNote];
               }
             
              } fail:^(NSError *error) {
                  
        }];
    }
}
#pragma mark -----获取userSign
-(void)requstTencentUserSignWithMid:(NSString *)mid nickName:(NSString *)nickName icon:(NSString *)icon
{
    
    NSDictionary *pamas = @{@"mid":mid};
    WS(weakSelf);
       [NetWorkTools postConJSONWithUrl:@"getUserSig" parameters:pamas success:^(id responseObject) {
           
           
           NSString *result = responseObject[@"result"];
           NSString *userSig = responseObject[@"userSig"];
           NSString *resultNote = responseObject[@"resultNote"];
           if (result.intValue == 0) {
               [kUserDefaults setObject:userSig forKey:@"VideoTengcentAccountToken"];
               [kUserDefaults setObject:mid forKey:@"VideoTengcentAccount"];
               [self exchangeTencentNickName:nickName icon:icon];
           }else{
               [MBProgressHUD showError:resultNote];
           }
          
          } fail:^(NSError *error) {
              
    }];
}
-(void)exchangeTencentNickName:(NSString *)nickName icon:(NSString *)icon
{
    WS(weakSelf);
//    if ([[V2TIMManager sharedInstance] getLoginStatus] == V2TIM_STATUS_LOGOUT) {
  
    NSString *account =tencentAccount;
    NSString *token =tencentToken;
   
        
            if ([V2TIMManager sharedInstance].getLoginStatus == TIM_STATUS_LOGINED) {
                [[V2TIMManager sharedInstance]logout:^{
                    [[V2TIMManager sharedInstance] login:account userSig:token succ:^{
                        [self exchangeNiackNameNickName:nickName icon:icon?:@""];
                        } fail:^(int code, NSString *desc) {
                            
                        }];
                        } fail:^(int code, NSString *desc) {
    
                        }];
            }else{
                [[V2TIMManager sharedInstance] login:account userSig:token succ:^{
                    [self exchangeNiackNameNickName:nickName icon:icon?:@""];
                    } fail:^(int code, NSString *desc) {
                        
                    }];
    
            }
        
        
//    }else{
//        [weakSelf exchangeNiackNameNickName:nickName icon:icon];
//    }
}

-(void)exchangeNiackNameNickName:(NSString *)nickName icon:(NSString *)icon{
    
            
    [[TIMFriendshipManager sharedInstance] modifySelfProfile:@{TIMProfileTypeKey_Nick: nickName}
                                                        succ:nil fail:nil];
    
    [[TIMFriendshipManager sharedInstance] modifySelfProfile:@{TIMProfileTypeKey_FaceUrl:icon}
                                                        succ:^{
        
        NSLog(@"上传成功");
        
    } fail:^(int code, NSString *msg) {
        
        NSLog(@"上传失败");
    }];
                
}


-(BOOL)pamasIsOkOrNot{
   
       if (!self.accountView.inputTextFiled.text.length) {
          // [SSTool error:SSKJLanguage(@"请输入您的手机号")];
           [MBProgressHUD showError:@"请输入您的手机号"];
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
      
    if (!self.selectUserBtn.selected) {
      [MBProgressHUD showError:SSKJLanguage(@"请同意用户协议")];
    return NO;
  }
    return YES;
}
-(UIButton *)regesterBtn{
    if (!_regesterBtn) {
        _regesterBtn = [WLTools allocButtonTitle:@"立即注册" font:systemFont(13) textColor:kGreenColor image:nil frame:CGRectMake(ScaleW(25), _forgetBtn.top, ScaleW(80), ScaleW(30)) sel:@selector(regesterBtnAction:) taget:self];
       
        
    }
    return _regesterBtn;
}
#pragma mark ---注册
-(void)regesterBtnAction:(UIButton *)sender
{
    DSRegiserViewController *vc = [[DSRegiserViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(UILabel *)thirdLoginLabel{
    if (!_thirdLoginLabel) {
        _thirdLoginLabel = [WLTools allocLabel:@"选择登录方式" font:systemFont(ScaleW(13)) textColor:kGrayTxtColor frame:CGRectMake(0, ScaleW(60) + _treatyView.bottom, ScreenWidth, ScaleW(13)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _thirdLoginLabel;
}
-(thirdLoginItem *)weChatView{
    if (!_weChatView) {
        _weChatView = [[thirdLoginItem alloc]initWithImge:[UIImage imageNamed:@"weixin"] message:@""];
        _weChatView.left = ScaleW(115);
        _weChatView.top = ScaleW(25) + _thirdLoginLabel.bottom;
        WS(weakSelf);
        _weChatView.itemClickBlock = ^{
            //[weakSelf gotoWechatAction];
        };
    }
    return _weChatView;
}
-(thirdLoginItem *)qqView{
    if (!_qqView) {
        _qqView = [[thirdLoginItem alloc]initWithImge:[UIImage imageNamed:@"QQ"] message:@""];
        _qqView.left = _weChatView.right + ScaleW(48);
        _qqView.top = ScaleW(25) + _thirdLoginLabel.bottom;
        WS(weakSelf);
        _qqView.itemClickBlock = ^{
            //[weakSelf gotoWechatAction];
        };
    }
    return _qqView;
}
@end

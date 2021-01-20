//
//  LXResetPswViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/24.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//


#import "LXResetPswViewController.h"
#import "LoginInputView.h"

#import "RegularExpression.h"
@interface LXResetPswViewController ()
@property (nonatomic,strong) LoginInputView *oldPasswordView;
@property (nonatomic,strong) LoginInputView *settingLoginView;
@property (nonatomic,strong) LoginInputView *ensureLoginView;
@property (nonatomic,strong) UIButton *commitBtn;
@end

@implementation LXResetPswViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"重置登录密码";
    [self viewConfig];
}

-(void)viewConfig{
    [self.view addSubview:self.oldPasswordView];
    [self.view addSubview:self.settingLoginView];
    [self.view addSubview:self.ensureLoginView];
    [self.view addSubview:self.commitBtn];
}
-(LoginInputView *)oldPasswordView{
    if (!_oldPasswordView) {
        _oldPasswordView = [[LoginInputView alloc]initWithTop:ScaleW(20) placeHolder:@"请输入原密码（6-16个字母数字，区分大小写）" hasGetCode:NO];
        _oldPasswordView.textFied.secureTextEntry = YES;
        _oldPasswordView.lookPswBtn.hidden = NO;
    }
    return _oldPasswordView;
}

-(LoginInputView *)settingLoginView{
    if (!_settingLoginView) {
        _settingLoginView = [[LoginInputView alloc]initWithTop:ScaleW(10) + _oldPasswordView.bottom placeHolder:@"设置新密码（6-16个字母数字，区分大小写）" hasGetCode:NO];
        _settingLoginView.textFied.secureTextEntry = YES;
        _settingLoginView.lookPswBtn.hidden = NO;
    }
    return _settingLoginView;
}
-(LoginInputView *)ensureLoginView{
    if (!_ensureLoginView) {
        _ensureLoginView = [[LoginInputView alloc]initWithTop:ScaleW(10) + _settingLoginView.bottom placeHolder:@"确认新密码（6-16个字母数字，区分大小写）" hasGetCode:NO];
        _ensureLoginView.textFied.secureTextEntry = YES;
        _ensureLoginView.lookPswBtn.hidden = NO;
    }
    return _ensureLoginView;
}
-(UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [WLTools allocButtonTitle:@"确认" font:systemBoldFont(17) textColor:kWhiteColor image:nil frame:CGRectMake(ScaleW(37), ScaleW(80) + _ensureLoginView.bottom, ScaleW(300), ScaleW(50)) sel:@selector(commitAction:) taget:self];
        _commitBtn.backgroundColor = kBlueColor;
        [_commitBtn setCornerRadius:_commitBtn.height/2.f];
    }
    return _commitBtn;
}
-(void)commitAction:(UIButton *)sender{
     NSString *oldPassWord = [WLTools md5:_oldPasswordView.textFied.text];
    NSString *passWord = [WLTools md5:_settingLoginView.textFied.text];
    if ([self pamasIsOkOrNot]) {
        NSDictionary *pamas = @{@"oldpassword":oldPassWord,@"password":passWord};
        WS(weakSelf);
           [NetWorkTools postConJSONWithUrl:kUserEngineerupdatePasswordUrl parameters:pamas success:^(id responseObject) {
               
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

-(BOOL)pamasIsOkOrNot{
   
       if (!self.oldPasswordView.textFied.text.length) {
          // [SSTool error:SSKJLanguage(@"请输入您的手机号")];
           [MBProgressHUD showError:@"请输入您的原密码"];
           return NO;
       }

       if (!self.settingLoginView.textFied.text.length) {
           [MBProgressHUD showError:SSKJLanguage(@"请输入设置密码")];
          return NO;
       }

       
       if (!self.ensureLoginView.textFied.text.length) {
           [MBProgressHUD showError:SSKJLanguage(@"请再次输入密码")];
           return NO;
       }
       
       if (![RegularExpression validatePassword:self.settingLoginView.textFied.text]) {
           [MBProgressHUD showError:SSKJLanguage(@"密码格式不正确")];
          return NO;
       }
       
       if (![self.ensureLoginView.textFied.text isEqualToString:self.settingLoginView.textFied.text]) {
           [MBProgressHUD showError:SSKJLanguage(@"密码不一致")];
           return NO;
       }
    return YES;
}
@end

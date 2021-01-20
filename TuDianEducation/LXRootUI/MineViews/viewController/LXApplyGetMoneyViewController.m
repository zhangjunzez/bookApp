//
//  LXApplyGetMoneyViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/28.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXApplyGetMoneyViewController.h"
#import "LXContenGetMoneyRecodViewController.h"
#import "LXInputPaswViewController.h"
#import "LXSettingPayViewController.h"

#import "LXApplyGetMoneyItemView.h"

@interface LXApplyGetMoneyViewController ()<UITextViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) LXApplyGetMoneyItemView *bankNameView;
@property (nonatomic,strong) LXApplyGetMoneyItemView *userNameView;
@property (nonatomic,strong) LXApplyGetMoneyItemView *bankCardNumView;
@property (nonatomic,strong) LXApplyGetMoneyItemView *moneyAmountView;
@property (nonatomic,strong) UIView *beizhuView;
@property (nonatomic,strong) UILabel *beizhuTitleLabel;
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UILabel *placeHolderLabel;
@property (nonatomic,strong) UIButton *commitBtn;
@end

@implementation LXApplyGetMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];
    self.title = @"提现申请";
    [self addRightNavItemWithTitle:@"提现记录" color:kMainTxtColor font:systemFont(ScaleW(16))];
}
-(void)rigthBtnAction:(id)sender{
    LXContenGetMoneyRecodViewController *vc = [[LXContenGetMoneyRecodViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar)];
        _scrollView.backgroundColor = kMainBgColor;
        [_scrollView addSubview:self.bankNameView];
        [_scrollView addSubview:self.userNameView];
        [_scrollView addSubview:self.bankCardNumView];
        [_scrollView addSubview:self.moneyAmountView];
        [_scrollView addSubview:self.beizhuView];
        
        [_scrollView addSubview:self.commitBtn];

        if (ScreenHeight  < self.commitBtn.bottom + ScaleW(160)) {
            self.scrollView.contentSize = CGSizeMake(0, self.commitBtn.bottom + ScaleW(160));
        }else{
            self.scrollView.contentSize = CGSizeMake(0, ScreenHeight);
        }
        
    }
    return _scrollView;
}
-(LXApplyGetMoneyItemView *)bankNameView
{
    if (!_bankNameView) {
        _bankNameView = [[LXApplyGetMoneyItemView alloc]initWithTitle:@"开户行名称" top:ScaleW(10) placeHolder:@"请输入"];
      NSString *string =  [kUserDefaults objectForKey:@"KHHXM"];
        if (string.length) {
            _bankNameView.textFied.text = string;
        }
    }
    return _bankNameView;
}
-(LXApplyGetMoneyItemView *)userNameView
{
    if (!_userNameView) {
        _userNameView = [[LXApplyGetMoneyItemView alloc]initWithTitle:@"开户人姓名" top:ScaleW(10)  + _bankNameView.bottom placeHolder:@"请输入"];
       NSString *string =  [kUserDefaults objectForKey:@"KHRXM"];
        if (string.length) {
            _userNameView.textFied.text = string;
            _userNameView.textFied.userInteractionEnabled = NO;
        }
    }
    return _userNameView;
}
-(LXApplyGetMoneyItemView *)bankCardNumView
{
    if (!_bankCardNumView) {
        _bankCardNumView = [[LXApplyGetMoneyItemView alloc]initWithTitle:@"银行卡号" top:_userNameView.bottom placeHolder:@"请输入"];
        _bankCardNumView.textFied.keyboardType = UIKeyboardTypeNumberPad;
        NSString *string =  [kUserDefaults objectForKey:@"YHKH"];
               if (string.length) {
                   _bankCardNumView.textFied.text = string;
                   
               }
    }
    return _bankCardNumView;
}
-(LXApplyGetMoneyItemView *)moneyAmountView
{
    if (!_moneyAmountView) {
        _moneyAmountView = [[LXApplyGetMoneyItemView alloc]initWithTitle:@"提现金额" top:_bankCardNumView.bottom + ScaleW(10) placeHolder:@"请输入"];
        _moneyAmountView.textFied.keyboardType = UIKeyboardTypeDecimalPad;
    }
    return _moneyAmountView;
}
-(UIView *)beizhuView
{
    if (!_beizhuView) {
        _beizhuView = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(10) + _moneyAmountView.bottom, ScreenWidth, ScaleW(120))];
        _beizhuView.backgroundColor = kWhiteColor;
        [_beizhuView addSubview:self.beizhuTitleLabel];
        [_beizhuView addSubview:self.textView];
        [_beizhuView addSubview:self.placeHolderLabel];
        
    }
    return _beizhuView;
}
-(UILabel *)beizhuTitleLabel
{
    if (!_beizhuTitleLabel) {
        _beizhuTitleLabel = [WLTools allocLabel:@"备注" font:systemBoldFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(26), ScaleW(15), ScreenWidth - ScaleW(26), ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _beizhuTitleLabel;
}
-(UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(ScaleW(26), ScaleW(14) + _beizhuTitleLabel.bottom, _beizhuView.width - ScaleW(20), ScaleW(70))];
        _textView.delegate = self;
        _textView.font = kFont(15);
    }
    return _textView;
}
-(UILabel *)placeHolderLabel{
    if (!_placeHolderLabel) {
        _placeHolderLabel = [WLTools allocLabel:@"请填写你所需要的备注~" font:systemFont(14) textColor:kGrayTxtColor frame:CGRectMake(_textView.left, _textView.top + ScaleW(5), _textView.width, ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _placeHolderLabel;
}
-(UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [WLTools allocButtonTitle:@"提交" font:systemBoldFont(17) textColor:kWhiteColor image:nil frame:CGRectMake(ScaleW(100), ScaleW(100) + _beizhuView.bottom, ScaleW(175), ScaleW(40)) sel:@selector(commitAction:) taget:self];
        _commitBtn.backgroundColor = kBlueColor;
        [_commitBtn setCornerRadius:_commitBtn.height/2.f];
    }
    return _commitBtn;
}

-(void)preasntVc:(UIViewController *)vc
{
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
     [self.navigationController presentViewController:vc animated:YES completion:^{
         //
         vc.view.superview.backgroundColor = [UIColor clearColor];
     }];
}
#pragma mark  ---Action
-(void)setDefultBtnAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
}
-(void)commitAction:(UIButton *)sender{
    [kUserDefaults setObject:_bankNameView.textFied.text?:@"" forKey:@"KHHXM"];
    [kUserDefaults setObject:_userNameView.textFied.text?:@"" forKey:@"KHRXM"];
    [kUserDefaults setObject:_bankCardNumView.textFied.text?:@"" forKey:@"YHKH"];
    if ([self pamasIsOkOrNot]) {
       LXInputPaswViewController *vc = [[LXInputPaswViewController alloc]init];
        WS(weakSelf);
        vc.callBackBlock = ^(NSString * _Nonnull payPassWord) {
            [weakSelf requstConmmitWithPassWord:payPassWord];
        };
        vc.forgetPayPassWordBlock = ^{
            LXSettingPayViewController *vc = [[LXSettingPayViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [self preasntVc:vc];
    }
   
}
-(void)requstConmmitWithPassWord:(NSString *)passWord{
    
    NSDictionary *pamas = @{@"bankname":_bankNameView.textFied.text,@"username":_userNameView.textFied.text,@"banknum":_bankCardNumView.textFied.text,@"money":_moneyAmountView.textFied.text,@"remarks":_textView.text?:@"",@"paypassword":passWord};
           WS(weakSelf);
              [NetWorkTools postConJSONWithUrl:kAddwithdrawalengineerUrl parameters:pamas success:^(id responseObject) {
                  
                  NSString *result = responseObject[@"result"];
                  NSString *resultNote = responseObject[@"resultNote"];
                  if ([result integerValue] == 0) {
                      [weakSelf.navigationController popViewControllerAnimated:YES];
                  }
                  [MBProgressHUD showError:resultNote];
                 } fail:^(NSError *error) {
                     
           }];
}
-(BOOL)pamasIsOkOrNot{
   
       if (!self.bankNameView.textFied.text.length) {
          // [SSTool error:SSKJLanguage(@"请输入您的手机号")];
           [MBProgressHUD showError:@"请输入开户行名称"];
           return NO;
       }

       if (!self.userNameView.textFied.text.length) {
           [MBProgressHUD showError:SSKJLanguage(@"请输入开户人姓名")];
          return NO;
       }

       
       if (!self.bankCardNumView.textFied.text.length) {
           [MBProgressHUD showError:SSKJLanguage(@"请输入银行卡号")];
           return NO;
       }
       if (!self.moneyAmountView.textFied.text.length) {
           [MBProgressHUD showError:SSKJLanguage(@"请输入提现金额")];
           return NO;
       }
    return YES;
}
#pragma mark --textViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *contentString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    if (contentString.length == 0) {
        self.placeHolderLabel.hidden = NO;
    }else{
        self.placeHolderLabel.hidden = YES;
    }
    return YES;
}
@end

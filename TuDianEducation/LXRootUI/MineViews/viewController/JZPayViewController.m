//
//  JZPayViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/9/22.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//


#import "JZPayViewController.h"
#import "JZPayWaysItemsView.h"
#import "JZChartHeaderView.h"
#import "LXInputPaswViewController.h"
#import "LXSettingPayViewController.h"
#import <AlipaySDK/AlipaySDK.h>//支付宝
#import "WXPayHandler.h"

@interface JZPayViewController ()
@property (nonatomic,strong) JZChartHeaderView *headerView;
@property (nonatomic,strong) JZPayWaysItemsView *weChatView;
@property (nonatomic,strong) JZPayWaysItemsView *alipayView;
@property (nonatomic,strong) JZPayWaysItemsView *bankView;
@property (nonatomic,strong) JZPayWaysItemsView *yueView;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIButton *commitBtn;
@end

@implementation JZPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择付款方式";
    [self.view addSubview:self.scrollView];
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight- Height_NavBar)];
       
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [_scrollView addSubview:self.headerView];
        [_scrollView addSubview:self.weChatView];
        [_scrollView addSubview:self.alipayView];
//        [_scrollView addSubview:self.bankView];
        [_scrollView addSubview:self.yueView];
        [_scrollView addSubview:self.commitBtn];
        _scrollView.contentSize = CGSizeMake(0, self.commitBtn.bottom + ScaleW(60));
    }
    return _scrollView;
}
-(JZChartHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[JZChartHeaderView alloc]init];
        _headerView.top = ScaleW(30);
        _headerView.titleLabel.text = @"需支付";
        _headerView.inputTextFild.text = _moneyAmount?:@"￥888.88";
        NSString *string = _headerView.inputTextFild.text;
        NSMutableAttributedString *atts = [[NSMutableAttributedString alloc] initWithString:string];
        [atts setAttributes:@{NSFontAttributeName:systemBoldFont(ScaleW(25))} range:NSMakeRange(1,  string.length - 4)];
        _headerView.inputTextFild.attributedText = atts;
        _headerView.userInteractionEnabled = NO;
    }
    return _headerView;
}
-(JZPayWaysItemsView *)weChatView{
    if (!_weChatView) {
        _weChatView = [[JZPayWaysItemsView alloc]initWiteTop:_headerView.bottom + ScaleW(50) headerImg:@"weixinzhifu" name:@"微信支付" subName:@""];
        _weChatView.beSelectBtn.selected = self.payType == payTypeWeChatPay;
        _weChatView.subNameLabel.hidden = YES;
        WS(weakSelf);
        _weChatView.selectBlock = ^(BOOL isSelected) {
            weakSelf.payType = payTypeWeChatPay;
            weakSelf.alipayView.beSelectBtn.selected = NO;
            weakSelf.bankView.beSelectBtn.selected = NO;
            weakSelf.yueView.beSelectBtn.selected = NO;
        };
    }
    return  _weChatView;
}
-(JZPayWaysItemsView *)alipayView{
    if (!_alipayView) {
        _alipayView = [[JZPayWaysItemsView alloc]initWiteTop:_weChatView.bottom + ScaleW(15) headerImg:@"JZAlipay" name:@"支付宝" subName:@""];
         _alipayView.beSelectBtn.selected = self.payType == payTypeAlipay;
         _alipayView.subNameLabel.hidden = YES;
       
         WS(weakSelf);
         _alipayView.selectBlock = ^(BOOL isSelected) {
             weakSelf.payType = payTypeAlipay;
             weakSelf.weChatView.beSelectBtn.selected = NO;
             weakSelf.bankView.beSelectBtn.selected = NO;
             weakSelf.yueView.beSelectBtn.selected = NO;
         };
    }
    return  _alipayView;
}
-(JZPayWaysItemsView *)bankView{
    if (!_bankView) {
        _bankView = [[JZPayWaysItemsView alloc]initWiteTop:_alipayView.bottom + ScaleW(15) headerImg:@"yinhangka" name:@"银行卡" subName:@"中国银行尾号（0769）"];
         _bankView.beSelectBtn.selected = self.payType == payTypeBankPay;
         _weChatView.subNameLabel.hidden = YES;
         WS(weakSelf);
         _bankView.selectBlock = ^(BOOL isSelected) {
             weakSelf.payType = payTypeBankPay;
             weakSelf.alipayView.beSelectBtn.selected = NO;
             weakSelf.weChatView.beSelectBtn.selected = NO;
             weakSelf.yueView.beSelectBtn.selected = NO;
         };
    }
    return  _bankView;
}
-(JZPayWaysItemsView *)yueView{
    if (!_yueView) {
           _yueView = [[JZPayWaysItemsView alloc]initWiteTop:_alipayView.bottom + ScaleW(15) headerImg:@"64-金币_d" name:@"余额支付" subName:@""];
        _yueView.beSelectBtn.selected = self.payType == payTypeYuepay;
        _yueView.subNameLabel.hidden = YES;
        _yueView.headerImgView.width = ScaleW(20);
        _yueView.headerImgView.height = ScaleW(20);
        WS(weakSelf);
        _yueView.selectBlock = ^(BOOL isSelected) {
            weakSelf.payType = payTypeYuepay;
            weakSelf.alipayView.beSelectBtn.selected = NO;
            weakSelf.bankView.beSelectBtn.selected = NO;
            weakSelf.weChatView.beSelectBtn.selected = NO;
        };
       }
       return  _yueView;
}
-(UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [WLTools allocButtonTitle:@"立即支付" font:systemBoldFont(17) textColor:kWhiteColor image:nil frame:CGRectMake(ScaleW(25), ScaleW(80) + _yueView.bottom, ScaleW(325), ScaleW(40)) sel:@selector(commitAction:) taget:self];
        _commitBtn.backgroundColor = kRedColor;
         _commitBtn.layer.cornerRadius = _commitBtn.height/2.f;
    }
    return _commitBtn;
}


-(void)commitAction:(UIButton *)sender{

    if (self.payType == payTypeYuepay) {
        WS(weakSelf);
        LXInputPaswViewController *vc = [[LXInputPaswViewController alloc]init];
        vc.callBackBlock = ^(NSString * _Nonnull payPassWord) {
             if (weakSelf.payType == payTypeYuepay) {
                 [weakSelf requstYuePassWord:payPassWord];
             }
        };
        vc.forgetPayPassWordBlock = ^{
                       LXSettingPayViewController *vc = [[LXSettingPayViewController alloc]init];
                       [weakSelf.navigationController pushViewController:vc animated:YES];
                   };
        [self preasntVc:vc];
    }else if (self.payType == payTypeWeChatPay) {
        [self requestWechatPay];
    }else if (self.payType == payTypeAlipay) {
        [self requestAliPay];
    }
       
  
   
}

#pragma mark ---- 余额支付
-(void)requstYuePassWord:(NSString *)passWord{
    NSDictionary *pamas = @{@"ordernum":_ordernum,@"money":_moneyAmount,@"paypassword":passWord};
           WS(weakSelf);
              [NetWorkTools postConJSONWithUrl:@"engineerbalancepay" parameters:pamas success:^(id responseObject) {
                  
                  NSString *result = responseObject[@"result"];
                  NSString *resultNote = responseObject[@"resultNote"];
                  if ([result integerValue] == 0) {
                      [weakSelf.navigationController popViewControllerAnimated:YES];
                  }
                  [MBProgressHUD showError:resultNote];
                 } fail:^(NSError *error) {
                     
           }];
}

#pragma mark ---- 微信支付
- (void)requestWechatPay
{
    NSDictionary *pamas = @{@"ordernum":_ordernum,@"money":_moneyAmount};
    WS(weakSelf);
    [NetWorkTools postConJSONWithUrl:@"engineerweixinpay" parameters:pamas success:^(id responseObject) {
        NSString *result = responseObject[@"result"];
        NSString *resultNote = responseObject[@"resultNote"];
        if ([result integerValue] == 0) {
            [weakSelf WXPayWithbodyDic:[responseObject objectForKey:@"body"]];
        }else{
            [MBProgressHUD showError:resultNote];
        }
    } fail:^(NSError *error) {
              
    }];
}

- (void)WXPayWithbodyDic:(NSDictionary *)bodyDic{
    [WXPayHandler WXPayWithbodyDic:bodyDic];
}

#pragma mark ---- 处理微信支付结果
- (void)wxPaySatus:(NSNotification*)noti{
    NSLog(@"微信支付--%@---%d",noti.object,[noti.object intValue]);
    if ([noti.object intValue] == 0) {//支付成功
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
        
    }else if ([noti.object intValue] == -1){//支付失败
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showError:@"支付失败"];
        });
        
    }else if ([noti.object intValue] == -2){//取消支付
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showError:@"您已经取消了支付"];
        });
    }
}


#pragma mark ---- 支付宝支付
- (void)requestAliPay
{
    NSDictionary *pamas = @{@"ordernum":_ordernum,@"money":_moneyAmount};
    WS(weakSelf);
    [NetWorkTools postConJSONWithUrl:@"zhifubaopay" parameters:pamas success:^(id responseObject) {
        NSString *result = responseObject[@"result"];
        NSString *resultNote = responseObject[@"resultNote"];
        if ([result integerValue] == 0) {
            [[[UIApplication sharedApplication] windows] objectAtIndex:0].hidden = NO;

            //支付宝支付   //签名和拼接在后台，APP不在进行二次签名
            //需要在info文件  URL Types中建一个URL Schems 支付宝返回应用用到
            NSString *appScheme = @"GongXUGongCHengShi";
            // NOTE: 调用支付结果开始支付宝支付
            [[AlipaySDK defaultService] payOrder:[responseObject objectForKey:@"body"] fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                NSString *resultState = [resultDic objectForKey:@"resultStatus"];
                //支付失败
                if ([resultState isEqualToString:@"9000"]) {
                    //支付成功
                    dispatch_async(dispatch_get_main_queue(), ^{

                    });
                }else if ([resultState isEqualToString:@"8000"]) {
                    //正在处理中，支付结果未知

                }else if ([resultState isEqualToString:@"6001"]){
                    //用户中途取消
                    [MBProgressHUD showError:@"您已经取消了支付"];
                }else if ([resultState isEqualToString:@"6002"]){
                    //网络连接出错
                    [MBProgressHUD showError:@"网络链接超时，请检查您的网络"];
                }else{

                }
            }];
        }else{
            [MBProgressHUD showError:resultNote];
        }
    } fail:^(NSError *error) {

    }];
}


@end

//
//  LXMarketOrderEnsureViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/2.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//


#import "LXMarketOrderEnsureViewController.h"
#import "LXInputPaswViewController.h"
#import "LXAddressListViewController.h"
#import "LXSettingPayViewController.h"
#import "JZPayViewController.h"

#import "LXMarketEnsureTopView.h"
#import "LXMarketBottomView.h"
#import "LXAddressModel.h"
@interface LXMarketOrderEnsureViewController ()
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) LXMarketEnsureTopView *headerView;
@property (nonatomic,strong) LXMarketBottomView*bottomView;
@property (nonatomic,strong) LXAddressModel *defultAddressModel;

@end

@implementation LXMarketOrderEnsureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.scrollView];
    [self collectListReq];
}
-(LXMarketBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[LXMarketBottomView alloc]init];
        _bottomView.bottom = ScreenHeight - Height_NavBar;
        WS(weakSelf);
        _bottomView.conformBuyBlock = ^{
            [weakSelf requstWithPassWord];
//            LXInputPaswViewController *vc = [[LXInputPaswViewController alloc]init];
//            vc.callBackBlock = ^(NSString * _Nonnull payPassWord) {
//
//            };
//            vc.forgetPayPassWordBlock = ^{
//                LXSettingPayViewController *vc = [[LXSettingPayViewController alloc]init];
//                [weakSelf.navigationController pushViewController:vc animated:YES];
//            };
//            [weakSelf preasntVc:vc];
        };
    }
    return _bottomView;;
}


-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar - self.bottomView.height)];
        _scrollView.backgroundColor = kMainBgColor;
        [_scrollView addSubview:self.headerView];
        
        if (ScreenHeight - _bottomView.height < self.headerView.bottom + ScaleW(60)) {
            self.scrollView.contentSize = CGSizeMake(0, self.headerView.bottom + ScaleW(60));
        }else{
            self.scrollView.contentSize = CGSizeMake(0, ScreenHeight - _bottomView.height);
        }
        
    }
    return _scrollView;
}
-(LXMarketEnsureTopView *)headerView
{
    if (!_headerView) {
        _headerView = [[LXMarketEnsureTopView alloc]init];
        WS(weakSelf);
        _headerView.gotoAddressBlock = ^{
            LXAddressListViewController *vc = [[LXAddressListViewController alloc]init];
            vc.type = AddressListTypeEdting;
            vc.callBackBlock = ^(LXAddressModel * _Nonnull model) {
                weakSelf.defultAddressModel = model;
            };
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        _headerView.scoreAmountBlock = ^(NSInteger amount) {
            //weakSelf.bottomView.priceLabel.text = [NSString stringWithFormat:@"￥%.2f+%ld积分",amount*self.model.goodsprice1.doubleValue,amount*self.model.goodsprice.integerValue];
            NSString *p1 = [NSString stringWithFormat:@"%.2f",amount*self.model.goodsprice1.doubleValue];
            NSString *p2 = [NSString stringWithFormat:@"%ld",amount*self.model.goodsprice.integerValue];
            weakSelf.bottomView.priceLabel.text = [weakSelf returnStringForShow:p1 price2:p2];
        };
        _headerView.detailModel = self.model;
    }
    return _headerView;
}
-(NSString *)returnStringForShow:(NSString *)price1 price2:(NSString *)price2{
    if (price1.doubleValue == 0) {
        return  [NSString stringWithFormat:@"%@积分",price2];
    }
    if (price2.doubleValue == 0) {
        return  [NSString stringWithFormat:@"￥%@",price1];
    }
    if (price2.doubleValue != 0 &&price1.doubleValue != 0) {
        return  [NSString stringWithFormat:@"￥%@+%@积分",price1,price2];
    }
    return @"免费";
}


-(void)preasntVc:(UIViewController *)vc
{
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
     [self.navigationController presentViewController:vc animated:YES completion:^{
         //
         vc.view.superview.backgroundColor = [UIColor clearColor];
     }];
}
-(void)setDefultAddressModel:(LXAddressModel *)defultAddressModel{
    _defultAddressModel = defultAddressModel;
    _headerView.model = _defultAddressModel;
    
}
-(void)collectListReq
{

 NSDictionary * pamas = @{@"nowPage":[NSString stringWithFormat:@"%@",@"1"],@"pageCount":[NSString stringWithFormat:@"%d",kPage_Size]};
    [NetWorkTools postConJSONWithUrl:kEngineerAddressListUrl parameters:pamas success:^(id responseObject) {
        NSString *result = responseObject[@"result"];
        NSString *resultNote = responseObject[@"resultNote"];
        NSArray *array = responseObject[@"dataList"];
        NSMutableArray *muArray = [NSMutableArray array];
        if (result.integerValue == 0) {
            for (NSDictionary *dic  in array) {
                LXAddressModel *model = [[LXAddressModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [muArray addObject:model];
            }
            self.defultAddressModel =[muArray firstObject];
        }else{
             [MBProgressHUD showError:resultNote];
        }
         
    } fail:^(NSError *error) {
        
    }];
}

-(void)requstWithPassWord{
    NSDictionary *pamas = @{@"goodsid":_model.goodsid,@"addressid":_defultAddressModel.addressid,@"amounts":[NSString stringWithFormat:@"%ld",_headerView.amountCount]};

             [NetWorkTools postConJSONWithUrl:kExchangegoodsUrl parameters:pamas success:^(id responseObject) {
                 NSString *result = responseObject[@"result"];
                 NSString *resultNote = responseObject[@"resultNote"];
                 NSString *ordernum = responseObject[@"ordernum"];
                // NSDictionary *data = responseObject[@"dataobject"];

                 if (result.integerValue == 0) {
                     if (self.model.goodsprice1.doubleValue == 0) {
                         [self gotopaypassWordOrderNum:ordernum];
                     }else{
                         JZPayViewController *vc = [JZPayViewController new];
                         vc.ordernum = ordernum;
                         vc.moneyAmount =[NSString stringWithFormat:@"%.2f", self.model.goodsprice1.doubleValue *self.headerView.amountCount];
                         [self.navigationController pushViewController:vc animated:YES];
                     }
                 }else{
                     [MBProgressHUD showError:resultNote];
                 }
                
             } fail:^(NSError *error) {

             }];
}
-(void)gotopaypassWordOrderNum:(NSString *)orderNum{
                LXInputPaswViewController *vc = [[LXInputPaswViewController alloc]init];
    WS(weakSelf);
                vc.callBackBlock = ^(NSString * _Nonnull payPassWord) {
                    [weakSelf payOnlyScorePassWord:payPassWord orderNum:orderNum];
                };
                vc.forgetPayPassWordBlock = ^{
                    LXSettingPayViewController *vc = [[LXSettingPayViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                };
                [self preasntVc:vc];
}


-(void)payOnlyScorePassWord:(NSString *)passWord orderNum:(NSString *)orderNum{
    NSDictionary *pamas = @{@"ordernum":orderNum,@"paypassword":passWord};

             [NetWorkTools postConJSONWithUrl:@"engineerjifenpay" parameters:pamas success:^(id responseObject) {
                 NSString *result = responseObject[@"result"];
                 NSString *resultNote = responseObject[@"resultNote"];
                 NSString *ordernum = responseObject[@"ordernum"];
                // NSDictionary *data = responseObject[@"dataobject"];

                 if (result.integerValue == 0) {
                     [self.navigationController popToRootViewControllerAnimated:YES];
                 }else{
                     
                 }
                 [MBProgressHUD showError:resultNote];
             } fail:^(NSError *error) {

             }];
}
    
@end

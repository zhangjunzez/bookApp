//
//  LXScoreMarkeDetailViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/2.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//


#import "LXScoreMarkeDetailViewController.h"

#import "BkConfirmViewController.h"

#import "LXDetailMarketView.h"
#import "LXDetailBottomView.h"
#import "LXMarketGoodsDetailModel.h"
@interface LXScoreMarkeDetailViewController ()
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) LXDetailMarketView *headerView;
@property (nonatomic,strong) LXDetailBottomView *bottomView;
@property (nonatomic,strong) UIButton *backBtn;
@property (nonatomic,strong) UIButton *commitBtn;

@property (nonatomic,strong) LXMarketGoodsDetailModel *model;

@end

@implementation LXScoreMarkeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.commitBtn];
    [self requstDetailDataRequst];
    
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight -  ScaleW(50))];
        _scrollView.backgroundColor = kMainBgColor;
        [_scrollView addSubview:self.headerView];
        [_scrollView addSubview:self.bottomView];
        _scrollView.hidden = YES;
        if (@available(iOS 11.0, *)) {
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        if (ScreenHeight  < self.bottomView.bottom + ScaleW(60)) {
            self.scrollView.contentSize = CGSizeMake(0, self.bottomView.bottom + ScaleW(60));
        }else{
            self.scrollView.contentSize = CGSizeMake(0, ScreenHeight);
        }
        WS(weakSelf);
        _scrollView.mj_header = [CustomGifHeader headerWithRefreshingBlock:^{
                [weakSelf requstDetailDataRequst];
        }];
        
    }
    return _scrollView;
}
-(UIButton *)backBtn{
    if (!_backBtn) {
        UIImage *backImg = [UIImage imageNamed:@"fanhui"];
        _backBtn = [WLTools allocButtonTitle:@"" font:systemFont(0) textColor:kWhiteColor image:[backImg imageChangeColor:kMainTxtColor] frame:CGRectMake(ScaleW(15), ScaleW(10) + Height_StatusBar, ScaleW(31), ScaleW(40)) sel:@selector(backBtnAction:) taget:self];
        //_backBtn.backgroundColor = kBacColor;
        //_backBtn.cornerRadius = _backBtn.height/2.f;
    }
    return _backBtn;
}
-(LXDetailMarketView *)headerView
{
    if (!_headerView) {
        _headerView = [[LXDetailMarketView alloc]init];
    }
    return _headerView;
}
-(LXDetailBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[LXDetailBottomView alloc]init];
        _bottomView.top = _headerView.bottom;
        WS(weakSelf);
        _bottomView.reloadFrameBlock = ^{
            if (ScreenHeight  < weakSelf.bottomView.bottom + ScaleW(60)) {
                weakSelf.scrollView.contentSize = CGSizeMake(0, weakSelf.bottomView.bottom);
            }else{
                weakSelf.scrollView.contentSize = CGSizeMake(0, ScreenHeight);
            }
        };
    }
    return _bottomView;
}
-(UIButton *)commitBtn
{
    if (!_commitBtn) {
        _commitBtn = [WLTools allocButtonTitle:@"立即兑换" font:systemFont(ScaleW(16)) textColor:kWhiteColor image:nil frame:CGRectMake(0, self.view.height - ScaleW(50), ScreenWidth, ScaleW(50)) sel:@selector(commitBtnAction:) taget:self];
        _commitBtn.backgroundColor = kGreenColor;
    }
    return _commitBtn;
}
-(void)commitBtnAction:(UIButton *)sender
{
//    if (![self ifNoLoginGotoLoginAction]) {
//        return;
//    }
    BkConfirmViewController *vc = [[BkConfirmViewController alloc]init];
    //vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)preasntVc:(UIViewController *)vc
{
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
     [self.navigationController presentViewController:vc animated:YES completion:^{
         //
         vc.view.superview.backgroundColor = [UIColor clearColor];
     }];
}
-(void)backBtnAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)requstDetailDataRequst{
    //kMyservicestodetailUrl
    NSDictionary *pamas = @{@"goodsid":_goodsId};
         [MBProgressHUD showHUDAddedTo:self.view animated:YES];
          [NetWorkTools postConJSONWithUrl:kGoodsdetailUrl parameters:pamas success:^(id responseObject) {
              NSString *result = responseObject[@"result"];
              NSString *resultNote = responseObject[@"resultNote"];
              NSDictionary *data = responseObject[@"dataobject"];
              self.scrollView.hidden = NO;
              [MBProgressHUD hideHUDForView:self.view animated:YES];
              [self.scrollView.mj_header endRefreshing];
              if (result.integerValue == 0) {
                  LXMarketGoodsDetailModel *model = [[LXMarketGoodsDetailModel alloc]init];
                  [model setValuesForKeysWithDictionary:data];
                  self.model = model;
                  
              }else{
                   [MBProgressHUD showError:resultNote];
              }

          } fail:^(NSError *error) {
              self.scrollView.hidden = NO;
             [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.scrollView.mj_header endRefreshing];
          }];
}
-(void)setModel:(LXMarketGoodsDetailModel *)model{
    _model = model;
    _headerView.model = _model;
    _bottomView.model = _model;
}
@end

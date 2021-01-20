//
//  LXServerDetailViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/29.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXServerDetailViewController.h"
#import "LXInputPaswViewController.h"

#import "LXServeDetailHeaderView.h"
#import "LXServeDetailBottomView.h"

#import "LXServerOrderDetailModel.h"
@interface LXServerDetailViewController ()
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) LXServeDetailHeaderView *headerView;
@property (nonatomic,strong) LXServeDetailBottomView *bottomView;
@property (nonatomic,strong) LXServerOrderDetailModel *model;

@end

@implementation LXServerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    [self.view addSubview:self.scrollView];
    [self requstDetailDataRequst];
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar )];
        _scrollView.backgroundColor = kMainBgColor;
        [_scrollView addSubview:self.headerView];
        [_scrollView addSubview:self.bottomView];
        
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
-(LXServeDetailHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[LXServeDetailHeaderView alloc]init];
        
    }
    return _headerView;
}
-(LXServeDetailBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[LXServeDetailBottomView alloc]init];
        _bottomView.top = _headerView.bottom + ScaleW(10);
        WS(weakSelf);
        _bottomView.confirmDoneBlock  = ^{
            [weakSelf ensureOrderWithOrdernum:weakSelf.model.ordernum];
        };
        _bottomView.deleteOrderBlock = ^{
            [weakSelf deleteOrderWithOrdernum:weakSelf.model.ordernum];
        };
    }
    return _bottomView;
}
-(void)deleteOrderWithOrdernum:(NSString *)ordernum{
        //kDeleteskillsUrl
        NSDictionary *pamas = @{@"ordernum":ordernum};
        [NetWorkTools postConJSONWithUrl:kOrderservicestodeleteengineer parameters:pamas success:^(id responseObject) {
               NSString *result = responseObject[@"result"];
               NSString *resultNote = responseObject[@"resultNote"];
              
               if (result.integerValue == 0) {
                   [self.navigationController popViewControllerAnimated:YES];
               }else{
                   
               }
                 [MBProgressHUD showError:resultNote];
           } fail:^(NSError *error) {
               
           }];
}
-(void)ensureOrderWithOrdernum:(NSString *)ordernum{

        NSDictionary *pamas = @{@"ordernum":ordernum};
        [NetWorkTools postConJSONWithUrl:kOrderservicestoconfirmengineerUrl parameters:pamas success:^(id responseObject) {
               NSString *result = responseObject[@"result"];
               NSString *resultNote = responseObject[@"resultNote"];
              
               if (result.integerValue == 0) {
                   [self headerRefresh];
               }else{
                   
               }
                 [MBProgressHUD showError:resultNote];
           } fail:^(NSError *error) {
               
           }];
    }
-(void)preasntVc:(UIViewController *)vc
{
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
     [self.navigationController presentViewController:vc animated:YES completion:^{
         //
         vc.view.superview.backgroundColor = [UIColor clearColor];
     }];
}
-(void)headerRefresh{
    [self.scrollView.mj_header beginRefreshing];
}
-(void)requstDetailDataRequst{
    //kMyservicestodetailUrl
    NSDictionary *pamas = @{@"ordernum":_ordernum};
    WS(weakSelf);
          [NetWorkTools postConJSONWithUrl:kEngineerorderservicestodetail parameters:pamas success:^(id responseObject) {
              
              NSString *result = responseObject[@"result"];
              NSString *resultNote = responseObject[@"resultNote"];
              NSDictionary *data = responseObject[@"dataobject"];
              
              if (result.integerValue == 0) {
                  LXServerOrderDetailModel *model = [[LXServerOrderDetailModel alloc]init];
                  [model setValuesForKeysWithDictionary:data];
                  self.model = model;
              }else{
                   [MBProgressHUD showError:resultNote];
              }
              [weakSelf.scrollView.mj_header endRefreshing];
          } fail:^(NSError *error) {
              [weakSelf.scrollView.mj_header endRefreshing];
          }];
}
-(void)setModel:(LXServerOrderDetailModel *)model{
    _model = model;
    _headerView.model = _model;
    _bottomView.model = _model;
}
@end

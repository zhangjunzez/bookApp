//
//  LXMarketDetailViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/29.


#import "LXMarketDetailViewController.h"
#import "LXMarketDetailHeaderView.h"
#import "LXMarketOrderView.h"
#import "LXMarketOrderBottomView.h"
#import "LXMarketOrderDetailModel.h"
#import "LXWuLiuFlowViewController.h"
@interface LXMarketDetailViewController ()
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) LXMarketDetailHeaderView *headerView;
@property (nonatomic,strong) LXMarketOrderView *orderView;
@property (nonatomic,strong) LXMarketOrderBottomView *bottomView;
@property (nonatomic,strong) LXMarketOrderDetailModel *model;

@end

@implementation LXMarketDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.scrollView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requstDetailDataRequst];
}
-(LXMarketOrderBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[LXMarketOrderBottomView alloc]init];
        _bottomView.bottom = ScreenHeight - Height_NavBar;
        WS(weakSelf);
        _bottomView.seeFlowsBlock = ^{
            LXWuLiuFlowViewController *vc = [[LXWuLiuFlowViewController alloc]init];
            vc.model = weakSelf.model;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        _bottomView.confirmDoneBlock = ^{
            [weakSelf requstConfimOrderOrdernum:weakSelf.model.ordernum];
        };
        _bottomView.deleteBlock = ^{
            [weakSelf deleteOrderWithOrdernum:weakSelf.model.ordernum];
        };
    }
    return _bottomView;;
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar - self.bottomView.height)];
        _scrollView.backgroundColor = kMainBgColor;
        [_scrollView addSubview:self.headerView];
        [_scrollView addSubview:self.orderView];
        
        if (ScreenHeight - _bottomView.height < self.orderView.bottom + ScaleW(60)) {
            self.scrollView.contentSize = CGSizeMake(0, self.orderView.bottom + ScaleW(60));
        }else{
            self.scrollView.contentSize = CGSizeMake(0, ScreenHeight - _bottomView.height);
        }
        
    }
    return _scrollView;
}
-(LXMarketDetailHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[LXMarketDetailHeaderView alloc]init];
        
    }
    return _headerView;
}
-(LXMarketOrderView *)orderView{
    if (!_orderView) {
        _orderView = [[LXMarketOrderView alloc]initWithTop:_headerView.bottom messageArray:@[@"订单编号： 201818112410",@"创建时间： 2019/12/09  21:31:41",@"订单状态： 待收货",@"快递单号：79857841",@"发货时间： 2019/12/09  21:31:41"]];
        
    }
    return _orderView;
}

-(void)preasntVc:(UIViewController *)vc
{
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
     [self.navigationController presentViewController:vc animated:YES completion:^{
         //
         vc.view.superview.backgroundColor = [UIColor clearColor];
     }];
}
-(void)requstDetailDataRequst{
    //kMyservicestodetailUrl
    NSDictionary *pamas = @{@"ordernum":_orderNum};

          [NetWorkTools postConJSONWithUrl:kMyordergoodsdetailUrl parameters:pamas success:^(id responseObject) {
              NSString *result = responseObject[@"result"];
              NSString *resultNote = responseObject[@"resultNote"];
              NSDictionary *data = responseObject[@"dataobject"];

              if (result.integerValue == 0) {
                  LXMarketOrderDetailModel *model = [[LXMarketOrderDetailModel alloc]init];
                  [model setValuesForKeysWithDictionary:data];
                  self.model = model;
              }else{
                   [MBProgressHUD showError:resultNote];
              }

          } fail:^(NSError *error) {

          }];
}
-(void)setModel:(LXMarketOrderDetailModel *)model{
    _model = model;
    self.headerView.model = model;
    self.orderView.model = model;
    self.bottomView.model = model;
}
-(void)requstConfimOrderOrdernum:(NSString *)ordernum{
    //kMyservicestodetailUrl
    NSDictionary *pamas = @{@"ordernum":ordernum};

          [NetWorkTools postConJSONWithUrl:kOrdergoodsconfirmUrl parameters:pamas success:^(id responseObject) {
              NSString *result = responseObject[@"result"];
              NSString *resultNote = responseObject[@"resultNote"];
             // NSDictionary *data = responseObject[@"dataobject"];

              if (result.integerValue == 0) {
                  [self requstDetailDataRequst];
              }else{
                  
              }
            [MBProgressHUD showError:resultNote];
          } fail:^(NSError *error) {

          }];
}
-(void)deleteOrderWithOrdernum:(NSString *)ordernum{
        //kDeleteskillsUrl
        NSDictionary *pamas = @{@"ordernum":ordernum};
        [NetWorkTools postConJSONWithUrl:kOrdergoodsdelete parameters:pamas success:^(id responseObject) {
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
@end

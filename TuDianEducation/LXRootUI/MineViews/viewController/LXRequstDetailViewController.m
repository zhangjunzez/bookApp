//
//  LXRequstDetailViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/29.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXRequstDetailViewController.h"
#import "LXCommentViewController.h"

#import "LXRequstDetailHeaderView.h"
#import "LXRequstBottomView.h"
#import "LXRequstOrderDetailModel.h"
#import "LXSaveUserInforTool.h"
#import <WebKit/WebKit.h>
#import "LXConfrimOrderViewController.h"
#import "OrderDetailBottomOctionView.h"
#import "SeeWuLiuViewController.h"
#import "BkMoneyBackViewController.h"
@interface LXRequstDetailViewController ()
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) LXRequstDetailHeaderView *headerView;
@property (nonatomic,strong) LXRequstBottomView *bottomView;
@property (nonatomic,strong) LXRequstOrderDetailModel *model;

@property (nonatomic,strong) OrderDetailBottomOctionView *payView;

@end

@implementation LXRequstDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.payView];
    [_scrollView.mj_header beginRefreshing];
    [self userGetcustomersAction];
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar - ScaleW(50))];
        _scrollView.backgroundColor = kMainBgColor;
        [_scrollView addSubview:self.headerView];
        [_scrollView addSubview:self.bottomView];
        
        [self reloadScrollViewContentSize];
        WS(weakSelf);
        _scrollView.mj_header = [CustomGifHeader headerWithRefreshingBlock:^{
                              [weakSelf requstDetailDataRequst];
                      }];
    }
    return _scrollView;
}
-(OrderDetailBottomOctionView *)payView{
    if (!_payView) {
        _payView = [[OrderDetailBottomOctionView alloc]init];
        _payView.top = ScreenHeight - Height_NavBar - ScaleW(50);
        WS(weakSelf);
        _payView.payBlock = ^{
            SeeWuLiuViewController *vc = [[SeeWuLiuViewController alloc]init];
            [weakSelf naviPushVc:vc];
        };
        _payView.cancellBlock = ^{
            LXCommentViewController *vc = [[LXCommentViewController alloc]init];
            [weakSelf naviPushVc:vc];
        };
    }
    return _payView;
}
-(void)reloadScrollViewContentSize{
     _bottomView.top = _headerView.bottom + ScaleW(10);
    if (ScreenHeight  < self.bottomView.bottom + ScaleW(60)) {
        self.scrollView.contentSize = CGSizeMake(0, self.bottomView.bottom + ScaleW(60));
    }else{
        self.scrollView.contentSize = CGSizeMake(0, ScreenHeight);
    }
}
-(LXRequstDetailHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[LXRequstDetailHeaderView alloc]init];
        WS(weakSelf);
        _headerView.reloadFrameBlock = ^{
           [weakSelf reloadScrollViewContentSize];
        };
        
    }
    return _headerView;
}
-(LXRequstBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[LXRequstBottomView alloc]init];
        _bottomView.top = _headerView.bottom + ScaleW(10);
                WS(weakSelf);
                _bottomView.confirmDoneBlock  = ^{
                    [weakSelf ensureOrderWithOrdernum:weakSelf.model.ordernum];
                };
                _bottomView.deleteOrderBlock = ^{
                    [weakSelf deleteOrderWithOrdernum:weakSelf.model.ordernum];
                };
            _bottomView.reloadFrameBlcok = ^{
                    [weakSelf reloadScrollViewContentSize];
               };
        
              _bottomView.contactBlock = ^{
                  
              };
        _bottomView.ensureBtnBlock = ^{
            BkMoneyBackViewController *vc = [[BkMoneyBackViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
            }
            return _bottomView;
        }
-(void)deleteOrderWithOrdernum:(NSString *)ordernum{
                //kDeleteskillsUrl
                NSDictionary *pamas = @{@"ordernum":ordernum};
                [NetWorkTools postConJSONWithUrl:kEngineerorderdemanddelete parameters:pamas success:^(id responseObject) {
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

    LXConfrimOrderViewController *vc = [[LXConfrimOrderViewController alloc]init];
    vc.ordernum = ordernum;
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
-(void)headerRefresh{
    [self.scrollView.mj_header beginRefreshing];
}
-(void)requstDetailDataRequst{
    //kMyservicestodetailUrl
    NSDictionary *pamas = @{@"ordernum":_ordernum};

          [NetWorkTools postConJSONWithUrl:kEngineerorderdemanddetail parameters:pamas success:^(id responseObject) {
              NSString *result = responseObject[@"result"];
              NSString *resultNote = responseObject[@"resultNote"];
              NSDictionary *data = responseObject[@"dataobject"];

              if (result.integerValue == 0) {
                  LXRequstOrderDetailModel *model = [[LXRequstOrderDetailModel alloc]init];
                  [model setValuesForKeysWithDictionary:data];
                  self.model = model;
              }else{
                   [MBProgressHUD showError:resultNote];
              }
         [self.scrollView.mj_header endRefreshing];
          } fail:^(NSError *error) {
         [self.scrollView.mj_header endRefreshing];
          }];
}
-(void)setModel:(LXRequstOrderDetailModel *)model{
    _model = model;
//    _headerView.model = _model;
//    _bottomView.model = _model;
}
///获取kGetcustomersUrl
-(void)userGetcustomersAction{
    if (kLogin) {
        [NetWorkTools postConJSONWithUrl:kGetcustomersUrl parameters:@{} success:^(id responseObject) {
            NSString *result = responseObject[@"result"];
            NSString *resultNote = responseObject[@"resultNote"];
            NSDictionary *data = responseObject[@"dataobject"];
            if ([result integerValue] == 0) {
                [LXSaveUserInforTool sharedUserTool].telNum = data[@"phone"];
            }else{
                 [MBProgressHUD showError:resultNote];
            }
                         
        } fail:^(NSError *error) {
            
        }];
    }
    
}
-(void)callToServer{
    if ([LXSaveUserInforTool sharedUserTool].telNum.length == 0) {
        return;
    }
    NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"tel:%@",[LXSaveUserInforTool sharedUserTool].telNum];

    WKWebView * callWebview = [[WKWebView alloc] init];

    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];

    [self.view addSubview:callWebview];
}
@end


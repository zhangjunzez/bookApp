//
//  LXMySeverViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/1.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//


#import "LXMySeverViewController.h"
#import "LXEdtingServerViewController.h"

#import "LXMyServerTopView.h"
#import "LXMyServerBottomView.h"
#import "LXServerDetailModel.h"
@interface LXMySeverViewController ()
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) LXMyServerTopView *headerView;
@property (nonatomic,strong) LXMyServerBottomView *bottomView;
@property (nonatomic,strong) LXServerDetailModel *model;
@property (nonatomic,strong) UIButton *confromBtn;

@end

@implementation LXMySeverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的服务";
    [self.view addSubview:self.scrollView];
    self.scrollView.hidden = YES;
    [self.view addSubview:self.confromBtn];
    [self addRightNavItemWithTitle:@"编辑" color:kSubTxtColor font:systemFont(ScaleW(16))];
    [self requstDetailDataRequst];
}
-(void)rigthBtnAction:(id)sender
{
    LXEdtingServerViewController *vc = [[LXEdtingServerViewController alloc]init];
    vc.model = _model;
    [self.navigationController pushViewController:vc animated:YES];
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar- ScaleW(50) )];
        _scrollView.backgroundColor = kMainBgColor;
        [_scrollView addSubview:self.headerView];
        [_scrollView addSubview:self.bottomView];
        
        if (ScreenHeight  < self.bottomView.bottom + ScaleW(60)) {
            self.scrollView.contentSize = CGSizeMake(0, self.bottomView.bottom + ScaleW(60));
        }else{
            self.scrollView.contentSize = CGSizeMake(0, ScreenHeight);
        }
        
    }
    return _scrollView;
}
-(LXMyServerTopView *)headerView
{
    if (!_headerView) {
        _headerView = [[LXMyServerTopView alloc]init];
        
    }
    return _headerView;
}
-(LXMyServerBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[LXMyServerBottomView alloc]init];
        _bottomView.top = _headerView.bottom;
        WS(weakSelf);
        _bottomView.reloadFrameBlcok = ^{
            if (ScreenHeight  < weakSelf.bottomView.bottom + ScaleW(60)) {
                       weakSelf.scrollView.contentSize = CGSizeMake(0, self.bottomView.bottom + ScaleW(60));
                   }else{
                       weakSelf.scrollView.contentSize = CGSizeMake(0, ScreenHeight);
            }
        };
    }
    return _bottomView;
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
    NSDictionary *pamas = @{@"servicesid":_serverId};
          
          [NetWorkTools postConJSONWithUrl:kMyservicestodetailUrl parameters:pamas success:^(id responseObject) {
              NSString *result = responseObject[@"result"];
              NSString *resultNote = responseObject[@"resultNote"];
              NSDictionary *data = responseObject[@"dataobject"];
               self.scrollView.hidden = NO;
              if (result.integerValue == 0) {
                  LXServerDetailModel *model = [[LXServerDetailModel alloc]init];
                  [model setValuesForKeysWithDictionary:data];
                  self.model = model;
              }else{
                   [MBProgressHUD showError:resultNote];
              }
               
          } fail:^(NSError *error) {
              
          }];
}
-(void)setModel:(LXServerDetailModel *)model{
    _model = model;
    self.headerView.model = _model;
    self.bottomView.model = _model;
    if (_model.state.integerValue == 0) {
        [self.confromBtn setTitle:@"下架服务" forState:(UIControlStateNormal)];
    }else{
        [self.confromBtn setTitle:@"上架服务" forState:(UIControlStateNormal)];
    }
}
-(UIButton *)confromBtn{
    if (!_confromBtn) {
        _confromBtn = [WLTools allocButtonTitle:@"上架服务" font:systemFont(ScaleW(18)) textColor:kWhiteColor image:nil frame:CGRectMake(0, ScreenHeight - Height_NavBar - ScaleW(50), ScreenWidth, ScaleW(50)) sel:@selector(confromBtnAction:) taget:self];
        _confromBtn.backgroundColor = kBlueColor;
    }
    return _confromBtn;
}
-(void)confromBtnAction:(UIButton *)sender{
    [self requstShangjia];
}

-(void)requstShangjia{
    NSDictionary *pamas = @{@"servicesid":_serverId};
           
           [NetWorkTools postConJSONWithUrl:kMyservicestoputUrl parameters:pamas success:^(id responseObject) {
               NSString *result = responseObject[@"result"];
               NSString *resultNote = responseObject[@"resultNote"];
               
               if (result.integerValue == 0) {
                   [self requstDetailDataRequst];
               }else{
                    
               }
               [MBProgressHUD showError:resultNote];
           } fail:^(NSError *error) {
               
           }];
}
@end

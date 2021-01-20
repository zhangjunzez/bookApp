//
//  LXMineViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/23.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXMineViewController.h"
#import "LXMineRecodeViewController.h"
#import "LXSettingViewController.h"
#import "LXMyScoreViewController.h"
#import "LXRealNameViewController.h"
#import "LXTuijianContentViewController.h"
#import "LXAddressListViewController.h"
#import "LXMinePublishViewController.h"
#import "LXMineServersViewController.h"
#import "LXHelpCenterViewController.h"
#import "LXSignActionViewController.h"
#import "LXRequstContentViewController.h"
#import "LXContenServerViewController.h"
#import "LXContentMarketViewController.h"
#import "LXPersionalViewController.h"
#import "LXScoreMarketViewController.h"


#import "LXMineBottomView.h"
#import "LXMineHeader.h"

#import "LXUserInforModel.h"
#import "LXSaveUserInforTool.h"
#import <WebKit/WebKit.h>

@interface LXMineViewController ()
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) LXMineHeader *headerView;
@property (nonatomic,strong) LXMineBottomView *bottomView;
@property (nonatomic,strong) UILabel *serverTelLineLabel;
@property (nonatomic,strong) NSString *telNum;
@end

@implementation LXMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    [self addRightNavgationItemWithImage:[UIImage imageNamed:@"wode_shezhi"]];
    self.view.backgroundColor = kMainBgColor;
    [self.view addSubview:self.scrollView];
    [self requsetHangYeIdRequstAction];
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar)];
        [_scrollView addSubview:self.headerView];
        [_scrollView addSubview:self.bottomView];
        [_scrollView addSubview:self.serverTelLineLabel];
        CGFloat off = self.serverTelLineLabel.bottom + ScaleW(60);
        _scrollView.contentSize = CGSizeMake(0, off > ScreenHeight?off:ScreenHeight);
    }
    return _scrollView;
}
-(LXMineHeader *)headerView{
    if (!_headerView) {
        _headerView = [[LXMineHeader alloc]init];
        WS(weakSelf);
        _headerView.userInforBlock = ^{
            if (![weakSelf ifNoLoginGotoLoginAction]) {
                return;
            }
            LXPersionalViewController *vc = [[LXPersionalViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
              
        };
        _headerView.requstOrderBlock = ^{
            if (![weakSelf ifNoLoginGotoLoginAction]) {
                return;
            }
            LXRequstContentViewController *vc = [[LXRequstContentViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        _headerView.serverOrderBlock = ^{
            if (![weakSelf ifNoLoginGotoLoginAction]) {
                return;
            }
            LXContenServerViewController *vc = [[LXContenServerViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        _headerView.scoreOrderBlock = ^{
            if (![weakSelf ifNoLoginGotoLoginAction]) {
                return;
            }
            LXContentMarketViewController *vc = [[LXContentMarketViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        _headerView.signActionBlock = ^{
            if (![weakSelf ifNoLoginGotoLoginAction]) {
                return;
            }
            LXSignActionViewController *vc = [[LXSignActionViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
        };
        _headerView.scoreMarketBlock = ^{
            LXScoreMarketViewController * vc = [[LXScoreMarketViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        
    }
    return _headerView;
}
-(LXMineBottomView *)bottomView
{
    //@
    if (!_bottomView) {
        _bottomView = [[LXMineBottomView alloc]initWithTop:_headerView.bottom imageArray:@[@"wode_wodeshouyi",@"wode_jifen2",@"wode_renzheng",@"wode_tuijian",@"wode_changyongdizhi",@"wode_bangzhu"] nameArray:@[@"我的收益",@"我的积分",@"实名认证",@"我的推荐",@"常用地址",@"帮助中心"]];
    }
    WS(weakSelf);
    _bottomView.itemClickedBlock = ^(NSInteger index, NSString * _Nonnull nameString) {
        if ([nameString isEqualToString:@"帮助中心"]) {
                   LXHelpCenterViewController *vc = [[LXHelpCenterViewController alloc] init];
                   [weakSelf.navigationController pushViewController:vc animated:YES];
            return;
               }
        if (![weakSelf ifNoLoginGotoLoginAction]) {
            return;
        }
        if ([nameString isEqualToString:@"我的收益"]) {
            LXMineRecodeViewController *vc = [[LXMineRecodeViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
        if ([nameString isEqualToString:@"我的积分"]) {
            LXMyScoreViewController *vc = [[LXMyScoreViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
        if ([nameString isEqualToString:@"实名认证"]) {
            //认证状态 0未认证 1审核中 2已认证 3审核失败
            LXUserInforModel *model = [LXSaveUserInforTool sharedUserTool].userInforModel;
            NSString *stausString = @"";
            if (model.isauth.integerValue == 0) {
                stausString = @"未认证";
            }
           if (model.isauth.integerValue == 1) {
               stausString = @"审核中";
            }
            if (model.isauth.integerValue == 2) {
                stausString = @"您已是认证工程师如需修改行业信息请到个人资料修改";
            }
            if (model.isauth.integerValue == 3) {
                stausString = @"认证失败";
            }
            if (model.isauth.integerValue == 0) {
                LXRealNameViewController *vc = [[LXRealNameViewController alloc]init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }else{
                [MBProgressHUD showError:stausString];
            }
            
        }
        if([nameString isEqualToString:@"我的推荐"]){
            LXTuijianContentViewController *vc = [[LXTuijianContentViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
        if ([nameString isEqualToString:@"常用地址"]) {
            LXAddressListViewController *vc = [[LXAddressListViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
        if ([nameString isEqualToString:@"学习管理"]) {
            LXMinePublishViewController *vc = [[LXMinePublishViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
        if ([nameString isEqualToString:@"服务管理"]) {
            LXMineServersViewController *vc = [[LXMineServersViewController alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
        //
       
    };
    return _bottomView;
}
-(UILabel *)serverTelLineLabel{
    if (!_serverTelLineLabel) {
        _serverTelLineLabel = [WLTools allocLabel:@"客服热线：******" font:systemFont(ScaleW(14)) textColor:kGrayTxtColor frame:CGRectMake(0, ScaleW(26) + _bottomView.bottom, ScreenWidth, ScaleW(14)) textAlignment:(NSTextAlignmentCenter)];
        _serverTelLineLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(callToServer)];
        [_serverTelLineLabel addGestureRecognizer:tap];
    }
    return _serverTelLineLabel;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.headerView.statusType = kLogin?MineStatusTypeLogin:MineStatusTypeLoginOut;
    [self userInforRequstAction];
    [self userGetcustomersAction];
    
}

#pragma mark ---rightAction
-(void)rigthBtnAction:(id)sender{
    
    LXSettingViewController *vc = [[LXSettingViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark -requstAction

-(void)userInforRequstAction{
    if (kLogin) {
        [NetWorkTools postConJSONWithUrl:kUserInforUrl parameters:@{} success:^(id responseObject) {
            NSString *result = responseObject[@"result"];
            NSString *resultNote = responseObject[@"resultNote"];
            NSDictionary *data = responseObject[@"dataobject"];
            if ([result integerValue] == 0) {
                LXUserInforModel *model = [[LXUserInforModel alloc]init];
                [model setValuesForKeysWithDictionary:data];
                [LXSaveUserInforTool sharedUserTool].userInforModel = model;
                self.headerView.model = model;
            }else{
                 [MBProgressHUD showError:resultNote];
            }
                         
        } fail:^(NSError *error) {
            
        }];
    }
   
    
}
///获取kGetcustomersUrl
-(void)userGetcustomersAction{
    if (kLogin) {
        [NetWorkTools postConJSONWithUrl:kGetcustomersUrl parameters:@{} success:^(id responseObject) {
            NSString *result = responseObject[@"result"];
            NSString *resultNote = responseObject[@"resultNote"];
            NSDictionary *data = responseObject[@"dataobject"];
            if ([result integerValue] == 0) {
                self.serverTelLineLabel.text = [NSString stringWithFormat:@"客服热线：%@",data[@"phone"]];
                self.telNum = data[@"phone"];
                [LXSaveUserInforTool sharedUserTool].telNum = self.telNum;
            }else{
                 [MBProgressHUD showError:resultNote];
            }
                         
        } fail:^(NSError *error) {
            
        }];
    }
    
}
-(void)callToServer{
    if (self.telNum.length == 0) {
        return;
    }
//    NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.telNum];
//
//    WKWebView * callWebview = [[WKWebView alloc] init];
//
//    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
//
//    [self.view addSubview:callWebview];
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.telNum];

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

   
}
#pragma mark ---数据准备

-(void)requsetHangYeIdRequstAction{
    
    [NetWorkTools postConJSONWithUrl:kGetskillstype parameters:@{} success:^(id responseObject) {
           NSString *result = responseObject[@"result"];
           NSString *resultNote = responseObject[@"resultNote"];
           NSArray *dataList = responseObject[@"dataList"];
           if ([result integerValue] == 0) {
               [LXSaveUserInforTool sharedUserTool].hangyeTypeArray = dataList;
               
           }else{
               [MBProgressHUD showError:resultNote];
           }
       } fail:^(NSError *error) {
           
       }];
}
@end

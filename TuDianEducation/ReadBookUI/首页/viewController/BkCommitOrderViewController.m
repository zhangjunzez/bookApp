//
//  BkCommitOrderViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/13.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "BkCommitOrderViewController.h"
#import "LXAddressListViewController.h"
#import "BkConformBottomView.h"
#import "BkOrderAddressView.h"
#import "BkGoodsMessageView.h"
#import "BkBeizhuView.h"
#import "JZPayViewController.h"
@interface BkCommitOrderViewController ()
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) BkConformBottomView *bottomView;
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) BkOrderAddressView *addressView;
@property (nonatomic,strong) BkGoodsMessageView *messageView;
@property (nonatomic,strong) BkBeizhuView *beizhuView;
@end

@implementation BkCommitOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.tableView];
    self.title = @"提交订单";
    
}
-(UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(200))];
        _headerView.backgroundColor = kSubBacColor;
        [_headerView addSubview:self.addressView];
        [_headerView addSubview:self.messageView];
        [_headerView addSubview:self.beizhuView];
        _headerView.height = self.beizhuView.bottom;
    }
    return _headerView;
}
-(BkOrderAddressView *)addressView{
    if (!_addressView) {
        _addressView = [[BkOrderAddressView alloc]init];
        WS(weakSelf);
        _addressView.gotoAddressBlock = ^{
            LXAddressListViewController *vc = [[LXAddressListViewController alloc]init];
            [weakSelf naviPushVc:vc];
        };
    }
    return _addressView;
}
-(BkGoodsMessageView *)messageView
{
    if (!_messageView) {
        _messageView = [[BkGoodsMessageView alloc]init];
        _messageView.top = _addressView.bottom;
    }
    return _messageView;
}
-(BkBeizhuView *)beizhuView{
    if (!_beizhuView) {
        _beizhuView = [[BkBeizhuView alloc]init];
        _beizhuView.top = _messageView.bottom;
    }
    return _beizhuView;
}


-(BkConformBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[BkConformBottomView alloc]init];
        _bottomView.bottom = ScreenHeight - Height_NavBar;
        WS(weakSelf);
        _bottomView.conformBuyBlock = ^{
            JZPayViewController *vc = [[JZPayViewController alloc]init];
            [weakSelf naviPushVc:vc];
        };
    }
    return _bottomView;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar - _bottomView.height) style:(UITableViewStyleGrouped)];
      
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.headerView;
       
        if (@available(iOS 11.0, *))
        {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }
        else
        {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
    }
    return _tableView;
}


@end

//
//  BkConfirmViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/8.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "BkConfirmViewController.h"
#import "BkDuihuanSucessViewController.h"
#import "LXAddressListViewController.h"
#import "BkOrderConfiromView.h"
#import "LXMarketBottomView.h"

@interface BkConfirmViewController ()
@property (nonatomic,strong) BkOrderConfiromView *headerView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) LXMarketBottomView *bottomView;
@end

@implementation BkConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单确认";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
}
-(BkOrderConfiromView *)headerView{
    if (!_headerView) {
        _headerView = [[BkOrderConfiromView alloc]init];
        WS(weakSelf);
        _headerView.selcetAddressBlock = ^(UILabel * _Nonnull label) {
            LXAddressListViewController *vc = [[LXAddressListViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
    }
    return _headerView;
}
-(LXMarketBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[LXMarketBottomView alloc]init];
        _bottomView.top = _tableView.bottom;
        WS(weakSelf);
        _bottomView.conformBuyBlock = ^{
            BkDuihuanSucessViewController *vc = [[BkDuihuanSucessViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        
    }
    return _bottomView;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth , ScreenHeight -  Height_TabBar - ScaleW(50)) style:(UITableViewStyleGrouped)];
       
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

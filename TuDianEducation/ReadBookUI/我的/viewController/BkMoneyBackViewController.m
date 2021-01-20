//
//  BkMoneyBackViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/9.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "BkMoneyBackViewController.h"
#import "BkMoneyBackView.h"
#import "CommitSucessViewController.h"
@interface BkMoneyBackViewController ()
@property (nonatomic,strong) BkMoneyBackView *headerView;
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation BkMoneyBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.title = @"退款/售后";
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(ScaleW(0), 0, ScreenWidth, ScreenHeight - Height_NavBar) style:(UITableViewStyleGrouped)];
        
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

-(BkMoneyBackView *)headerView{
    if (!_headerView) {
        _headerView = [[BkMoneyBackView alloc]init];
        WS(weakSelf);
        _headerView.callBackBlock = ^{
            CommitSucessViewController *vc = [[CommitSucessViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
    }
    return _headerView;
}


@end

//
//  BookMineViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/6.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "BookMineViewController.h"
#import "BookhuiyuanCenterViewController.h"
#import "BookScoreMarketViewController.h"
#import "LXMyScoreViewController.h"
#import "LXRequstContentViewController.h"
#import "BkMyPublishViewController.h"
#import "MySavedViewController.h"
#import "MyInvateViewController.h"
#import "MyServerTelViewController.h"
#import "LXSettingViewController.h"
#import "LXPersionalViewController.h"


#import "DSMineBackView.h"
#import "BookItemsView.h"
#import "BookOrderView.h"
#import "BookMoneyAccountView.h"
@interface BookMineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) DSMineBackView *headerView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSArray *imgArray;
@property (nonatomic,strong) UIView *tableHeaderView;
@property (nonatomic,strong) BookOrderView *orderView;
@property (nonatomic,strong) BookMoneyAccountView *accountView;
@property (nonatomic,strong) BookItemsView *huiyuanView;
@property (nonatomic,strong) BookItemsView *jifenView;
@end

@implementation BookMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = kSubBacColor;
}
-(DSMineBackView *)headerView{
    if (!_headerView) {
        _headerView = [[DSMineBackView alloc]init];
        WS(weakSelf);
        _headerView.headerBlock = ^{
//            if ([weakSelf ifNoLoginGotoLoginAction]) {
//
//            }
            LXPersionalViewController *vc = [[LXPersionalViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        _headerView.settingsBlock = ^{
            LXSettingViewController *vc = [[LXSettingViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
    }
    return _headerView;
}
-(UIView *)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _tableView.width, ScaleW(200))];
        [_tableHeaderView addSubview:self.orderView];
        [_tableHeaderView addSubview:self.accountView];
        [_tableHeaderView addSubview:self.huiyuanView];
        [_tableHeaderView addSubview:self.jifenView];
        _tableHeaderView.height = self.jifenView.bottom + ScaleW(10);
    }
    return _tableHeaderView;
}
-(BookOrderView *)orderView
{
    if (!_orderView) {
        _orderView = [[BookOrderView alloc]init];
        WS(weakSelf);
        _orderView.orderSelectBlock = ^(NSString * _Nonnull title) {
            LXRequstContentViewController *vc = [[LXRequstContentViewController alloc]init];
            vc.statusString = title;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        _orderView.seeAllOrderBlock = ^{
            LXRequstContentViewController *vc = [[LXRequstContentViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        
    }
    return _orderView;
}
-(BookMoneyAccountView *)accountView{
    if (!_accountView) {
        _accountView = [[BookMoneyAccountView alloc]init];
        _accountView.top = ScaleW(12) + _orderView.bottom;
        WS(weakSelf);
        _accountView.gotoBlock = ^{
            LXMyScoreViewController *vc = [[LXMyScoreViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
    }
    return _accountView;
}
-(BookItemsView *)huiyuanView{
    if (!_huiyuanView) {
        _huiyuanView = [[BookItemsView alloc]initWithTop:_accountView.bottom + ScaleW(10) x:0 name:@"会员中心" subName:@"享受更大优惠" bgImg:@"huiyuanbg"];
        WS(weakSelf);
        _huiyuanView.gotoBlock = ^{
            BookhuiyuanCenterViewController *vc = [[BookhuiyuanCenterViewController alloc]init];
            [weakSelf naviPushVc:vc];
        };
    }
    return _huiyuanView;
}
-(BookItemsView *)jifenView{
    if (!_jifenView) {
        _jifenView = [[BookItemsView alloc]initWithTop:_accountView.bottom + ScaleW(10) x:_huiyuanView.right + ScaleW(7) name:@"积分商城" subName:@"更多好货推荐" bgImg:@"huiyuanbg"];
        WS(weakSelf);
        _jifenView.gotoBlock = ^{
            BookScoreMarketViewController *vc = [[BookScoreMarketViewController alloc]init];
            [weakSelf naviPushVc:vc];
        };
    }
    return _jifenView;
}
-(NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        [_dataArray addObjectsFromArray:@[@"我的发布",@"我的收藏",@"我的邀请",@"客服热线"]];
    }
    return _dataArray;
}
-(NSArray *)imgArray{
    return @[@"wodefabu",@"wodeshoucang",@"wodeyaoqing",@"kafurexian"];
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(ScaleW(11), self.headerView.bottom - ScaleW(40), ScreenWidth - ScaleW(22), ScreenHeight -  Height_TabBar - self.headerView.bottom + ScaleW(40)) style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        _tableView.tableHeaderView = self.tableHeaderView;
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


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"UITableViewCell"];
        cell.textLabel.textColor = kMainTxtColor;
        cell.textLabel.font = [UIFont systemFontOfSize:ScaleW(13)];
        cell.backgroundColor = kWhiteColor;
        cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"chakanquanbu"]];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:self.imgArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *message = self.dataArray[indexPath.row];
    if ([message isEqualToString:@"我的发布"]) {
        BkMyPublishViewController *vc = [[BkMyPublishViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([message isEqualToString:@"我的收藏"]) {
        MySavedViewController *vc = [[MySavedViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([message isEqualToString:@"我的邀请"]) {
        MyInvateViewController *vc = [[MyInvateViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([message isEqualToString:@"客服热线"]) {
        MyServerTelViewController *vc = [[MyServerTelViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(40);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]initWithFrame:CGRectZero];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(44))];
    UILabel *nameLabel = [WLTools allocLabel:@"我的服务" font:systemBoldFont(ScaleW(13)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(12), 0, ScaleW(200), ScaleW(44)) textAlignment:(NSTextAlignmentLeft)];
    UIView *greenView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(12), ScaleW(26), ScaleW(50), ScaleW(4))];
    greenView.backgroundColor = kGreenColor;
    [view addSubview:greenView];
    [view addSubview:nameLabel];
    view.backgroundColor = kWhiteColor;
    return view;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return ScaleW(44);
}

@end

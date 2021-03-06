//
//  LXMyScoreViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/24.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXMyScoreViewController.h"
#import "BkMineYueTableViewCell.h"
//#import "TeacherShowModel.h"
#import "LXScoreHeaderView.h"

#import "LXUserInforModel.h"
#import "LXSaveUserInforTool.h"

#import "LXScoreListModel.h"
@interface LXMyScoreViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic) NSInteger pageNum;

@property(nonatomic, strong)NSArray *tempArray;
@property (nonatomic,strong) LXScoreHeaderView *headerView;

@property (nonatomic,assign) NSInteger currentStatus;
@end

@implementation LXMyScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的余额";
    ///默认为全部
    _currentStatus = -1;
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self.view addSubview:self.tableView];
    [self headerRefresh];
    [self userInforRequstAction];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(LXScoreHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[LXScoreHeaderView alloc]init];
        WS(weakSelf);
        _headerView.selectIndexBlock = ^(NSInteger index) {
            weakSelf.currentStatus = index- 1;
        };
    }
    return _headerView;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight -  Height_NavBar) style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
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
        WS(weakSelf);
        _tableView.mj_header = [CustomGifHeader headerWithRefreshingBlock:^{
                [weakSelf headerRefresh];
        }];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                [weakSelf footerRefresh];
        }];
    }
    return _tableView;
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BkMineYueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BkMineYueTableViewCell"];
    if (!cell) {
        cell = [[BkMineYueTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"BkMineYueTableViewCell"];
    }
    //cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    HomeTeacherDetailViewController *vc= [[HomeTeacherDetailViewController alloc]init];
//    self.tempArray = [self.dataArray copy];
//    TeachersModel *model = self.dataArray[indexPath.row];
//    vc.model = model;
//    vc.collectBlock = ^(BOOL bo) {
//        [self updatePageWithIndex:indexPath.section collect:bo];
//    };
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)updatePageWithIndex:(NSInteger)index collect:(BOOL)bo{
    
    if (bo) {
        [self.dataArray insertObject:self.tempArray[index] atIndex:index];
    }else{
        [self.dataArray removeObjectAtIndex:index];
    }
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(66);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]initWithFrame:CGRectZero];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    view.backgroundColor = kMainBgColor;
    return view;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return ScaleW(20);
}

#pragma mark - 上拉、下拉

-(void)headerRefresh
{
    self.pageNum = 1;
    [self collectListReq];
    
}

-(void)footerRefresh
{
    [self collectListReq];
}

-(void)endRefrash

{
    if (self.tableView.mj_header.state == MJRefreshStateRefreshing) {
        [self.tableView.mj_header endRefreshing];
    }
    
    if (self.tableView.mj_footer.state == MJRefreshStateRefreshing) {
        [self.tableView.mj_footer endRefreshing];
    }
}
-(void)handleListWithModel:(NSArray *)result
{
    
    if (self.pageNum == 1) {
        [self.dataArray removeAllObjects];
    }
    
    if (result.count != kPage_Size) {
        self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        self.tableView.mj_footer.state = MJRefreshStateIdle;
    }
    
    [self.dataArray addObjectsFromArray:result];
    [SSKJ_NoDataView showNoData:self.dataArray.count toView:self.tableView offY:ScaleW(10) + _headerView.height message:@"您还没有数据哦~" imge:[UIImage imageNamed:@"nolikesimg"]];
    
    self.pageNum++;
    
    [self endRefrash];
    
    [self.tableView reloadData];
    
}
-(void)collectListReq
{
    NSDictionary * pamas = @{};
    if (_currentStatus == -1) {
         pamas = @{@"nowPage":[NSString stringWithFormat:@"%ld",self.pageNum],@"pageCount":[NSString stringWithFormat:@"%d",kPage_Size]};
    }else{
        pamas = @{@"type":[NSString stringWithFormat:@"%ld",_currentStatus],@"nowPage":[NSString stringWithFormat:@"%ld",self.pageNum],@"pageCount":[NSString stringWithFormat:@"%d",kPage_Size]};
    }
    
       [NetWorkTools postConJSONWithUrl:kEngineerintegrallist parameters:pamas success:^(id responseObject) {
           NSString *result = responseObject[@"result"];
           NSString *resultNote = responseObject[@"resultNote"];
           NSArray *array = responseObject[@"dataList"];
           NSMutableArray *muArray = [NSMutableArray array];
           if (result.integerValue == 0) {
               for (NSDictionary *dic  in array) {
                   LXScoreListModel *model = [[LXScoreListModel alloc]init];
                   [model setValuesForKeysWithDictionary:dic];
                   [muArray addObject:model];
               }
               [self handleListWithModel:muArray];
           }else{
                [MBProgressHUD showError:resultNote];
           }
            
       } fail:^(NSError *error) {
           
       }];
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
                self.headerView.valueLabel.text = model.integrals;
            }else{
                 [MBProgressHUD showError:resultNote];
            }
                         
        } fail:^(NSError *error) {
            
        }];
    }
    
}
-(void)setCurrentStatus:(NSInteger)currentStatus{
    _currentStatus = currentStatus;
    [self.dataArray removeAllObjects];
    [self headerRefresh];
}
@end

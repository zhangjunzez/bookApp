//
//  LXWuLiuFlowViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/14.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//


#import "LXWuLiuFlowViewController.h"


#import "LXWuliuFlowTableViewCell.h"
#import "LXWuLiuFlowHeaderView.h"

#import "LXUserInforModel.h"
#import "LXSaveUserInforTool.h"

#import "LXMoneyModel.h"
@interface LXWuLiuFlowViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic) NSInteger pageNum;

@property(nonatomic, strong)NSArray *tempArray;
@property (nonatomic,strong) LXWuLiuFlowHeaderView *headerView;
@end

@implementation LXWuLiuFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"查看物流";
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self.view addSubview:self.tableView];
    
    //[self headerRefresh];
    

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self headerRefresh];
}
-(NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(LXWuLiuFlowHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[LXWuLiuFlowHeaderView alloc]init];
        _headerView.model = self.model;
       
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
    LXWuliuFlowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LXWuliuFlowTableViewCell"];
    if (!cell) {
        cell = [[LXWuliuFlowTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"LXWuliuFlowTableViewCell"];
    }
    NSDictionary *dic = self.dataArray[indexPath.row];
    cell.dateLabel.text = dic[@"AcceptTime"];
    cell.contentLabel.text = dic[@"AcceptStation"];
    [cell.contentLabel sizeToFit];
    NSString *content = dic[@"AcceptStation"];
     CGFloat height = [self.view returnHeight:content font:ScaleW(12) width:ScreenWidth - ScaleW(20)];
     cell.bacView.height = height + ScaleW(38);
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
    NSDictionary *dic = self.dataArray[indexPath.row];
    NSString *content = dic[@"AcceptStation"];
   CGFloat height = [self.view returnHeight:content font:ScaleW(12) width:ScreenWidth - ScaleW(20)];
   
    
    return height + ScaleW(48);
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
    return ScaleW(50);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return CGFLOAT_MIN;
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
-(void)collectListReq
{

    NSDictionary * pamas = @{@"logisticsnum":[NSString stringWithFormat:@"%@",self.model.logisticsnum],@"logistics":_model.logistics};
       [NetWorkTools postConJSONWithUrl:kLooklogisticsUrl parameters:pamas success:^(id responseObject) {
           NSString *result = responseObject[@"result"];
           NSString *resultNote = responseObject[@"resultNote"];
           NSArray *array = responseObject[@"dataList"];
          
           if (result.integerValue == 0) {
              
               [self handleListWithModel:array];
           }else{
                [MBProgressHUD showError:resultNote];
           }
            
       } fail:^(NSError *error) {
           
       }];
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
    [self.dataArray removeAllObjects];
    
    [self.dataArray addObjectsFromArray:result];
    
    
    [self endRefrash];
    
    [self.tableView reloadData];
    
}

///获取
@end

//
//  LXMarketOrderViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/29.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXMarketOrderViewController.h"
#import "LXMarketDetailViewController.h"
#import "LXWuLiuFlowViewController.h"

#import "LXGetMoneyControl.h"
#import "LXScoreOrderTableViewCell.h"

#import "LXScoreOrderListModel.h"

@interface LXMarketOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic) NSInteger pageNum;

@property(nonatomic, strong)NSArray *tempArray;
@end

@implementation LXMarketOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的订单";
    //[self addRightNavItemWithTitle:@"推荐规则" color:kSubTxtColor font:systemFont(ScaleW(16))];
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = kMainBgColor;
    
    

}
-(void)rigthBtnAction:(id)sender{
    
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

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight -  Height_NavBar -   ScaleW(46)) style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
       
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
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LXScoreOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LXScoreOrderTableViewCell"];
    if (!cell) {
        cell = [[LXScoreOrderTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"LXScoreOrderTableViewCell"];
       
    }
    LXScoreOrderListModel *model = self.dataArray[indexPath.row];
   
    WS(weakSelf);
    cell.deleteBlock = ^{
        [weakSelf deleteOrderWithOrdernum:model.ordernum];
    };
    cell.confirmDoneBlock = ^{
       [weakSelf requstConfimOrderOrdernum:model.ordernum];
    };
    
    cell.seeFlowsBlock = ^{
        LXWuLiuFlowViewController *vc = [[LXWuLiuFlowViewController alloc]init];
        LXMarketOrderDetailModel *detail = [[LXMarketOrderDetailModel alloc]init];
        detail.goodsimage = model.goodsimage;
        detail.goodsname = model.goodsname;
        detail.goodsid = model.goodsid;
        detail.logisticscompany = model.logisticscompany;
        detail.logistics = model.logistics;
        detail.logisticsnum = model.logisticsnum;
        vc.model = detail;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    cell.model = model;
    return cell;
}
-(void)requstConfimOrderOrdernum:(NSString *)ordernum{
    //kMyservicestodetailUrl
    NSDictionary *pamas = @{@"ordernum":ordernum};

          [NetWorkTools postConJSONWithUrl:kOrdergoodsconfirmUrl parameters:pamas success:^(id responseObject) {
              NSString *result = responseObject[@"result"];
              NSString *resultNote = responseObject[@"resultNote"];
             // NSDictionary *data = responseObject[@"dataobject"];

              if (result.integerValue == 0) {
                  [self.tableView.mj_header beginRefreshing];
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
                  [self.tableView.mj_header beginRefreshing];
               }else{
                   
               }
                 [MBProgressHUD showError:resultNote];
           } fail:^(NSError *error) {
               
           }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LXMarketDetailViewController *vc = [[LXMarketDetailViewController alloc]init];
   LXScoreOrderListModel *model = self.dataArray[indexPath.row];
    vc.orderNum = model.ordernum;
    [self.navigationController pushViewController:vc animated:YES];
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
     LXScoreOrderListModel *model = self.dataArray[indexPath.row];
    if (model.state.integerValue ==0 ) {
        return ScaleW(206);
    }
    return ScaleW(255);
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
  //
       ///订单状态 0待支付 1服务中 2待评价 3已完成 4异常订单
       NSDictionary *pamas = @{@"state":_state?:@""};
       if (_state.length) {
              pamas = @{@"state":_state,@"nowPage":[NSString stringWithFormat:@"%ld",self.pageNum],@"pageCount":[NSString stringWithFormat:@"%d",kPage_Size]};
          }else{
              pamas = @{@"nowPage":[NSString stringWithFormat:@"%ld",self.pageNum],@"pageCount":[NSString stringWithFormat:@"%d",kPage_Size]};
          }
          
          [NetWorkTools postConJSONWithUrl:kMyordergoodslistUrl parameters:pamas success:^(id responseObject) {
              NSString *result = responseObject[@"result"];
              NSString *resultNote = responseObject[@"resultNote"];
              NSArray *array = responseObject[@"dataList"];
              NSMutableArray *muArray = [NSMutableArray array];
              if (result.integerValue == 0) {
                  for (NSDictionary *dic  in array) {
                      LXScoreOrderListModel *model = [[LXScoreOrderListModel alloc]init];
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
    [SSKJ_NoDataView showNoData:self.dataArray.count toView:self.tableView offY:ScaleW(10) message:@"您还没有数据哦~" imge:[UIImage imageNamed:@"nolikesimg"]];
    
    self.pageNum++;
    
    [self endRefrash];
    
    [self.tableView reloadData];
    
}
@end

//
//  LXAddressListViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/28.
//  Copyright © 2020 zhangbenchao. All rights reserved.

#import "LXAddressListViewController.h"
#import "LXAddAddressViewController.h"

#import "LXAddressListTableViewCell.h"



@interface LXAddressListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic) NSInteger pageNum;
@property (nonatomic,strong) UIButton *addAddressBtn;

@property(nonatomic, strong)NSArray *tempArray;
@end

@implementation LXAddressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"请选择收货地址";
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.addAddressBtn];
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
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight -  Height_NavBar - ScaleW(50)) style:(UITableViewStyleGrouped)];
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
-(UIButton *)addAddressBtn{
    if (!_addAddressBtn) {
        _addAddressBtn = [WLTools allocButtonTitle:@"添加新地址" font:systemBoldFont(17) textColor:kWhiteColor image:nil frame:CGRectMake(ScaleW(10),ScreenHeight - Height_NavBar - ScaleW(70), ScreenWidth - ScaleW(20), ScaleW(40)) sel:@selector(addAddressBtn:) taget:self];
        _addAddressBtn.backgroundColor = kGreenColor;
        _addAddressBtn.cornerRadius = _addAddressBtn.height/2.f;
    }
    return _addAddressBtn;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LXAddressListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LXAddressListTableViewCell"];
    if (!cell) {
        cell = [[LXAddressListTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"LXAddressListTableViewCell"];
        
        
    }
    LXAddressModel *model = self.dataArray[indexPath.row];
    WS(weakSelf);
    cell.deleteBlock = ^{
        [weakSelf deleteWithNombersString:model.addressid];
    };
    
    cell.edtingBlock = ^{
        LXAddAddressViewController * vc = [[LXAddAddressViewController alloc]init];
        vc.addressNums = model.addressid;
        vc.model = model;
        vc.callBackBlock = ^{
            [weakSelf headerRefresh];
        };
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    //cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LXAddressModel *model = self.dataArray[indexPath.row];
    if (self.type == AddressListTypeEdting) {
        !self.callBackBlock?:self.callBackBlock(model);
        [self.navigationController popViewControllerAnimated:YES];
    }
    
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
    return ScaleW(95);
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

 NSDictionary * pamas = @{@"nowPage":[NSString stringWithFormat:@"%ld",self.pageNum],@"pageCount":[NSString stringWithFormat:@"%d",kPage_Size]};
    [NetWorkTools postConJSONWithUrl:kEngineerAddressListUrl parameters:pamas success:^(id responseObject) {
        NSString *result = responseObject[@"result"];
        NSString *resultNote = responseObject[@"resultNote"];
        NSArray *array = responseObject[@"dataList"];
        NSMutableArray *muArray = [NSMutableArray array];
        if (result.integerValue == 0) {
            for (NSDictionary *dic  in array) {
                LXAddressModel *model = [[LXAddressModel alloc]init];
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
#pragma mark -删除请求
-(void)deleteWithNombersString:(NSString *)numbs{
    NSDictionary *pamas = @{@"addressid":numbs};
    [NetWorkTools postConJSONWithUrl:kEngineerdeleteAddress parameters:pamas success:^(id responseObject) {
        NSString *result = responseObject[@"result"];
        NSString *resultNote = responseObject[@"resultNote"];
        
        if (result.integerValue == 0) {
            
            [self headerRefresh];
            
        }else{
            
        }
        [MBProgressHUD showError:resultNote];
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
  // [SSKJ_NoDataView showNoData:self.dataArray.count toView:self.tableView offY:ScaleW(10) message:@"还没有数据哦~" imge:[UIImage imageNamed:@"nolikesimg"]];
    
    self.pageNum++;
    
    [self endRefrash];
    
    [self.tableView reloadData];
    
}
#pragma mark --Action
-(void)addAddressBtn:(UIButton *)sender{
    LXAddAddressViewController * vc = [[LXAddAddressViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end

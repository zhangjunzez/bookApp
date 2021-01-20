//
//  MySavedViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/9.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "MySavedViewController.h"
#import "MySavedTableViewCell.h"

@interface MySavedViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic,strong) UITextField *searchTextFiled;
@property (nonatomic,strong) UIImageView *searchImg;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic) NSInteger pageNum;

@end
#define kViewTag(a) 100000 + a
@implementation MySavedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.automaticallyAdjustsScrollViewInsets = YES;
    [self.view addSubview:self.searchTextFiled];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = kWhiteColor;
    
    self.title = @"我的收藏";
    
    
}

-(UITextField *)searchTextFiled{
    if (!_searchTextFiled) {
        _searchTextFiled = [WLTools allocTextFieldTextFont:ScaleW(14) placeHolderFont:ScaleW(14) text:nil placeText:@"请输入商品名称进行搜索" textColor:kMainTxtColor placeHolderTextColor:kGrayTxtColor frame:CGRectMake(ScaleW(12), ScaleW(10),self.view.width - ScaleW(24), ScaleW(34))];
        _searchTextFiled.cornerRadius = _searchTextFiled.height/2.f;
        _searchTextFiled.leftViewMode = UITextFieldViewModeAlways;
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(34), _searchTextFiled.height)];
        [view addSubview:self.searchImg];
        _searchTextFiled.leftView = view;
        _searchTextFiled.backgroundColor = kMainBgColor;
        _searchTextFiled.delegate = self;
    }
    return _searchTextFiled;
}
-(UIImageView *)searchImg{
    if (!_searchImg) {
        _searchImg = [[UIImageView alloc ]initWithFrame:CGRectMake(ScaleW(15), ScaleW(9), ScaleW(12), ScaleW(12))];
        _searchImg.image = [[UIImage imageNamed:@"搜索"] imageChangeColor:kMainTxtColor];
        _searchImg.centerY = _searchTextFiled.height/2.f;
    }
    return _searchImg;
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
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.searchTextFiled.bottom, ScreenWidth, ScreenHeight - Height_NavBar - self.searchTextFiled.bottom) style:(UITableViewStyleGrouped)];
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
    return 2;
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MySavedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MycomendsTableViewCell"];
    if (!cell) {
        cell = [[MySavedTableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"MycomendsTableViewCell"];
  
    }
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(107);
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
    NSDictionary *pamas = @{@"pageNo":[NSString stringWithFormat:@"%ld",self.pageNum],@"pageSize":[NSString stringWithFormat:@"%d",kPage_Size]};
   

    [NetWorkTools postConJSONWithUrl:@"sysMessageList" parameters:pamas success:^(id responseObject) {
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
    
    if (self.pageNum == 1) {
        [self.dataArray removeAllObjects];
    }
    
    if (result.count != kPage_Size) {
        self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        self.tableView.mj_footer.state = MJRefreshStateIdle;
    }
    
    [self.dataArray addObjectsFromArray:result];
   
   [SSKJ_NoDataView showNoData:self.dataArray.count toView:self.tableView offY:ScaleW(10) message:@"还没有数据哦~" imge:[UIImage imageNamed:@"nolikesimg"]];
    
    self.pageNum++;
    
    [self endRefrash];
    
    [self.tableView reloadData];
    
}
@end

//
//  BkFaceDetailViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/12.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//


#import "BkFaceDetailViewController.h"
#import "BkFaceOptionViewController.h"

#import "BkFaceDetailHeader.h"
#import "BkFaceDetailSelectView.h"
#import "BkCommendsTableViewCell.h"

@interface BkFaceDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic) NSInteger pageNum;

@property (nonatomic,strong) BkFaceDetailSelectView *selctionView;
@property (nonatomic,strong) BkFaceDetailHeader *headerView;

@property (nonatomic,strong) UITextField *searchTextFiled;
@property (nonatomic,strong) UIButton *sendBtn;

@end

@implementation BkFaceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.automaticallyAdjustsScrollViewInsets = YES;
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = kWhiteColor;
    
    [self.view addSubview:self.sendBtn];
    [self.view addSubview:self.searchTextFiled];
    
    
}
-(UITextField *)searchTextFiled{
    if (!_searchTextFiled) {
        _searchTextFiled = [WLTools allocTextFieldTextFont:ScaleW(14) placeHolderFont:ScaleW(14) text:nil placeText:@"请输入文字" textColor:kMainTxtColor placeHolderTextColor:kGrayTxtColor frame:CGRectMake(ScaleW(12), ScreenHeight - Height_NavBar - ScaleW(45),ScaleW(291), ScaleW(30))];
        _searchTextFiled.cornerRadius = _searchTextFiled.height/2.f;
        _searchTextFiled.leftViewMode = UITextFieldViewModeAlways;
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(20), _searchTextFiled.height)];
        
        _searchTextFiled.leftView = view;
        _searchTextFiled.backgroundColor = kMainBgColor;
        _searchTextFiled.delegate = self;
    }
    return _searchTextFiled;
}

-(UIButton *)sendBtn{
    if (!_sendBtn) {
        _sendBtn = [WLTools allocButtonTitle:@"发送" font:systemFont(ScaleW(13)) textColor:kWhiteColor image:nil frame:CGRectMake(ScaleW(314), ScreenHeight - Height_NavBar - ScaleW(45), ScaleW(50), ScaleW(30)) sel:@selector(sendAction:) taget:self];
        _sendBtn.backgroundColor = kGreenColor;
        [_sendBtn setCornerRadius:_sendBtn.height/2.f];
    }
    return _sendBtn;
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
-(BkFaceDetailSelectView *)selctionView{
    if (!_selctionView) {
        _selctionView = [[BkFaceDetailSelectView alloc]init];
    }
    return _selctionView;
}
-(BkFaceDetailHeader *)headerView{
    if (!_headerView) {
        _headerView = [[BkFaceDetailHeader alloc]init];
    }
    return _headerView;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar - ScaleW(50) ) style:(UITableViewStyleGrouped)];
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
    BkCommendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BkCommendsTableViewCell"];
    if (!cell) {
        cell = [[BkCommendsTableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"BkCommendsTableViewCell"];
  
    }
    WS(weakSelf);
    cell.moreBlock = ^{
        BkFaceOptionViewController *vc = [[BkFaceOptionViewController alloc]init];
        [weakSelf preasntVc:vc];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(143);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]initWithFrame:CGRectZero];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(50))];
    [view addSubview:self.selctionView];
    view.backgroundColor = kMainBgColor;
    return view;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return ScaleW(50);
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

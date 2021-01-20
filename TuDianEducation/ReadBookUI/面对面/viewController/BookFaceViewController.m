//
//  BookFaceViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/6.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//


#import "BookFaceViewController.h"
#import "BkFacePublishViewController.h"
#import "BkFaceDetailViewController.h"

#import "MyXindeTableViewCell.h"
#import "BkFaceControlView.h"
#import "LXMessageViewController.h"
@interface BookFaceViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic) NSInteger pageNum;
@property (nonatomic,strong) UIButton *publishBtn;
@property (nonatomic,strong) UIButton *messageBtn;
@property (nonatomic,strong) UITextField *searchTextFiled;
@property (nonatomic,strong) UIImageView *searchImg;
@property (nonatomic,strong) BkFaceControlView *faceHeaderView;



@end

@implementation BookFaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.automaticallyAdjustsScrollViewInsets = YES;
    [self.view addSubview:self.faceHeaderView];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = kWhiteColor;
    [self navigationConfig];
}
-(void)navigationConfig{
    self.navigationItem.titleView = self.searchTextFiled;
    [self addLeftNavItemWithImage:[UIImage imageNamed:@"添加"]];
    [self addRightNavgationItemWithImage:[UIImage imageNamed:@"wuxiaoxi"]];
    
}
-(BkFaceControlView *)faceHeaderView{
    if (!_faceHeaderView) {
        _faceHeaderView = [[BkFaceControlView alloc]initWithTop:0 titleArray:@[@"推荐",@"0~3岁",@"0~3岁",@"0~3岁",@"0~3岁",@"0~3岁"]];
        _faceHeaderView.btnClickedBlock = ^(NSInteger index) {
            
        };
    }
    return _faceHeaderView;
}
#pragma mark ---发布事件
-(void)leftBtnAction:(id)sender{
    BkFacePublishViewController *vc = [[BkFacePublishViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark --消息事件
-(void)rigthBtnAction:(id)sender{
    LXMessageViewController *vc = [[LXMessageViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(UITextField *)searchTextFiled{
    if (!_searchTextFiled) {
        _searchTextFiled = [WLTools allocTextFieldTextFont:ScaleW(14) placeHolderFont:ScaleW(14) text:nil placeText:@"请输入商品名称进行搜索" textColor:kMainTxtColor placeHolderTextColor:kGrayTxtColor frame:CGRectMake(ScaleW(12), ScaleW(10),ScaleW(260), ScaleW(27))];
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
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _faceHeaderView.height, ScreenWidth, ScreenHeight - Height_NavBar -Height_TabBar - _faceHeaderView.height) style:(UITableViewStyleGrouped)];
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
    MyXindeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MycomendsTableViewCell"];
    if (!cell) {
        cell = [[MyXindeTableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"MycomendsTableViewCell"];
  
    }
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BkFaceDetailViewController *vc = [[BkFaceDetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(240);
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

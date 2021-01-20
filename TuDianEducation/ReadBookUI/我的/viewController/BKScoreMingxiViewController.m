//
//  BKScoreMingxiViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/7.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "BKScoreMingxiViewController.h"

#import "BKScoreMingxiCell.h"


@interface BKScoreMingxiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic) NSInteger pageNum;
///0全部1收入2支出
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSMutableArray *btnArray;
@end
#define kViewTag(a) 100000 + a
@implementation BKScoreMingxiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.automaticallyAdjustsScrollViewInsets = YES;
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = kWhiteColor;
    self.title = @"积分明细";
    self.btnArray = [NSMutableArray array];
    UIButton *allBtn = [WLTools allocButtonTitle:@"全部" font:systemFont(ScaleW(14)) textColor:kSubTxtColor image:nil frame:CGRectMake(ScaleW(10), ScaleW(20), ScaleW(90), ScaleW(25)) sel:@selector(allBtnAction:) taget:self];
    allBtn.cornerRadius = allBtn.height/2.f;
    allBtn.backgroundColor = kSubBacColor;
    [allBtn setTitleColor:kGreenColor forState:(UIControlStateSelected)];
    [self.view addSubview:allBtn];
    [self.btnArray addObject:allBtn];
    UIButton *shouru = [WLTools allocButtonTitle:@"收入" font:systemFont(ScaleW(14)) textColor:kSubTxtColor image:nil frame:CGRectMake(ScaleW(44) + allBtn.right, ScaleW(20), ScaleW(90), ScaleW(25)) sel:@selector(shouruBtnAction:) taget:self];
    shouru.cornerRadius = shouru.height/2.f;
    shouru.backgroundColor = kSubBacColor;
    [shouru setTitleColor:kGreenColor forState:(UIControlStateSelected)];
    [self.view addSubview:shouru];
    [self.btnArray addObject:shouru];
    UIButton *zhichu = [WLTools allocButtonTitle:@"支出" font:systemFont(ScaleW(14)) textColor:kSubTxtColor image:nil frame:CGRectMake(ScaleW(43) + shouru.right, ScaleW(20), ScaleW(90), ScaleW(25)) sel:@selector(zhichuBtnAction:) taget:self];
    zhichu.cornerRadius = zhichu.height/2.f;
    zhichu.backgroundColor = kSubBacColor;
    [zhichu setTitleColor:kGreenColor forState:(UIControlStateSelected)];
    [self.view addSubview:zhichu];
    [self.btnArray addObject:zhichu];
    
    [allBtn sendActionsForControlEvents:(UIControlEventTouchUpInside)];
    
    [self addRightNavItemWithTitle:@"规则说明" color:kSubTxtColor font:systemFont(ScaleW(13))];
}
#pragma mark --规则说明
-(void)rigthBtnAction:(id)sender{
    
}
#pragma mark -----全部
-(void)allBtnAction:(UIButton *)sender
{
    for (UIButton *b in self.btnArray) {
        if (b== sender) {
            b.selected = YES;
        }else{
            b.selected = NO;
        }
    }
    self.type = @"0";
}
#pragma mark ---收入
-(void)shouruBtnAction:(UIButton *)sender
{
    for (UIButton *b in self.btnArray) {
        if (b== sender) {
            b.selected = YES;
        }else{
            b.selected = NO;
        }
    }
    self.type = @"1";
}
//zhichuBtnAction
#pragma mark ---支出
-(void)zhichuBtnAction:(UIButton *)sender
{
    for (UIButton *b in self.btnArray) {
        if (b== sender) {
            b.selected = YES;
        }else{
            b.selected = NO;
        }
    }
    self.type = @"2";
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
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, ScaleW(65), ScreenWidth, ScreenHeight - Height_NavBar - ScaleW(65)) style:(UITableViewStyleGrouped)];
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
    BKScoreMingxiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BKScoreMingxiCell"];
    if (!cell) {
        cell = [[BKScoreMingxiCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"BKScoreMingxiCell"];
  
    }
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(70);
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

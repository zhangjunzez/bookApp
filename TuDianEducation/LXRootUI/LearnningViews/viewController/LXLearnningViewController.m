//
//  LXLearnningViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/30.
//  Copyright © 2020 zhangbenchao. All rights reserved.

#import "LXLearnningViewController.h"
#import "MineStudyRecodsViewController.h"
#import "LXLearnningDetailViewController.h"
#import "PopoverViewController.h"

#import "LXMinePublishTableViewCell.h"
#import "LXLearnningHeaderView.h"

#import "LXLearnModel.h"

@interface LXLearnningViewController ()<UITableViewDelegate,UITableViewDataSource,UIPopoverPresentationControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong) LXLearnningHeaderView *headerView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic) NSInteger pageNum;

@property(nonatomic, strong)NSArray *tempArray;

@property(nonatomic, strong)UIButton *rightBtn;

@property (nonatomic,assign) NSInteger sort;
@end

@implementation LXLearnningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"学习天地";
   // [self addRightNavgationItemWithImage:[UIImage imageNamed:@"xuexi_xiangxia"]];
    [self naviSettings];
    ///默认时间排序
    _sort = 0;
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = kMainBgColor;
    
    

}
-(void)naviSettings{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //[button setTitle:@"更多" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"xuexi_xiangxia"] forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = kNavFont;
    button.frame = CGRectMake(0, 0, 85, 40);
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [button addTarget:self action:@selector(rigthBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.rightBtn = button;
}
-(void)rigthBtnAction:(id)sender{

    
    PopoverViewController *vc = [self getPopVC];
    WS(weakSelf);
    vc.popActionBlock = ^(NSInteger index) {
        if (index == 0) {
            ///时间排序
            
        }else if (index == 1){
            ///热度排序
      
        }
        weakSelf.sort = index;
    };
    [self presentViewController:vc animated:YES completion:nil];
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
-(LXLearnningHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[LXLearnningHeaderView alloc ]init];
        WS(weakSelf);
        _headerView.searchBlock = ^{
            [weakSelf.tableView.mj_header beginRefreshing];
        };
    }
    return _headerView;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, ScaleW(5) + self.headerView.height, ScreenWidth, ScreenHeight -  Height_NavBar -  ScaleW(5) - self.headerView.height) style:(UITableViewStyleGrouped)];
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
- (PopoverViewController *)getPopVC{
    
    PopoverViewController *popContentVC = [PopoverViewController new];
    popContentVC.preferredContentSize = CGSizeMake(140, 88);
    popContentVC.modalPresentationStyle = UIModalPresentationPopover;
    popContentVC.popType = MorePopTypeLearn;
    UIPopoverPresentationController *popController = [popContentVC popoverPresentationController];
    popController.backgroundColor = [UIColor whiteColor];
    popController.delegate = self;
    popController.sourceView = self.rightBtn;
    popController.sourceRect = CGRectMake(20, 0, self.rightBtn.width , self.rightBtn.height);
    return popContentVC;
}
//popview 代理
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LXMinePublishTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LXMinePublishTableViewCell"];
    if (!cell) {
        cell = [[LXMinePublishTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"LXMinePublishTableViewCell"];
    }
    cell.model = self.dataArray[indexPath.row];
    cell.statusImg.hidden = YES;
    cell.pointBtn.hidden = YES;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!kLogin) {
        [self presentLoginAction];
        return;
    }
    LXLearnningDetailViewController*vc = [[LXLearnningDetailViewController alloc]init];
    vc.edtingType = LearnningEdtingTypeNone;
    vc.model = self.dataArray[indexPath.row];
    
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
    return ScaleW(90);
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
    NSDictionary *pams = @{};
    if (_headerView.searchTf.text.length) {
        pams = @{@"sort":[NSString stringWithFormat:@"%ld",_sort],@"content":_headerView.searchTf.text,@"nowPage":[NSString stringWithFormat:@"%ld",self.pageNum],@"pageCount":[NSString stringWithFormat:@"%d",kPage_Size]};
    }else{
        pams = @{@"sort":[NSString stringWithFormat:@"%ld",_sort],@"nowPage":[NSString stringWithFormat:@"%ld",self.pageNum],@"pageCount":[NSString stringWithFormat:@"%d",kPage_Size]};
    }
  
    [NetWorkTools postConJSONWithUrl:kGetSkillListUrl parameters:pams success:^(id responseObject) {
         NSString *result = responseObject[@"result"];
               NSString *resultNote = responseObject[@"resultNote"];
               NSArray *array = responseObject[@"dataList"];
               NSMutableArray *muArray = [NSMutableArray array];
               if (result.integerValue == 0) {
                   for (NSDictionary *dic  in array) {
                       LXLearnModel *model = [[LXLearnModel alloc]init];
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
    
    [SSKJ_NoDataView showNoData:self.dataArray.count toView:self.tableView offY:ScaleW(10) message:@"没有数据哦~" imge:[UIImage imageNamed:@"nolikesimg"]];
    
    self.pageNum++;
    
    [self endRefrash];
    
    [self.tableView reloadData];
    
}
-(void)setSort:(NSInteger)sort{
    _sort = sort;
    [self.tableView.mj_header beginRefreshing];
}
@end

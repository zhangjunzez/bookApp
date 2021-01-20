//
//  LXMinePublishViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/28.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//



#import "LXMinePublishViewController.h"
#import "MineStudyRecodsViewController.h"
#import "LXLearnningDetailViewController.h"
#import "PopoverViewController.h"
#import "LXEdtingLearnningViewController.h"

#import "LXMinePublishTableViewCell.h"
//#import "TeacherShowModel.h"
#import "LXTuijianControlView.h"
#import "LXMySkillModel.h"

@interface LXMinePublishViewController ()<UITableViewDelegate,UITableViewDataSource,UIPopoverPresentationControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic) NSInteger pageNum;

@property(nonatomic, strong)NSArray *tempArray;
@end

@implementation LXMinePublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我发布的";
  //  [self addRightNavItemWithTitle:@"学习记录" color:kSubTxtColor font:systemFont(ScaleW(16))];
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = kMainBgColor;
    
    [self headerRefresh];

}
-(void)rigthBtnAction:(id)sender{
    MineStudyRecodsViewController *vc = [[MineStudyRecodsViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, ScaleW(5), ScreenWidth, ScreenHeight -  Height_NavBar -  ScaleW(5)) style:(UITableViewStyleGrouped)];
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
    LXMinePublishTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LXMinePublishTableViewCell"];
    if (!cell) {
        cell = [[LXMinePublishTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"LXMinePublishTableViewCell"];
    }
    
    WS(weakSelf);
    LXMySkillModel *model =  self.dataArray[indexPath.row];
    cell.pointsBlock = ^{
        
           PopoverViewController *vc = [self getPopVcWithIndex:indexPath];
           vc.popActionBlock = ^(NSInteger index) {
               if (index == 0) {
                   MineStudyRecodsViewController *vc = [[MineStudyRecodsViewController alloc]init];
                   vc.skillId = model.skillsid;
                [weakSelf.navigationController pushViewController:vc animated:YES];
               }else{
                   if (index == 1) {
                        LXEdtingLearnningViewController *vc = [[LXEdtingLearnningViewController alloc]init];
                          vc.model = model;
                          [weakSelf.navigationController pushViewController:vc animated:YES];
                   }
                   if (index == 2) {
                       [weakSelf deleteSkillWithSkillId:model.skillsid];
                   }
                   
               }
              
           };
           [weakSelf presentViewController:vc animated:YES completion:nil];
    };
    cell.skillModel = model;
    return cell;
}

-(void)deleteSkillWithSkillId:(NSString *)skillId{
    //kDeleteskillsUrl
    NSDictionary *pamas = @{@"skillsid":skillId};
    [NetWorkTools postConJSONWithUrl:kDeleteskillsUrl parameters:pamas success:^(id responseObject) {
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 LXLearnningDetailViewController*vc = [[LXLearnningDetailViewController alloc]init];
 vc.edtingType = LearnningEdtingTypeEdting;
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
   
    NSDictionary *pamas = @{@"nowPage":[NSString stringWithFormat:@"%ld",self.pageNum],@"pageCount":[NSString stringWithFormat:@"%d",kPage_Size]};
    
    [NetWorkTools postConJSONWithUrl:kGetmyskillslist parameters:pamas success:^(id responseObject) {
        NSString *result = responseObject[@"result"];
        NSString *resultNote = responseObject[@"resultNote"];
        NSArray *array = responseObject[@"dataList"];
        NSMutableArray *muArray = [NSMutableArray array];
        if (result.integerValue == 0) {
            for (NSDictionary *dic  in array) {
                LXMySkillModel *model = [[LXMySkillModel alloc]init];
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

#pragma mark -PopView

- (PopoverViewController *)getPopVcWithIndex:(NSIndexPath *) indexPath{
    LXMinePublishTableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
    
    PopoverViewController *popContentVC = [PopoverViewController new];
    popContentVC.preferredContentSize = CGSizeMake(140, 132);
    popContentVC.modalPresentationStyle = UIModalPresentationPopover;
    popContentVC.popType = MorePopTypeLearnList;
    UIPopoverPresentationController *popController = [popContentVC popoverPresentationController];
    popController.backgroundColor = [UIColor whiteColor];
    popController.delegate = self;
    popController.sourceView = cell.pointBtn;
    popController.sourceRect = CGRectMake(20, 0, ScaleW(100) ,44);
    return popContentVC;
}
//popview 代理
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}
@end

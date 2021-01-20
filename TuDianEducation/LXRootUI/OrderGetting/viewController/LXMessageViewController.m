//
//  LXMessageViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/30.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXMessageViewController.h"
#import "LXMessageTableViewCell.h"
#import "LXMessageModel.h"

#import "SSKJ_H5Web_ViewController.h"
#import "LXRequstDetailViewController.h"

@interface LXMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger pageNum;

@property(nonatomic, strong)UIButton *rightBtn;

@end

@implementation LXMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息中心";
    [self.view addSubview:self.tableView];
    

    [self addRightNavItemWithTitle:@"清空" color:kMainTxtColor font:systemFont(14)];
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self headerRefresh];
}


-(void)rigthBtnAction:(id)sender{
    //[self readWith:nil];
    [self removeAllmessage];
}


-(UITableView *)tableView{
    if (!_tableView) {
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_TabBar) style:(UITableViewStyleGrouped)];
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
    LXMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeMessageTableViewCell"];
    if (!cell) {
        cell = [[LXMessageTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"HomeMessageTableViewCell"];
    }
//    LXMessageModel *model = self.dataArray[indexPath.row];
//    cell.model = model;
//    TDMessageModel *model = self.dataArray[indexPath.row];
//    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LXMessageModel *model = self.dataArray[indexPath.row];
    //"type":""//消息类型 0系统消息 1订单消息2认证消息
    switch (model.type.integerValue) {
        case 0:
        {
            
            SSKJ_H5Web_ViewController *vc = [[SSKJ_H5Web_ViewController alloc]init];
            vc.url = model.url;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            
            LXRequstDetailViewController *vc = [[LXRequstDetailViewController alloc]init];
            vc.ordernum = model.objid;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            
            
        }
            break;
            
        default:
            break;
    }
   
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(82) + 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]initWithFrame:CGRectZero];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [[UIView alloc]initWithFrame:CGRectZero];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return CGFLOAT_MIN;
}
 // 自定义左滑显示编辑按钮
//-(NSArray<UITableViewRowAction*>*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewRowAction *rowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//
//        [self deleteWith:indexPath.row];
//        //       [weakSelf.dataArray removeObjectAtIndex:indexPath.row];
//        //       [weakSelf.tableView reloadData];
//    }];
//
//    rowAction.backgroundColor = kBlueColor;
//
//    NSArray *arr = @[rowAction];
//    return arr;
//}

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

#pragma mark - 数据请求
///列表请求
-(void)collectListReq
{
    NSDictionary * pamas = @{@"nowPage":[NSString stringWithFormat:@"%ld",self.pageNum],@"pageCount":[NSString stringWithFormat:@"%d",kPage_Size]};
    [NetWorkTools postConJSONWithUrl:kEngineernoticeslist parameters:pamas success:^(id responseObject) {
        NSString *result = responseObject[@"result"];
        NSString *resultNote = responseObject[@"resultNote"];
        NSArray *array = responseObject[@"dataList"];
        NSMutableArray *muArray = [NSMutableArray array];
        if (result.integerValue == 0) {
            for (NSDictionary *dic  in array) {
                LXMessageModel *model = [[LXMessageModel alloc]init];
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

///清空消息列表
-(void)removeAllmessage{
    //kEngineerdeletenotices
    NSDictionary * pamas = @{};
    [NetWorkTools postConJSONWithUrl:kEngineerdeletenotices parameters:pamas success:^(id responseObject) {
        //NSString *result = responseObject[@"result"];
        NSString *resultNote = responseObject[@"resultNote"];
      
        [MBProgressHUD showError:resultNote];
        [self.tableView.mj_header beginRefreshing];
    } fail:^(NSError *error) {
        
    }];
}

///删除
-(void)deleteWith:(NSInteger)index
{

}

//已读
-(void)readWith:(NSIndexPath *)index
{
//    if (!self.dataArray.count) {
//        return;
//    }
//
//    NSString *type;//0读取单个消息，1全部读取
//    NSString *mid;
//    if (index) {
//        type = @"0";
//
//        TDMessageModel *model = self.dataArray[index.row];
//        mid = model.id;
////        mid = [NSString stringWithFormat:@"%@", model.id];
//    }else{
//        type = @"1";
//        mid = @"";
//    }
//
//    ////index?NO:YES
//    [DYHttpHepler MessageReadRequstByHpara:nil para:@{@"token":kToken,@"mid":mid, @"type":type} showMsg:NO enableView:index?nil:self.view data:^(long code, id  _Nullable result) {
//        if (index) {
//            TDMessageModel *model = self.dataArray[index.row];
//            model.isRead = 1;
//            [self.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:(UITableViewRowAnimationNone)];
//
//        }else{
//            for (TDMessageModel *model in self.dataArray) {
//                model.isRead = 1;
//            }
//            [self.tableView reloadData];
//        }
//
//       } error:^(long code, id  _Nullable result) {
//        [self endRefrash];
//       }];
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
-(void)handleListWithModel:(id )result
{
    [self endRefrash];

    NSArray *array = result;
    if (self.pageNum == 1) {
        [self.dataArray removeAllObjects];
    }
    
    [self.dataArray addObjectsFromArray:array];
    
    self.rightBtn.hidden = !self.dataArray.count;
    
    [SSKJ_NoDataView showNoData:self.dataArray.count toView:self.tableView offY:0 message:@"暂无消息" imge:[UIImage imageNamed:@"nolikesimg"]];
    
    self.pageNum++;
    
    
    [self.tableView reloadData];
    
    if (array.count != kPage_Size) {
        self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{

        self.tableView.mj_footer.state = MJRefreshStateIdle;
    }
}


-(NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end

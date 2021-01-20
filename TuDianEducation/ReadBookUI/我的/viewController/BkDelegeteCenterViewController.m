//
//  BkDelegeteCenterViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/11.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "BkDelegeteCenterViewController.h"
#import "LXSettingCell.h"
#import "SSKJ_H5Web_ViewController.h"


@interface BkDelegeteCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic) NSInteger pageNum;

@property(nonatomic, strong)NSArray *tempArray;

@end

@implementation BkDelegeteCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"协议中心";
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self.view addSubview:self.tableView];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[@"《用户注册协议》",@"《用户注册协议》",@"《用户注册协议》"].mutableCopy;
    }
    return _dataArray;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight -  Height_NavBar) style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = self.footerView;
        _tableView.backgroundColor = kWhiteColor;
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
    LXSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LXSettingCell"];
    if (!cell) {
        cell = [[LXSettingCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"LXSettingCell"];
    }
    cell.subNameLabel.hidden = YES;
    cell.gotoImg.hidden = NO;
    cell.swithUnknow.hidden = YES;
   
    cell.nameLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  
        NSString *url = [NSString stringWithFormat:@"%@%@",kBaseRequstUrl,@"/display/agreement?id=7"];
        [self gotoWebWithUrl:url title:@"关于我们"];
   
}
-(void)gotoWebWithUrl:(NSString *)url title:(NSString *)title{
    SSKJ_H5Web_ViewController *vc = [[SSKJ_H5Web_ViewController alloc]init];
    vc.url = url;
    vc.title = title;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(50);
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


-(void)userInforRequstAction{
    [NetWorkTools postConJSONWithUrl:kUserInforUrl parameters:@{} success:^(id responseObject) {
        NSString *result = responseObject[@"result"];
        NSString *resultNote = responseObject[@"resultNote"];
        NSDictionary *data = responseObject[@"dataobject"];
        if ([result integerValue] == 0) {
//            LXUserInforModel *model = [[LXUserInforModel alloc]init];
//            [model setValuesForKeysWithDictionary:data];
//            [LXSaveUserInforTool sharedUserTool].userInforModel = model;
            [self.tableView reloadData];
        }else{
             [MBProgressHUD showError:resultNote];
        }

    } fail:^(NSError *error) {

    }];
   
}
@end

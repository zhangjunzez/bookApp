//
//  BkAuthorDetailViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/14.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "BkAuthorDetailViewController.h"
#import "BkAuthorDetailHeader.h"
@interface BkAuthorDetailViewController ()
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) BkAuthorDetailHeader *headerView;
@end

@implementation BkAuthorDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.title = @"作者详情";
    
}
-(BkAuthorDetailHeader *)headerView{
    if (!_headerView) {
        _headerView = [[BkAuthorDetailHeader alloc]init];
    }
    return _headerView;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar) style:(UITableViewStyleGrouped)];
      
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
        
    }
    return _tableView;
}

@end

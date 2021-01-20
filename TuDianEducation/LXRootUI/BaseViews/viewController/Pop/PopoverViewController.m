//
//  PopoverViewController.m
//  JYYunSystem
//
//  Created by zpz on 2019/8/3.
//  Copyright © 2019 zpz. All rights reserved.
//

#import "PopoverViewController.h"

static NSString * PopCellID = @"PopCellID";

@interface PopoverViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation PopoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableView];
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
//        [_tableView setSeparatorColor:PZColor(@"eeeeee")];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:PopCellID];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.left.bottom.equalTo(@0);
        }];
        
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.popType == MorePopTypeTask) return 3;
    if (self.popType == MorePopTypeLearn) return 2;
    if (self.popType == MorePopTypeLearnList) return 3;
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PopCellID forIndexPath:indexPath];
    cell.textLabel.x = 15;
//    cell.textLabel.textColor = PZColor(@"333333");
    if (self.popType == MorePopTypeTask) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"删除";
                break;
            case 1:
                cell.textLabel.text = @"编辑";
                break;
            case 2:
            cell.textLabel.text = @"分享";
            break;
                
            default:
                break;
        }
    }else if(self.popType == MorePopTypeLearn){
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"时间排序";
                break;
            case 1:
                cell.textLabel.text = @"热度排序";
                break;
                
            default:
                break;
        }
    }else if(self.popType == MorePopTypeLearnList){
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"学习记录";
                break;
            case 1:
                cell.textLabel.text = @"编辑";
                break;
            case 2:
                cell.textLabel.text = @"删除";
                break;
            default:
                break;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
    if (self.popActionBlock) {
        self.popActionBlock(indexPath.row);
    }
}
@end

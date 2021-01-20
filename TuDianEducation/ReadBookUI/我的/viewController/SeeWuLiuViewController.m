//
//  SeeWuLiuViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/9.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "SeeWuLiuViewController.h"
#import "WuliuListTableViewCell.h"
@interface SeeWuLiuViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UILabel *wuliuNameLabel;
@property (nonatomic,strong) UILabel *wuliuNumLabel;
@property (nonatomic,strong) UIButton *copBtn;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation SeeWuLiuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查看物流";
    self.view.backgroundColor = kSubBacColor;
    [self.view addSubview:self.wuliuNameLabel];
    [self.view addSubview:self.wuliuNumLabel];
    [self.view addSubview:self.tableView];
    
}
-(UILabel *)wuliuNameLabel{
    if (!_wuliuNameLabel) {
        _wuliuNameLabel = [WLTools allocLabel:@"物流类型  邦德物流" font:systemFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(12), ScaleW(12), ScreenWidth - ScaleW(24), ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
        NSString *string = _wuliuNameLabel.text;
        NSMutableAttributedString *atts = [[NSMutableAttributedString alloc] initWithString:string];
        [atts setAttributes:@{NSForegroundColorAttributeName:kGreenColor} range:NSMakeRange(5, string.length - 5)];
        _wuliuNameLabel.attributedText = atts;
    }
    return _wuliuNameLabel;
}
-(UILabel *)wuliuNumLabel{
    if (!_wuliuNumLabel) {
        _wuliuNumLabel = [WLTools allocLabel:@"物流单号  13243243243" font:systemFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(12), ScaleW(12) + _wuliuNameLabel.bottom, ScreenWidth - ScaleW(24), ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
        _copBtn = [WLTools allocButtonTitle:@"复制" font:systemFont(ScaleW(10)) textColor:kSubTxtColor image:nil frame:CGRectMake(ScaleW(180), _wuliuNumLabel.top, ScaleW(32), ScaleW(15)) sel:@selector(copNumAction:) taget:self];
        _copBtn.backgroundColor = UIColorFromRGB(0xE8E6E7);
        _copBtn.cornerRadius = _copBtn.height/2.f;
        [self.view addSubview:_copBtn];
    }
    return _wuliuNumLabel;
}
-(void)copNumAction:(UIButton *)sender
{
    
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(ScaleW(11), ScaleW(80), ScreenWidth - ScaleW(22), ScreenHeight -  Height_TabBar - ScaleW(150)) style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kWhiteColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.cornerRadius = ScaleW(10);

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

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithArray:@[@"",@"",@"",@"",@"",@"",@""]];
    }
    return _dataArray;
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WuliuListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WuliuListTableViewCell"];
    if (!cell) {
        cell = [[WuliuListTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"WuliuListTableViewCell"];
        
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
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(44))];

    return view;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return ScaleW(44);
}
@end

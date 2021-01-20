//
//  LXSignActionViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/28.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXSignActionViewController.h"
#import "LXSignRullsViewController.h"

#import "CalendarCollection.h"
#import "CalendarHelper.h"

@interface LXSignActionViewController ()
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIImageView *bigImgView;
@property (nonatomic,strong) UIImageView *subImgView;
@property (nonatomic,strong) UIButton *commitBtn;
@property (nonatomic,strong) UILabel *headerMsgLabel;
@property (nonatomic,strong) UILabel *signDaysLabel;
@property (nonatomic, strong) CalendarCollection *calendarView;
@property (nonatomic,strong) NSArray *calendarArray;

///当前签到天数
@property (nonatomic,strong) NSString *datastr;
///0未签到1已签到
@property (nonatomic,strong) NSString *daystate;
///签到的天
@property (nonatomic,strong) NSArray *dataList;

@end

@implementation LXSignActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"每日签到";
    self.calendarArray = [CalendarHelper createMonthDataWith:0];
    [self addRightNavItemWithTitle:@"签到规则" color:kMainTxtColor font:systemFont(ScaleW(16))];
    [self.view addSubview:self.scrollView];
    [self requstAlreadySignDays];
    [self requstBigImgeRqust];
 
}

-(void)rigthBtnAction:(id)sender
{
    LXSignRullsViewController *vc = [[LXSignRullsViewController alloc]init];
    [self preasntVc:vc];
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar)];
        _scrollView.backgroundColor = kMainBgColor;
        [_scrollView addSubview:self.bigImgView];
        [_scrollView addSubview:self.subImgView];
        [_scrollView addSubview:self.commitBtn];
        [_scrollView addSubview:self.calendarView];
        [_scrollView addSubview:self.headerMsgLabel];
        [_scrollView addSubview:self.signDaysLabel];
        if (ScreenHeight -Height_NavBar < self.bigImgView.bottom + ScaleW(60)) {
            self.scrollView.contentSize = CGSizeMake(0, self.bigImgView.bottom + ScaleW(60));
        }else{
            self.scrollView.contentSize = CGSizeMake(0, ScreenHeight - Height_NavBar);
        }
        
    }
    return _scrollView;
}
-(UIImageView *)bigImgView
{
    if (!_bigImgView) {
        UIImage *img = [UIImage imageNamed:@"qiandao_bg"];
        _bigImgView = [[UIImageView alloc]initWithImage:img];
        _bigImgView.frame = CGRectMake(0, 0, ScreenWidth, (img.size.height/img.size.width)*ScreenWidth);
        
    }
    return _bigImgView;
}
-(UIImageView *)subImgView
{
    if (!_subImgView) {
        UIImage *img = [UIImage imageNamed:@"qiandao_bg2"];
        _subImgView = [[UIImageView alloc]initWithImage:img];
        _subImgView.frame = CGRectMake(ScaleW(10), ScaleW(175), ScaleW(355), (img.size.height/img.size.width) *ScaleW(355));
    }
    return _subImgView;
}
-(UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [WLTools allocButtonTitle:@"立即签到" font:systemBoldFont(17) textColor:kWhiteColor image:nil frame:CGRectMake(ScaleW(78), ScaleW(540), ScaleW(216), ScaleW(50)) sel:@selector(commitAction:) taget:self];
        _commitBtn.backgroundColor = kBlueColor;
        [_commitBtn setCornerRadius:_commitBtn.height/2.f];
    }
    return _commitBtn;
}
-(CalendarCollection *)calendarView{
    if (!_calendarView) {
        _calendarView = [[CalendarCollection alloc]initWithFrame:CGRectMake(ScaleW(21), ScaleW(245),ScaleW(332) , ScaleW(256)) bacColor:[UIColor clearColor] textColor:kWhiteColor];
        _calendarView.array = self.calendarArray;
        [_calendarView setCornerRadius:ScaleW(15)];
        _calendarView.selectBlock = ^(CalendarModel * _Nonnull model) {
            
        };
    }
    return _calendarView;
}
-(UILabel *)headerMsgLabel{
    if (!_headerMsgLabel) {
        _headerMsgLabel = [WLTools allocLabel:@"连续签到15天可获得1000积分" font:systemFont(ScaleW(20)) textColor:kWhiteColor frame:CGRectMake(0, ScaleW(109), ScreenWidth, ScaleW(20)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _headerMsgLabel;
}
-(UILabel *)signDaysLabel{
    if(!_signDaysLabel){
        _signDaysLabel = [WLTools allocLabel:@"已连续签到0天" font:systemFont(ScaleW(17)) textColor:kBlueColor frame:CGRectMake(0, ScaleW(188), ScreenWidth, ScaleW(17)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _signDaysLabel;
}
-(void)commitAction:(UIButton *)sender{
    [self requstSignActionDays];
}
-(void)preasntVc:(UIViewController *)vc
{
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
     [self.navigationController presentViewController:vc animated:YES completion:^{
         //
         vc.view.superview.backgroundColor = [UIColor clearColor];
     }];
}
#pragma mark ---获取封面图片
-(void)requstBigImgeRqust{
    [NetWorkTools postConJSONWithUrl:kGetimagesUrl parameters:@{@"type":@"5"} success:^(id responseObject) {
        NSString *result = responseObject[@"result"];
        NSString *resultNote = responseObject[@"resultNote"];
        NSString *datastr = responseObject[@"datastr"];
        if ([result integerValue] == 0) {
            [self.bigImgView sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:datastr]]];
        }else{
            [MBProgressHUD showError:resultNote];
        }
    } fail:^(NSError *error) {
        
    }];
}
#pragma mark -获取已经签到的天数

-(void)requstAlreadySignDays{
   NSString *times = [WLTools getdateStringFromTimetal:[[NSDate date] timeIntervalSince1970] dateFomate:@"yyyy-MM"];
    NSDictionary *pamas = @{@"times":times};
       [NetWorkTools postConJSONWithUrl:kGetclockinmonthUrl parameters:pamas success:^(id responseObject) {
           NSString *result = responseObject[@"result"];
           NSString *resultNote = responseObject[@"resultNote"];
           self.datastr = responseObject[@"datastr"];
           self.daystate = responseObject[@"daystate"];
           self.dataList = responseObject[@"dataList"];
           if (result.integerValue == 0) {
               
               
           }else{
               [MBProgressHUD showError:resultNote];
           }
           
       } fail:^(NSError *error) {
           
       }];
}
-(void)requstSignActionDays{
   NSString *times = [WLTools getdateStringFromTimetal:[[NSDate date] timeIntervalSince1970] dateFomate:@"yyyy-MM"];
    NSDictionary *pamas = @{@"times":times};
       [NetWorkTools postConJSONWithUrl:kAddclockUrl parameters:pamas success:^(id responseObject) {
           NSString *result = responseObject[@"result"];
           NSString *resultNote = responseObject[@"resultNote"];
           
           if (result.integerValue == 0) {
               [self requstAlreadySignDays];
           }else{
              
           }
            [MBProgressHUD showError:resultNote];
       } fail:^(NSError *error) {
           
       }];
}
-(void)setDatastr:(NSString *)datastr{
    _datastr = datastr;
    _signDaysLabel.text = [NSString stringWithFormat:@"已连续签到%@天",_datastr];
}
-(void)setDaystate:(NSString *)daystate{
    _daystate = daystate;
    if (_daystate.integerValue == 0) {
        [self.commitBtn setTitle:@"立即签到" forState:(UIControlStateNormal)];
    }else{
        [self.commitBtn setTitle:@"已签到" forState:(UIControlStateNormal)];
    }
}
-(void)setDataList:(NSArray *)dataList{
    _dataList = dataList;
    self.calendarView.selectArray = _dataList;
}
@end

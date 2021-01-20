
#import "LXSettingViewController.h"
#import "ModifyPwdViewController.h"
#import "LXMailBackViewController.h"
#import "LXSettingPayViewController.h"
#import "LXEdtingPayViewController.h"
#import "BkDelegeteCenterViewController.h"

#import "LXSettingCell.h"
//#import "TeacherShowModel.h"
#import "LXTuiJianHeaderView.h"
#import "Mine_Version_AlertView.h"
#import "LXUserInforModel.h"
#import "LXSaveUserInforTool.h"
#import "AppDelegate.h"

@interface LXSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic) NSInteger pageNum;

@property(nonatomic, strong)NSArray *tempArray;
@property (nonatomic,strong) LXTuiJianHeaderView *headerView;
@end

@implementation LXSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";
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
        _dataArray = @[@"修改密码",@"意见反馈",@"协议中心",@"清除缓存",@"注销账号"].mutableCopy;
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
-(UIView *)footerView{
    if (!_footerView) {
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(145))];
       // NSString *versionString = [NSString stringWithFormat:@"版本：V%@",kAppVersion];
        //UILabel *versionLabel = [WLTools allocLabel:versionString font:systemFont(ScaleW(14)) textColor:kGrayTxtColor frame:CGRectMake(0, ScaleW(72), ScreenWidth, ScaleW(14)) textAlignment:(NSTextAlignmentCenter)];
       // [_footerView addSubview:versionLabel];
        UIButton *quitBtn = [WLTools allocButtonTitle:@"退出登录" font:systemBoldFont(ScaleW(16)) textColor:kRedColor image:nil frame:CGRectMake(ScaleW(11), ScaleW(80), ScaleW(353), ScaleW(35)) sel:@selector(quitOutLoginAction:) taget:self];
        //[quitBtn setBorderWithWidth:1 andColor:kMainLineColor];
        [quitBtn setCornerRadius:quitBtn.height/2.f];
        [_footerView addSubview:quitBtn];
        quitBtn.backgroundColor = kSubBacColor;
        _footerView.backgroundColor = kWhiteColor;
        
    }
    return _footerView;
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
    if (indexPath.row == 3) {
        cell.subNameLabel.hidden = NO;
        cell.subNameLabel.text = @"0.0M";
    }
    cell.nameLabel.text = self.dataArray[indexPath.row];
    [self setValueToCell:cell];
    return cell;
}
-(void)setValueToCell:(LXSettingCell *)cell{
  
    
    if ([cell.nameLabel.text isEqualToString:@"清除缓存"]) {
        ///@[@"清除本地缓存",@"消息免打扰",@"检查更新",@"登录密码修改",@"支付密码设置",@"支付密码修改",@"意见反馈",@"关于我们"]
          //获取缓存图片的大小(字节)
          NSUInteger bytesCache = [[SDImageCache sharedImageCache] totalDiskSize];
          //换算成 MB (注意iOS中的字节之间的换算是1000不是1024)
          float MBCache = bytesCache/1000.f/1000.f;
          //异步清除图片缓存 （磁盘中的）
          cell.subNameLabel.text = [NSString stringWithFormat:@"%.2fM",MBCache];
          ///是否设置支付密码 0未设置 1已设置
    }
    
    

    
}
-(void)alertViewShow{
    //获取缓存图片的大小(字节)
//       NSUInteger bytesCache = [[SDImageCache sharedImageCache] totalDiskSize];
//       //换算成 MB (注意iOS中的字节之间的换算是1000不是1024)
//    float MBCache = bytesCache/1000.f/1000.f;
       //异步清除图片缓存 （磁盘中的）
    WS(weakSelf);
       NSString *alertMessage = [NSString stringWithFormat:@"清除全部本地缓存么？"];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"清除本地缓存" message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
       UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                 [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                     dispatch_async(dispatch_get_main_queue(), ^{
                         [weakSelf.tableView reloadData];
                     });
                 }];
          }];
      [alert addAction:action1];
      UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
      }];
      [alert addAction:action2];
      [self  presentViewController:alert animated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *string = self.dataArray[indexPath.row];
    if ([string isEqualToString:@"修改密码"]) {
        ModifyPwdViewController *vc = [[ModifyPwdViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([string isEqualToString:@"支付密码设置"]) {
        LXSettingPayViewController *vc = [[LXSettingPayViewController alloc]init];
         WS(weakSelf);
         vc.gobackBlcok = ^{
             [weakSelf userInforRequstAction];
         };
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    if ([string isEqualToString:@"意见反馈"]) {
       LXMailBackViewController *vc = [[LXMailBackViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([string isEqualToString:@"清除缓存"]) {
        [self alertViewShow];
    }
    
    if ([string isEqualToString:@"协议中心"]) {
        NSString *url = [NSString stringWithFormat:@"%@%@",kBaseRequstUrl,@"/display/agreement?id=7"];
        [self gotoWebWithUrl:url title:@"关于我们"];
    }
}
-(void)gotoWebWithUrl:(NSString *)url title:(NSString *)title{
    BkDelegeteCenterViewController *vc = [[BkDelegeteCenterViewController alloc]init];
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

-(void)quitOutLoginAction:(UIButton *)sender
{
    NSString *loginString = kToken;
    if (loginString.length) {
        WS(weakSelf);
        [NetWorkTools postConJSONWithUrl:kUserQuiteOutLoginUrl parameters:@{} success:^(id responseObject) {
               NSString *result = responseObject[@"result"];
               NSString *resultNote = responseObject[@"resultNote"];
               if ([result integerValue] == 0) {
                   [weakSelf loginOutAction];
               }
               [MBProgressHUD showError:resultNote];
           } fail:^(NSError *error) {
               [weakSelf loginOutAction];
           }];
    }else{
         [self loginOutAction];
    }
   
}
-(void)updateVersionRequst{
    [NetWorkTools  postConJSONWithUrl:kVersionUpdateUrl parameters:@{@"type":@"2"} success:^(id responseObject) {
        NSString *result = responseObject[@"result"];
                  NSString *resultNote = responseObject[@"resultNote"];
                  NSDictionary *dataobject = responseObject[@"dataobject"];
                  if ([result integerValue] == 0) {
                      Mine_Version_Model *model = [[Mine_Version_Model alloc]init];
                      [model setValuesForKeysWithDictionary:dataobject];
                     if ([model.num compare:kAppVersion] == kCFCompareLessThan || [model.num isEqualToString:kAppVersion]) {
                         [MBProgressHUD showError:@"已经是最新版本"];
                         return ;
                     }else{
                         [self showVersionUpdateViewWithModel:model];

                     }
                      
                  }else{
                      [MBProgressHUD showError:resultNote];
                  }
    } fail:^(NSError *error) {
        
    }];
}
#pragma mark ---显示版本更新
-(void)showVersionUpdateViewWithModel:(Mine_Version_Model *)model{
    WS(weakSelf);
       [Mine_Version_AlertView showWithModel:model confirmBlock:^{
           [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.apkurl]];
       } cancleBlock:^{
           [weakSelf exitApplication];
       }];
}
- (void)exitApplication {
    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    UIWindow *window = app.window;
    
    [UIView animateWithDuration:1.0f animations:^{
        window.alpha = 0;
        window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
    } completion:^(BOOL finished) {
        exit(0);
    }];
    //exit(0);
    
}
-(void)userInforRequstAction{
    [NetWorkTools postConJSONWithUrl:kUserInforUrl parameters:@{} success:^(id responseObject) {
        NSString *result = responseObject[@"result"];
        NSString *resultNote = responseObject[@"resultNote"];
        NSDictionary *data = responseObject[@"dataobject"];
        if ([result integerValue] == 0) {
            LXUserInforModel *model = [[LXUserInforModel alloc]init];
            [model setValuesForKeysWithDictionary:data];
            [LXSaveUserInforTool sharedUserTool].userInforModel = model;
            [self.tableView reloadData];
        }else{
             [MBProgressHUD showError:resultNote];
        }

    } fail:^(NSError *error) {

    }];
   
}
@end

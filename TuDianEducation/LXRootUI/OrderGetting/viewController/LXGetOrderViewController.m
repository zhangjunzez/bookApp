//
//  LXGetOrderViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/30.
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"
#import "LXGetOrderViewController.h"
#import "LXRequstDetailViewController.h"
#import "LXGetOrderFailedNOIdViewController.h"
#import "LXMessageViewController.h"
#import "LXPublishAlertViewController.h"
#import "GYZChooseCityController.h"
#import "LXAskToLocationViewController.h"
#import "LXGetOrderHeaderView.h"
#import "LXGetOrderTableViewCell.h"
#import "Mine_Version_AlertView.h"

#import "UIImage+Extension.h"

#import "LXRunLoopModel.h"
#import "LXGetOrderListModel.h"
#import "GDAddressLocationHelper.h"
#import "LXSaveUserInforTool.h"

@interface LXGetOrderViewController ()<UITableViewDelegate,UITableViewDataSource,GYZChooseCityDelegate,CLLocationManagerDelegate>{
    NSString *city;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic) NSInteger pageNum;

@property(nonatomic, strong)NSArray *tempArray;
@property (nonatomic,strong) LXGetOrderHeaderView *headerLoopView;
@property (nonatomic,strong) UIButton *leftNaviView;
@property (nonatomic,strong) UIButton *rightView;
@property (nonatomic,strong) UILabel *redPointLabel;

@property (nonatomic,strong) UIButton *pulishBtn;
@property (nonatomic,strong) UIButton *biggerPulishBtn;

@property (nonatomic,strong) NSString *longitude;

@property (nonatomic,strong) NSString *latitude;
//位置管理者
@property(nonatomic,strong) CLLocationManager *mgr;
@property (nonatomic,assign) BOOL canUpdate;
@end

@implementation LXGetOrderViewController

- (void)setAnimation
{
    self.mgr = [[CLLocationManager alloc] init];
    //请求当应用在使用时可以获取授权
    if ([self.mgr respondsToSelector:@selector(requestWhenInUseAuthorization)]) { //低版本适配
        
        [self.mgr requestWhenInUseAuthorization];
    }
    
    self.mgr.delegate = self;
    
    [self.mgr startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate
//当已经更新位置后调用(该方法无论是否改变位置,只要获取到位置信息,就会调用)
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    //CLLocation 用来表示位置信息的
    CLLocation *location = locations.lastObject;
    
    NSLog(@"%f, %f", location.coordinate.latitude, location.coordinate.longitude);
    
    _latitude = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
    _longitude = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
    
    [self headerRefresh];
    
        __weak typeof(self) weakSelf = self;
    CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];

    [clGeoCoder reverseGeocodeLocation:location completionHandler: ^(NSArray *placemarks,NSError *error) {

        for (CLPlacemark *placeMark in placemarks)
        {
            NSDictionary *addressDic=placeMark.addressDictionary;

            //            NSString *state=[addressDic objectForKey:@"State"];
            NSString *citys =[addressDic objectForKey:@"City"];
            //            NSString *subLocality=[addressDic objectForKey:@"SubLocality"];
            //            NSString *street=[addressDic objectForKey:@"Street"];

            //NSString *b = [citys substringToIndex:citys.length-1];

            CGFloat cityWidth = [self.view returnWidth:citys  font:ScaleW(14)];
              
             // self.leftNaviView.width = cityWidth;
              [weakSelf.leftNaviView setTitle:citys forState:UIControlStateNormal];
            
              weakSelf.leftNaviView.width = cityWidth +ScaleW(40);
        }
    }];
//    //停止定位
    [self.mgr stopUpdatingLocation];
}

-(void)collectCityListReq
{
   
    NSDictionary * pamas = @{};
    
    [NetWorkTools postConJSONWithUrl:kGetcityListUrl parameters:pamas success:^(id responseObject) {
        NSString *result = responseObject[@"result"];
        NSString *resultNote = responseObject[@"resultNote"];
        NSArray *array = responseObject[@"dataList"];
       // NSMutableArray *muArray = [NSMutableArray array];
        if (result.integerValue == 0) {
           
            //[self handleListWithModel:muArray];
        }else{
             [MBProgressHUD showError:resultNote];
        }
         
    } fail:^(NSError *error) {
        
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"抢单大厅";
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self.view addSubview:self.headerLoopView];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = kMainBgColor;
    self.canUpdate = YES;
    if([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"定位服务未开启" message:@"请进入系统「设置」》「隐私」「定位服务」中打开开关,并允许发布汇使用定位服务" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"立即开启", nil];
        
        [alertView show];
        
    } else {
        
        [self setAnimation];
    }
    
    [self setNaviSetting];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lauchImgDisMissed:) name:@"adsDismissedAction" object:nil];
  
    //WS(weakSelf);
//   LocationStatus status = [LocationTool share].currentLocationStatus;
//    if (status == LocationStatusYes) {
//        [[LocationTool share] startLocationWithResult:^(AMapLocationReGeocode * _Nullable regeocode, CLLocationCoordinate2D loc) {
//            weakSelf.latitude = [NSString stringWithFormat:@"%f",loc.latitude];
//            weakSelf.longitude = [NSString stringWithFormat:@"%f",loc.longitude];
//            [self headerRefresh];
//        }];
//    }else{
//        LXAskToLocationViewController *vc = [[LXAskToLocationViewController alloc]init];
//        vc.gotoBlock = ^{
//           [[LocationTool share] skipToSystemLocation];
//        };
//        vc.cancellBlock = ^{
//
//        };
//        [self preasntVc:vc];
//
//    }
    [self  updateVersionRequst];
}

-(void)lauchImgDisMissed:(NSNotification *)noti{
  
    if (!kLogin) {
        [self presentLoginAction];
    }
     
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(UIButton *)pulishBtn{
    if (!_pulishBtn) {
        _pulishBtn = [WLTools allocButtonTitle:@"" font:systemFont(0) textColor:kWhiteColor image:[UIImage imageNamed:@"dibu_fabu"] frame:CGRectMake(0, ScreenHeight - Height_TabBar - ScaleW(26), ScaleW(56), ScaleW(56)) sel:@selector(publishAction:) taget:self];
        _pulishBtn.centerX = [UIApplication sharedApplication].keyWindow.width/2.f;
        _pulishBtn.layer.cornerRadius = _pulishBtn.height/2.f;
        [_pulishBtn setShadowColor:kBlueColor];
        _pulishBtn.backgroundColor = kBlueColor;
        _pulishBtn.tag = kPublishBtnTag;
    }
    return _pulishBtn;
}
-(UIButton *)biggerPulishBtn{
    if (!_biggerPulishBtn) {
        _biggerPulishBtn = [WLTools allocButtonTitle:@"" font:systemFont(0) textColor:kWhiteColor image:nil frame:CGRectMake(0, ScreenHeight - Height_TabBar - ScaleW(30), ScaleW(56), ScaleW(30) + Height_TabBar) sel:@selector(publishAction:) taget:self];
        _biggerPulishBtn.centerX = [UIApplication sharedApplication].keyWindow.width/2.f;
        _biggerPulishBtn.tag = kBiggerPublishTag;
    }
    return _biggerPulishBtn;
}
-(void)setNaviSetting{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftNaviView];
    self.navigationItem.leftBarButtonItem = leftItem;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightView];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(UIButton *)leftNaviView{
    if (!_leftNaviView) {
        NSString *imgNameString = @"dingwei_xiangxia";
        imgNameString = @"";
        _leftNaviView = [WLTools allocButtonTitle:@"郑州市" font:systemFont(ScaleW(14)) textColor:kMainTxtColor image:[UIImage imageNamed:imgNameString] frame:CGRectMake(0, 0, ScaleW(60), ScaleW(30)) sel:@selector(getSelfAddress:) taget:self];
        [_leftNaviView setTitleEdgeInsets:UIEdgeInsetsMake(0,-_leftNaviView.imageView.size.width, 0, _leftNaviView.imageView.size.width)];

        [_leftNaviView setImageEdgeInsets:UIEdgeInsetsMake(0, _leftNaviView.titleLabel.bounds.size.width, 0, -_leftNaviView.titleLabel.bounds.size.width - ScaleW(10))];
        
    }
    return _leftNaviView;
}
-(UIButton *)rightView{
    if (!_rightView) {
        _rightView = [WLTools allocButtonTitle:@"" font:systemFont(ScaleW(14)) textColor:kMainTxtColor image:[UIImage imageNamed:@"shouye_xiaoxi"] frame:CGRectMake(0, 0, ScaleW(60), ScaleW(30)) sel:@selector(gotoMessageAction:) taget:self];
       
        [_rightView addSubview:self.redPointLabel];
    }
    return _rightView;
}
-(UILabel *)redPointLabel{
    if (!_redPointLabel) {
        _redPointLabel = [WLTools allocLabel:@"0" font:systemFont(ScaleW(9)) textColor:kWhiteColor frame:CGRectMake(ScaleW(30), ScaleW(5), ScaleW(15), ScaleW(12)) textAlignment:(NSTextAlignmentCenter)];
        _redPointLabel.backgroundColor = kRedColor;
        [_redPointLabel setCornerRadius:ScaleW(6)];
    }
    return _redPointLabel;
}
-(void)getSelfAddress:(UIButton *)sender
{
//    GYZChooseCityController *cityPickerVC = [[GYZChooseCityController alloc] init];
//        [cityPickerVC setDelegate:self];
//        cityPickerVC.hotCitys = @[@"北京市", @"上海市", @"杭州市", @"广州市", @"深圳市", @"武汉市", @"南京市", @"天津市"];
//        cityPickerVC.currentCity = sender.titleLabel.text;
//    //    cityPickerVC.modalPresentationStyle = UIModalPresentationFullScreen;
//    //    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:cityPickerVC] animated:YES completion:^{
//    //
//    //    }];
//        [self.navigationController pushViewController:cityPickerVC animated:YES];
}
-(void)gotoMessageAction:(UIButton *)sender
{
    if (![self ifNoLoginGotoLoginAction]) {
        return;
    }
    LXMessageViewController *vc = [[LXMessageViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_headerLoopView startAnimation];
    [self messageListReq];
    [self requstRunLoopHttp];
    [self headerRefresh];
   
    [self collectCityListReq];
    
    
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
    exit(0);
//    AppDelegate *app = [UIApplication sharedApplication].delegate;
//    UIWindow *window = app.window;
//    
//    [UIView animateWithDuration:1.0f animations:^{
//        window.alpha = 0;
//        window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
//    } completion:^(BOOL finished) {
//        
//    }];
    //exit(0);
    
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
                         //[MBProgressHUD showError:@"已经是最新版本"];
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
-(NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(LXGetOrderHeaderView *)headerLoopView{
    if (!_headerLoopView) {
        _headerLoopView = [[LXGetOrderHeaderView alloc]initWithContentString:@""];
    }
    return _headerLoopView;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _headerLoopView.bottom , ScreenWidth, ScreenHeight -  Height_NavBar - _headerLoopView.height - Height_TabBar) style:(UITableViewStyleGrouped)];
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
        
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
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
    LXGetOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LXGetOrderTableViewCell"];
    if (!cell) {
        cell = [[LXGetOrderTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"LXGetOrderTableViewCell"];
    }
    LXGetOrderListModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    WS(weakSelf);
    cell.getOrderBlock = ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"您是否确定取消订单？" preferredStyle:UIAlertControllerStyleAlert];
         UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
             [weakSelf getOrderWithOrderNum:model.ordernum];
            }];
        [alert addAction:action1];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
          
        }];
        [alert addAction:action2];
        [weakSelf  presentViewController:alert animated:YES completion:nil];
      
    };
    return cell;
}

-(void)getOrderWithOrderNum:(NSString *)Ordernum{
    NSDictionary * pamas = @{@"ordernum":Ordernum,@"longitude":_longitude,@"latitude":_latitude};
    [NetWorkTools postConJSONWithUrl:kEngineerorderdemandgrabbing parameters:pamas success:^(id responseObject) {
        NSString *result = responseObject[@"result"];
        NSString *resultNote = responseObject[@"resultNote"];

        if (result.integerValue == 0) {
            [MBProgressHUD showError:@"请到我的——服务订单里面查看订单详情"];
            [self.tableView.mj_header beginRefreshing];
        }else{
           [MBProgressHUD showError:@"该订单已经超过时效范围"];
        }
        [MBProgressHUD showError:resultNote];
        
    } fail:^(NSError *error) {
        
    }];
}

-(void)getOrderFailed{
    LXGetOrderFailedNOIdViewController *vc = [[LXGetOrderFailedNOIdViewController alloc]init];
    [self preasntVc:vc];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    LXRequstDetailViewController *vc = [[LXRequstDetailViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
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
     LXGetOrderListModel *model = self.dataArray[indexPath.row];
    return ScaleW(367) + model.offHeight;
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
    if (!kLogin) {
       
        return;
    }
    self.pageNum = 1;
    [self collectListReq];
    
}

-(void)footerRefresh
{
    [self collectListReq];
}
-(void)collectListReq
{
    //kGetnearorderdemandlist
    self.latitude = _latitude?:@"113.10";
    self.longitude = _longitude?:@"34.40";
    NSDictionary * pamas = @{@"latitude":self.latitude,@"longitude":self.longitude,@"nowPage":[NSString stringWithFormat:@"%ld",self.pageNum],@"pageCount":[NSString stringWithFormat:@"%d",kPage_Size]};
    if (_canUpdate) {
        _canUpdate = NO;
        [NetWorkTools postConJSONWithUrl:kGetnearorderdemandlist parameters:pamas success:^(id responseObject) {
               NSString *result = responseObject[@"result"];
               NSString *resultNote = responseObject[@"resultNote"];
               NSArray *array = responseObject[@"dataList"];
               NSMutableArray *muArray = [NSMutableArray array];
               if (result.integerValue == 0) {
                   for (NSDictionary *dic  in array) {
                       LXGetOrderListModel *model = [[LXGetOrderListModel alloc]init];
                       [model setValuesForKeysWithDictionary:dic];
                       [muArray addObject:model];
                   }
                   [self handleListWithModel:muArray];
               }else{
                    [MBProgressHUD showError:resultNote];
               }
            self.canUpdate = YES;
           } fail:^(NSError *error) {
            self.canUpdate = YES;
           }];
    }
   
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
   // [SSKJ_NoDataView showNoData:self.dataArray.count toView:self.tableView offY:ScaleW(10) message:@"您还没有数据哦~" imge:[UIImage imageNamed:@"nolikesimg"]];
    
    self.pageNum++;
    
    [self endRefrash];
    
    [self.tableView reloadData];
    
}
-(void)publishAction:(UIButton *)sender
{
    if (![self ifNoLoginGotoLoginAction]) {
        return;
    }
    LXPublishAlertViewController * vc = [LXPublishAlertViewController new];
    BaseNavigationViewController *lvc = [[BaseNavigationViewController alloc]initWithRootViewController:vc];
    [self preasntVc:lvc];
}

#pragma mark - GYZCityPickerDelegate
- (void) cityPickerController:(GYZChooseCityController *)chooseCityController didSelectCity:(GYZCity *)city
{
//    [chooseCityBtn setTitle:city.cityName forState:UIControlStateNormal];
    if (![self.leftNaviView.titleLabel.text isEqualToString:city.cityName]){
        
        //[[NSUserDefaults standardUserDefaults] setObject:city.cityName forKey:@"jiejuSelectedCity"];
        [LXSaveUserInforTool sharedUserTool].cityId = city.cid;
        CGFloat cityWidth = [self.view returnWidth:city.cityName  font:ScaleW(14)];
        
       // self.leftNaviView.width = cityWidth;
        [self.leftNaviView setTitle:city.cityName forState:UIControlStateNormal];
      
        self.leftNaviView.width = cityWidth +ScaleW(40);
       [_leftNaviView setTitleEdgeInsets:UIEdgeInsetsMake(0,-_leftNaviView.imageView.size.width, 0, _leftNaviView.imageView.size.width)];

        [_leftNaviView setImageEdgeInsets:UIEdgeInsetsMake(0, _leftNaviView.titleLabel.bounds.size.width, 0, -_leftNaviView.titleLabel.bounds.size.width - ScaleW(10))];
//        [self.cityBtn TiaoZhengButtonWithOffsit:autoScale(5) TextImageSite:UIButtonTextLeft];
//        self.pages = 1;
//        [self setupRequest];
//        [self setupBottomGoodsRequest];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeSelectCity" object:nil];
    }
    [chooseCityController.navigationController popViewControllerAnimated:YES];
}

- (void) cityPickerControllerDidCancel:(GYZChooseCityController *)chooseCityController
{
    
}

#pragma mark -跑马灯请求
-(void)requstRunLoopHttp
{
 
    NSDictionary * pamas = @{@"nowPage":[NSString stringWithFormat:@"%d",1],@"pageCount":[NSString stringWithFormat:@"%d",20]};
    
    [NetWorkTools postConJSONWithUrl:kEngineerhorseracelampListUrl parameters:pamas success:^(id responseObject) {
        NSString *result = responseObject[@"result"];
        NSString *resultNote = responseObject[@"resultNote"];
        NSArray *array = responseObject[@"dataList"];
        NSMutableArray *muArray = [NSMutableArray array];
        NSMutableString *reloadString = [NSMutableString string];
        if (result.integerValue == 0) {
            for (NSDictionary *dic  in array) {
                LXRunLoopModel *model = [[LXRunLoopModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [muArray addObject:model];
                [reloadString appendFormat:@"    %@",model.content];
            }
            //[self handleListWithModel:muArray];
            [self.headerLoopView removeFromSuperview];
            self.headerLoopView = [[LXGetOrderHeaderView alloc]initWithContentString:reloadString];
            [self.view addSubview:self.headerLoopView];
        }else{
             [MBProgressHUD showError:resultNote];
        }
         
    } fail:^(NSError *error) {
        
    }];
}
-(void)messageListReq
{
    if (!kLogin) {
        return;
    }
    NSDictionary * pamas = @{@"nowPage":[NSString stringWithFormat:@"%ld",self.pageNum],@"pageCount":[NSString stringWithFormat:@"%d",kPage_Size]};
    [NetWorkTools postConJSONWithUrl:kEngineernoticeslist parameters:pamas success:^(id responseObject) {
        NSString *result = responseObject[@"result"];
        NSString *resultNote = responseObject[@"resultNote"];
        NSArray *array = responseObject[@"dataList"];
        NSInteger isNoredCount = 0;
        if (result.integerValue == 0) {
            for (NSDictionary *dic  in array) {
                NSString *string =dic[@"state"];
                if ( string.boolValue == NO) {
                    isNoredCount++;
                }
            }
            self.redPointLabel.text = [NSString stringWithFormat:@"%ld",isNoredCount];
            self.redPointLabel.width = [self.view returnWidth:self.redPointLabel.text font:ScaleW(12)] + ScaleW(5);
            self.redPointLabel.hidden = !isNoredCount;
        }else{
             [MBProgressHUD showError:resultNote];
        }
         
    } fail:^(NSError *error) {
        
    }];

}

@end

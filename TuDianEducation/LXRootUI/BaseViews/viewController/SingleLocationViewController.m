//
//  SingleLocationViewController.m
//  officialDemoLoc
//
//  Created by 刘博 on 15/9/21.
//  Copyright © 2015年 AutoNavi. All rights reserved.
//

#import "SingleLocationViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

#import "LXAnnotation.h"


@interface SingleLocationViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>
@property (nonatomic,strong)MKMapView *mapView;
@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) MKAnnotationView *tapAnno;
@property (nonatomic,strong) CLLocation *userLocation;
@property (nonatomic,strong) CLLocation *tapLoction;
@property (nonatomic,strong) LXAnnotation *annotation;
@property (nonatomic,strong) NSDictionary *addressDic;

@property (nonatomic,strong) UILabel *bottomMessageLabel;
@end

@implementation SingleLocationViewController

-(void)viewDidLoad
{
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.bottomMessageLabel];
    [self addRightNavItemWithTitle:@"确定" color:kBlueColor font:systemFont(ScaleW(15))];
    if([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
           
           UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"定位服务未开启" message:@"请进入系统「设置」》「隐私」「定位服务」中打开开关,并允许发布汇使用定位服务" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"立即开启", nil];
           
           [alertView show];
           
       } else {
           
           [self setAnimation];
       }
      UIImage *backImg = [UIImage imageNamed:@"base_back"];
    [self addLeftNavItemWithImage:backImg];
    self.title = @"地图";
    
}
- (MKMapView *)mapView
{
    if (!_mapView) {
        _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight - Height_NavBar - ScaleW(50))];
        //设置用户的跟踪模式
        _mapView.userTrackingMode = MKUserTrackingModeFollow;
        //设置标准地图
        _mapView.mapType = MKMapTypeStandard;
        // 不显示罗盘和比例尺
        if (@available(iOS 9.0, *)) {
            _mapView.showsCompass = NO;
            _mapView.showsScale = NO;
        }
        // 开启定位
        _mapView.showsUserLocation = YES;
        _mapView.delegate = self;
        //初始位置及显示范围
        MKCoordinateSpan span=MKCoordinateSpanMake(0.021251, 0.016093);
        [_mapView setRegion:MKCoordinateRegionMake(self.mapView.userLocation.coordinate, span) animated:YES];
        UITapGestureRecognizer *mTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPress:)];
        [_mapView addGestureRecognizer:mTap];
    }
    return _mapView;
}
-(UILabel *)bottomMessageLabel{
    if (!_bottomMessageLabel) {
        _bottomMessageLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(12)) textColor:kMainTxtColor frame:CGRectMake(0, _mapView.bottom, ScreenWidth, ScaleW(50)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _bottomMessageLabel;
}
- (CLLocationManager *)locationManager
{
    if (!_locationManager) {
        //判断定位功能是否打开
        if ([CLLocationManager locationServicesEnabled]) {
            _locationManager = [[CLLocationManager alloc]init];
            _locationManager.delegate = self;
            [_locationManager requestWhenInUseAuthorization];
            
            //设置寻址精度
            _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            _locationManager.distanceFilter = 5.0;
            [_locationManager startUpdatingLocation];
        }
    }
    return _locationManager;
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    [self.locationManager stopUpdatingHeading];
    //地址
    self.userLocation = [locations lastObject];
    //显示范围
    
    MKCoordinateRegion regoin =  MKCoordinateRegionMakeWithDistance(self.userLocation.coordinate,2000, 2000);
   
    [self.mapView setRegion:regoin animated:YES];
         __weak typeof(self) weakSelf = self;
        CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];

    
    [clGeoCoder reverseGeocodeLocation:self.userLocation completionHandler: ^(NSArray *placemarks,NSError *error) {
    
            for (CLPlacemark *placeMark in placemarks)
            {
                NSDictionary *addressDic=placeMark.addressDictionary;
                if (!weakSelf.addressDic) {
                     weakSelf.addressDic = addressDic;
                }
               
            }
        }];
}
-(void)mapViewDidFinishLoadingMap:(MKMapView *)mapView{
    
}
- (void)setAnimation
{
   
    //请求当应用在使用时可以获取授权
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) { //低版本适配
        
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    //self.locationManager.delegate = self;
    
    [self.locationManager startUpdatingLocation];
}


- (void)tapPress:(UIGestureRecognizer*)gestureRecognizer {
CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
   
    self.tapLoction = [[CLLocation alloc]initWithLatitude:touchMapCoordinate.latitude longitude:touchMapCoordinate.longitude];
    CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];
    NSMutableArray *removeAnnotations = [[NSMutableArray alloc]init];
    //将所有需要移除打大头针添加一个数组，去掉当前位置的大头针
    [removeAnnotations addObjectsFromArray:self.mapView.annotations];
    [removeAnnotations removeObject:self.mapView.userLocation];
    //移除需要移除的大头针
    [self.mapView removeAnnotations:removeAnnotations];
    [clGeoCoder reverseGeocodeLocation:self.tapLoction completionHandler: ^(NSArray *placemarks,NSError *error) {
    
            for (CLPlacemark *placeMark in placemarks)
            {
                NSDictionary *addressDic=placeMark.addressDictionary;
                self.addressDic = addressDic;
                self.annotation = [[LXAnnotation alloc]init];
                self.annotation.coordinate = touchMapCoordinate;
                NSString *State = [addressDic objectForKey:@"State"];
                NSString *City = [addressDic objectForKey:@"City"];
                NSString *SubLocality = [addressDic objectForKey:@"SubLocality"];
                
                self.annotation.title = [NSString stringWithFormat:@"%@%@%@",State,City,SubLocality];
                self.annotation.subtitle = [addressDic objectForKey:@"Street"];
                
               //self.tapAnno = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"annotation"];
               // self.mapView.delegate = self;
                
                [self.mapView addAnnotation:self.annotation];
                [self.mapView selectAnnotation:self.annotation animated:YES];
                //[self.mapView reloadInputViews];
            }
        }];
    
    
    

}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
     //由于当前位置的标注也是一个大头针，所以此时需要判断，此代理方法返回nil使用默认大头针视图
    if ([annotation isKindOfClass:[LXAnnotation class]]) {
        static NSString  * key1 = @"Annotation";
        MKAnnotationView * annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:key1];
        if (!annotationView) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:key1];
            annotationView.canShowCallout = true;              //允许交互点击
            annotationView.calloutOffset = CGPointMake(0, 0);  //定义详情视图偏移量
            //annotationView.leftCalloutAccessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wateRedBlank"]];
           
        }
        annotationView.annotation = annotation;
        annotationView.image = [UIImage imageNamed:@"wateRedBlank"];    //设置大头针视图的图片
        return annotationView;
    }else{
        return nil;
    }
}

-(void)setAddressDic:(NSDictionary *)addressDic{
    _addressDic = addressDic;
    NSString *State = [addressDic objectForKey:@"State"];
    NSString *City = [addressDic objectForKey:@"City"];
    NSString *SubLocality = [addressDic objectForKey:@"SubLocality"];
    NSString *Street =  [addressDic objectForKey:@"Street"];
    self.bottomMessageLabel.text = [NSString stringWithFormat:@"选择地址：%@%@%@%@",State,City,SubLocality,Street];
}
-(void)rigthBtnAction:(id)sender{
    if (_addressDic) {
         NSString *State = [_addressDic objectForKey:@"State"];
        NSString *City = [_addressDic objectForKey:@"City"];
        NSString *SubLocality = [_addressDic objectForKey:@"SubLocality"];
        NSString *Street =  [_addressDic objectForKey:@"Street"];
      // NSString *address = [NSString stringWithFormat:@"%@%@%@",City,SubLocality,Street];
        !self.callBackBlock?:self.callBackBlock(State,City,SubLocality,Street);
    }else{
        [MBProgressHUD showError:@"定位失败请手动输入"];
    }
   
    [self.navigationController popViewControllerAnimated:YES];
}
@end

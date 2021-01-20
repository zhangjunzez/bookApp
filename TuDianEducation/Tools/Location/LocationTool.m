//
//  LocationTool.m
//  TuDianEducation
//
//  Created by zpz on 2020/5/15.
//  Copyright © 2020 郑州大點哥. All rights reserved.
//

#import "LocationTool.h"

@interface LocationTool()<AMapLocationManagerDelegate>

@property(nonatomic, strong)AMapLocationManager *locationManager;

@end



@implementation LocationTool

+ (instancetype)share
{
    static LocationTool *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LocationTool alloc]init];
    });
    return manager;
}

- (AMapLocationManager *)locationManager{
    if (!_locationManager) {
//        [AMapServices sharedServices].apiKey =@"03ae930fd4bdb46f5213047304738d43";
        _locationManager = [AMapLocationManager new];
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        //   定位超时时间，最低2s，此处设置为2s
        _locationManager.locationTimeout = 2;
        //   逆地理请求超时时间，最低2s，此处设置为2s
        _locationManager.reGeocodeTimeout = 2;
    }
    return _locationManager;
}

- (void)startLocationWithResult:(void (^)(AMapLocationReGeocode *, CLLocationCoordinate2D))result{
    
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            result(nil, location.coordinate);
            DYLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }else if (regeocode)
        {
            if (!regeocode.citycode.length) {
                result(nil, location.coordinate);
            }
            DYLog(@"location:%@", location);
            DYLog(@"reGeocode:%@", regeocode);
            self.regeocode = regeocode;
            result(regeocode, location.coordinate);
        }
    }];
}

#pragma mark - 定位状态
- (LocationStatus)currentLocationStatus{
//    [self requestLocation];
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)) {
        return LocationStatusYes;
    } else {
        if (![CLLocationManager locationServicesEnabled]) {
            return LocationStatusNoForMobile;
        }else{
            return LocationStatusNoForAPP;
        }
    }
}

- (void)requestLocation
{
    CLLocationManager *manager = [[CLLocationManager alloc] init];
    [manager requestWhenInUseAuthorization];
}

- (void)skipToSystemLocation{
    LocationStatus status = [self currentLocationStatus];
    if (status == LocationStatusYes) {
        return;
    }else if (status == LocationStatusNoForMobile){
        
        //TODO: 关闭手机定位总开关,无法保证跳转
//        if (@available(iOS 10.0, *)) {
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"]
//                                               options:[NSDictionary dictionary]
//                                     completionHandler:nil];
//        } else {
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"App-Prefs:root=Privacy&path=LOCATION"]];
//
//        }
    }else{
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
    
}

#pragma mark - AMapLocationManager Delegate
- (void)amapLocationManager:(AMapLocationManager *)manager doRequireLocationAuth:(CLLocationManager *)locationManager
{
    [locationManager requestAlwaysAuthorization];
}
@end

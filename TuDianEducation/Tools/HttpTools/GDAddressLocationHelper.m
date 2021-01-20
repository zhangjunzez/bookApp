//
//  GDAddressLocationHelper.m
//  TuDianEducation
//
//  Created by 张本超 on 2020/4/17.
//  Copyright © 2020 郑州大點哥. All rights reserved.
//

#import "GDAddressLocationHelper.h"

#define DefaultLocationTimeout 10
#define DefaultReGeocodeTimeout 5
@interface GDAddressLocationHelper()<AMapLocationManagerDelegate>
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, copy) AMapLocatingCompletionBlock completionBlock;
@end
@implementation GDAddressLocationHelper
// 跟上面的方法实现有一点不同
+ (instancetype)sharedLocationHelper{
    static GDAddressLocationHelper *sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
          // 要使用self来调用
        sharedSingleton = [[self alloc] init];
    });
    return sharedSingleton;
}
-(instancetype)init{
    if (self = [super init]) {
        [self cofigData];
        [self initCompleteBlock];
    }
    return self;
}
-(void)cofigData
{
    self.locationManager = [[AMapLocationManager alloc] init];
       
       [self.locationManager setDelegate:self];
       
       //设置期望定位精度
       [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
       
       //设置不允许系统暂停定位
//       [self.locationManager setPausesLocationUpdatesAutomatically:NO];
//       
//       //设置允许在后台定位
//       [self.locationManager setAllowsBackgroundLocationUpdates:YES];
//       
       //设置定位超时时间
       [self.locationManager setLocationTimeout:DefaultLocationTimeout];
       
       //设置逆地理超时时间
       [self.locationManager setReGeocodeTimeout:DefaultReGeocodeTimeout];
}
- (void)cleanUpAction
{
    //停止定位
    [self.locationManager stopUpdatingLocation];
    
    [self.locationManager setDelegate:self];
    
}
- (void)reGeocodeAction
{
    //进行单次带逆地理定位请求
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:self.completionBlock];
}
- (void)locAction
{
    //进行单次定位请求
    [self.locationManager requestLocationWithReGeocode:NO completionBlock:self.completionBlock];
}
- (void)initCompleteBlock
{
    //__weak SingleLocaitonAloneViewController *weakSelf = self;
    WS(weakSelf);
    self.completionBlock = ^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error)
    {
        [weakSelf.locationManager stopUpdatingLocation];

        if (error != nil && error.code == AMapLocationErrorLocateFailed)
        {
            //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
            NSLog(@"定位错误:{%ld - %@};", (long)error.code, error.localizedDescription);
            return;
        }
        else if (error != nil
                 && (error.code == AMapLocationErrorReGeocodeFailed
                     || error.code == AMapLocationErrorTimeOut
                     || error.code == AMapLocationErrorCannotFindHost
                     || error.code == AMapLocationErrorBadURL
                     || error.code == AMapLocationErrorNotConnectedToInternet
                     || error.code == AMapLocationErrorCannotConnectToHost))
        {
            //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
            NSLog(@"逆地理错误:{%ld - %@};", (long)error.code, error.localizedDescription);
        }
        else if (error != nil && error.code == AMapLocationErrorRiskOfFakeLocation)
        {
            //存在虚拟定位的风险：此时location和regeocode没有返回值，不进行annotation的添加
            NSLog(@"存在虚拟定位的风险:{%ld - %@};", (long)error.code, error.localizedDescription);
            return;
        }
        else
        {
            //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
        }
        
        //修改label显示内容

       if (regeocode)
       {
        !weakSelf.locationRegeocodeSucessBlock?:weakSelf.locationRegeocodeSucessBlock(location.coordinate.latitude, location.coordinate.longitude, regeocode);
           //存储最新的定位信息
           weakSelf.ReGecode = regeocode;
       }
       else
       {
        !weakSelf.locationSucessBlock?:weakSelf.locationSucessBlock(location.coordinate.latitude, location.coordinate.longitude);
       }
    };
}
#pragma mark - AMapLocationManager Delegate

- (void)amapLocationManager:(AMapLocationManager *)manager doRequireLocationAuth:(CLLocationManager *)locationManager
{
    [locationManager requestAlwaysAuthorization];
}


- (void)dealloc
{
    [self cleanUpAction];
    
    self.completionBlock = nil;
}

- (AMapLocationReGeocode *)ReGecode{
    return [LocationTool share].regeocode;
}
@end

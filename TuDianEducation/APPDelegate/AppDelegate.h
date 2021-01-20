//
//  AppDelegate.h
//  TuDianEducation
//
//  Created by 大新的电脑 on 2020/4/3.
//  Copyright © 2020 郑州大點哥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong)CLLocationManager *locationManager;

@end


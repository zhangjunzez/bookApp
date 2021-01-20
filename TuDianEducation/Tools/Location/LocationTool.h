//
//  LocationTool.h
//  TuDianEducation
//
//  Created by zpz on 2020/5/15.
//  Copyright © 2020 郑州大點哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, LocationStatus) {
    LocationStatusYes =1,
    LocationStatusNoForMobile,
    LocationStatusNoForAPP,
};

@interface LocationTool : NSObject

+ (instancetype)share;


- (void)startLocationWithResult:(void (^)(AMapLocationReGeocode * _Nullable regeocode, CLLocationCoordinate2D loc))result;;

- (LocationStatus)currentLocationStatus;

- (void)requestLocation;

- (void)skipToSystemLocation;

///最近一次定位结果
@property(nonatomic, strong)AMapLocationReGeocode *regeocode;
@end

NS_ASSUME_NONNULL_END

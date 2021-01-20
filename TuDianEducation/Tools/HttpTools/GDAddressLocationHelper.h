//
//  GDAddressLocationHelper.h
//  TuDianEducation
//
//  Created by 张本超 on 2020/4/17.
//  Copyright © 2020 郑州大點哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapLocationKit/AMapLocationKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface GDAddressLocationHelper : NSObject
+(instancetype)sharedLocationHelper;
//经纬度反地理编码
@property (nonatomic, copy) void(^locationRegeocodeSucessBlock)(double latitude,double longitude,AMapLocationReGeocode *code);
//经纬度
@property (nonatomic, copy) void(^locationSucessBlock)(double latitude,double longitude);
//储存现有反地理编码
@property (nonatomic, strong) AMapLocationReGeocode *ReGecode;
- (void)reGeocodeAction;
- (void)locAction;
- (void)cleanUpAction;

@end

NS_ASSUME_NONNULL_END

//
//  LXAnnotation.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/16.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface LXAnnotation : NSObject<MKAnnotation>
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * subtitle;
@end
NS_ASSUME_NONNULL_END

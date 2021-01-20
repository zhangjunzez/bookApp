//
//  LXAddressModel.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/8.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 {
   "addressid":""//收货地址ID
   "name":""//收货人姓名
   "phone":""//收货人电话
   "province":""//省
   "city":""//市
   "area":""//区
   "addressdetail":""//详细地址
   "isdefault":""//是否默认(0否 1是)
 }
 **/
@interface LXAddressModel : NSObject
@property (nonatomic,strong) NSString *addressid;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *province;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSString *area;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *province_city_town;
@property (nonatomic,strong) NSString *isdefault;
@end

NS_ASSUME_NONNULL_END

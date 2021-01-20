//
//  SingleLocationViewController.h
//  officialDemoLoc
//
//  Created by 刘博 on 15/9/21.
//  Copyright © 2015年 AutoNavi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface SingleLocationViewController :BaseViewController

@property (nonatomic,copy) void(^callBackBlock)(NSString *state,NSString *city,NSString *SubLocality,NSString *Street );

@end

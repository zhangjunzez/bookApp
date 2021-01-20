//
//  LXMarketOrderView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/29.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXMarketOrderDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LXMarketOrderView : UIView
-(instancetype)initWithTop:(CGFloat)top messageArray:(NSArray *)msaageArray;
@property (nonatomic,strong) NSArray *messageArray;
@property (nonatomic,strong) LXMarketOrderDetailModel *model;
@end

NS_ASSUME_NONNULL_END

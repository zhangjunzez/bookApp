//
//  CalendarCollection.h
//  tudianjiaoyu
//
//  Created by 张本超 on 2020/4/3.
//  Copyright © 2020 张本超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CalendarModel;
NS_ASSUME_NONNULL_BEGIN

@interface CalendarCollection : UIView

@property(nonatomic, strong)NSArray *array;

@property (nonatomic,copy)void(^selectBlock)(CalendarModel* model);

@property (nonatomic, strong) CalendarModel *selectModel;

@property (nonatomic, strong) NSString *selectString;

@property (nonatomic,strong) NSArray *selectArray;

-(instancetype)initWithFrame:(CGRect)frame bacColor:(UIColor *)backColor textColor:(UIColor *)textColor;


@end

NS_ASSUME_NONNULL_END

//
//  STOViewControlView.h
//  SSKJ
//
//  Created by 张本超 on 2019/7/27.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface STOViewControlView : UIView

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, copy) void(^btnClickedBlock)(NSInteger index);

-(instancetype)initWithTop:(CGFloat)top titleArray:(NSArray *)titleArray;

@end

NS_ASSUME_NONNULL_END

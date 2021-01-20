//
//  PopoverViewController.h
//  JYYunSystem
//
//  Created by zpz on 2019/8/3.
//  Copyright © 2019 zpz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, MorePopType) {
    MorePopTypeOrder,
    MorePopTypeTask,
    MorePopTypeLearn,
    MorePopTypeLearnList,
};


@interface PopoverViewController : UIViewController


@property(nonatomic)MorePopType popType;

@property (nonatomic,copy) void (^popActionBlock)(NSInteger index);


@end

NS_ASSUME_NONNULL_END

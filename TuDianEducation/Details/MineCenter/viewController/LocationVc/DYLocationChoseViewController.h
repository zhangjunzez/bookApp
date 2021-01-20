//
//  DYLocationChoseViewController.h
//  XILAIBANG
//
//  Created by ff on 2019/11/30.
//  Copyright © 2019 大點哥. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DYLocationChoseViewControllerDelegate <NSObject>

- (void)sendLocationMsg:(NSDictionary *)dic;

@end

@interface DYLocationChoseViewController : BaseViewController

@property (nonatomic, weak)id <DYLocationChoseViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END

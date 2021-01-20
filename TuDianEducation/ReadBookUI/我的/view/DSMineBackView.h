//
//  DSMineBackView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/12/9.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,MineStatusType) {
    MineStatusTypeLogin,
    MineStatusTypeLoginOut,
};
NS_ASSUME_NONNULL_BEGIN

@interface DSMineBackView : UIView
@property (nonatomic,copy) void(^persionalBlock)(void);
@property (nonatomic,copy) void(^selctBlock)(NSString *string);
@property (nonatomic,copy) void(^headerBlock)(void);
@property (nonatomic,strong) NSDictionary *dataDic;
@property (nonatomic,assign) MineStatusType type;
@property (nonatomic,copy) void(^messageBlock)(void);
@property (nonatomic,copy) void(^settingsBlock)(void);
@end

NS_ASSUME_NONNULL_END

//
//  LXMineBottomView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/24.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXMineBottomView : UIView
@property (nonatomic,copy) void(^itemClickedBlock)(NSInteger index,NSString *nameString);
-(instancetype)initWithTop:(CGFloat)top imageArray:(NSArray *)imgArray nameArray:(NSArray *)nameArray;
@end

NS_ASSUME_NONNULL_END

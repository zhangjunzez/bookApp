//
//  MeidiaIDCardView.h
//  TuDianEducation
//
//  Created by 张本超 on 2020/4/23.
//  Copyright © 2020 郑州大點哥. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MeidiaIDCardView : UIView
@property (nonatomic, copy) void(^showCurrentIndexBlock)(NSInteger currentIndex);
@property (nonatomic, copy) void(^addCurrentBlock)(void);
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger limitCount;
@property (nonatomic, assign) NSInteger row;
-(UIView *)getCurrentViewWith:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END

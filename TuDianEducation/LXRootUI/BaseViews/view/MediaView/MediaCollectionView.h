//
//  MediaCollectionView.h
//  tudianjiaoyu
//
//  Created by 张本超 on 2020/4/5.
//  Copyright © 2020 张本超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MediaCollectionView : UIView
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) void(^showCurrentIndexBlock)(NSInteger currentIndex);
@property (nonatomic, copy) void(^addCurrentBlock)(void);
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger limitCount;
@property (nonatomic, assign) NSInteger row;
-(UIView *)getCurrentViewWith:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END

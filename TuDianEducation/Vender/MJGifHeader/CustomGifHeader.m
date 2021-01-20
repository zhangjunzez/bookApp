//
//  CustomGifHeader.m
//  CustomGifRefresh
//
//  Created by WXQ on 2018/8/20.
//  Copyright © 2018年 JingBei. All rights reserved.
//

#import "CustomGifHeader.h"
#define kRefreshPrefix @"TD1000"
@implementation CustomGifHeader

#pragma mark - 实现父类的方法
- (void)prepare {
    [super prepare];
    //GIF数据
    NSArray * refreshingImages = [self getRefreshingImageArrayWithStartIndex:1 endIndex:5];
    NSArray * beginrefreshImages = [self getBeingRefreshImageArrayWithStartIndex:1 endIndex:9];
    //普通状态
    [self setImages:beginrefreshImages forState:MJRefreshStateIdle];
    //即将刷新状态
    [self setImages:beginrefreshImages duration:30 forState:(MJRefreshStatePulling)];
    //正在刷新状态
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}
- (void)placeSubviews {
    [super placeSubviews];
    //隐藏状态显示文字
    self.stateLabel.hidden = YES;
    //隐藏更新时间文字
    self.lastUpdatedTimeLabel.hidden = YES;
}

#pragma mark - 获取资源图片
- (NSArray *)getRefreshingImageArrayWithStartIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex {
    NSMutableArray * imageArray = [NSMutableArray array];

    for (NSUInteger i = startIndex; i <= endIndex; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%zd.png", kRefreshPrefix,i]];
        if (image) {
            [imageArray addObject:image];
        }
    }
    return imageArray;
}

- (NSArray *)getBeingRefreshImageArrayWithStartIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex {
    NSMutableArray * imageArray = [NSMutableArray array];
    [imageArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%@1.png", kRefreshPrefix]]];
    for (NSUInteger i = endIndex; i >= startIndex; i--) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%zd.png",kRefreshPrefix, i]];
        if (image) {
            [imageArray addObject:image];
        }
    }
    return imageArray;
}
@end

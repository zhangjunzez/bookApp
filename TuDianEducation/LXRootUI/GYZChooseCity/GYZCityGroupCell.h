//
//  GYZCityGroupCell.h
//  GYZChooseCityDemo
//
//  Created by wito on 15/12/29.
//  Copyright © 2015年 gouyz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GYZCity.h"
#import "GYZChooseCityDelegate.h"


#define     MIN_SPACE           8           // 城市button最小间隙
#define     MAX_SPACE           10

#define     WIDTH_LEFT          15        // button左边距
#define     WIDTH_RIGHT         15          // button右边距

#define     MIN_WIDTH_BUTTON    105
#define     HEIGHT_BUTTON       25

@interface GYZCityGroupCell : UITableViewCell
@property (nonatomic,assign) id <GYZCityGroupCellDelegate> delegate;
/**
 *  图片
 */
@property (nonatomic, strong) UIImageView *leftImg;
/**
 *  标题
 */
@property (nonatomic, strong) UILabel *titleLabel;
/**
 *  暂无数据
 */
@property (nonatomic, strong) UILabel *noDataLabel;
/**
 *  btn数组
 */
@property (nonatomic, strong) NSMutableArray *arrayCityButtons;
/**
 *  城市数据信息
 */
@property (nonatomic, strong) NSArray *cityArray;
/**
 *  返回cell高度
 *
 *  @param cityArray cell的数量
 *
 *  @return 返回cell高度
 */
+ (CGFloat) getCellHeightOfCityArray:(NSArray *)cityArray;
//proBool(isCurrent)  //判断是否是当前城市

@property (nonatomic,assign) BOOL isCurrent;
@end

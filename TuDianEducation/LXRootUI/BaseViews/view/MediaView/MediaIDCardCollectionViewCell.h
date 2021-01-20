//
//  MediaIDCardCollectionViewCell.h
//  TuDianEducation
//
//  Created by 张本超 on 2020/4/23.
//  Copyright © 2020 郑州大點哥. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MediaIDCardCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *contentImgView;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) void(^deleteBlock)(UIButton *btn);
@property (nonatomic, strong) void(^addBlock)(UIButton *btn);
@end

NS_ASSUME_NONNULL_END

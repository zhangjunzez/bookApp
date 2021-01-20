//
//  MediaCollectionViewCell.h
//  tudianjiaoyu
//
//  Created by 张本超 on 2020/4/5.
//  Copyright © 2020 张本超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MediaCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *contentImgView;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) void(^deleteBlock)(UIButton *btn);
@property (nonatomic, strong) void(^addBlock)(UIButton *btn);
@end

NS_ASSUME_NONNULL_END

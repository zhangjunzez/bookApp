//
//  DSMinePersionalHeader.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/12/10.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DSMinePersionalHeader : UIView
@property (nonatomic,assign) BOOL isOther;
@property (nonatomic,strong) NSArray *selectArray;
@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,strong) NSDictionary *dataDic;
///
@property (nonatomic,copy) void(^selctBlock)(NSInteger index);
///编辑个人资料
@property (nonatomic,copy) void(^edtingBlock)(void);

///关注个人
@property (nonatomic,copy) void(^attentionBlock)(UIButton *sender);
///屏蔽个人
@property (nonatomic,copy) void(^noceBlock)(UIButton *sender);

@end

NS_ASSUME_NONNULL_END

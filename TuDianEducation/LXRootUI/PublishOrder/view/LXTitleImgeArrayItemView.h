//
//  LXTitleImgeArrayItemView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/30.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXTitleImgeArrayItemView : UIView
-(instancetype)initWithTop:(CGFloat) top title:(NSString *)title imgeArray:(NSArray *)imageArray redHidden:(BOOL)redHidden;
@property (nonatomic,strong) NSArray *urlsArray;
@property (nonatomic,assign) NSInteger limitCount;
@property (nonatomic,strong) NSString *urlsString;
@property (nonatomic,strong) NSArray *setUrlsArray;
@property (nonatomic,strong) NSArray *setServerArray;
@end

NS_ASSUME_NONNULL_END

//
//  LXPublishTileTxtView.h
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/30.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXPublishTileTxtView : UIView
-(instancetype)initWithTop:(CGFloat)top titleString:(NSString *)titleString placeHolder:(NSString *)placeHolder redHidden:(BOOL)redHidden;
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UILabel *placeHolderLabel;
@end

NS_ASSUME_NONNULL_END

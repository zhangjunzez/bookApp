//
//  MoreSelectActionSheetView.h
//  TuDianEducation
//
//  Created by 张本超 on 2020/5/7.
//  Copyright © 2020 郑州大點哥. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MoreSelectActionSheetView : UIView
+(void)showWithItems:(NSArray *)itemsArray title:(NSString *)title selectedIndexBlock:(void(^)(NSArray * selectArray))selectIndexBlcok cancleBlock:(void(^)(void))cancleBlock;
@end
NS_ASSUME_NONNULL_END

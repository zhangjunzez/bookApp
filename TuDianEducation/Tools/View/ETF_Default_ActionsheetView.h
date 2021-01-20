//
//  ETF_Default_ActionsheetView.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/7.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ETF_Default_ActionsheetView : UIView
+(void)showWithItems:(NSArray *)itemsArray title:(NSString *)title selectedIndexBlock:(void(^)(NSInteger selectIndex))selectIndexBlcok cancleBlock:(void(^)(void))cancleBlock;
@end

NS_ASSUME_NONNULL_END

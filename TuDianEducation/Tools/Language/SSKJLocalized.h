//
//  SSKJLocalized.h
//  ChineseToEnglish
//
//  Created by 赵亚明 on 2018/10/8.
//  Copyright © 2018年 . All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface SSKJLocalized : NSObject


+ (SSKJLocalized *)sharedInstance;

//初始化多语言功能
- (void)initLanguage;

//当前语言
- (NSString *)currentLanguage;

//设置要转换的语言
- (void)setLanguage:(NSString *)language;

//设置为系统语言
- (void)systemLanguage;



@end

NS_ASSUME_NONNULL_END

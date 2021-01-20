//
//  SSKJLocalized.m
//  ChineseToEnglish
//
//  Created by 赵亚明 on 2018/10/8.
//  Copyright © 2018年 . All rights reserved.
//

#import "SSKJLocalized.h"



@implementation SSKJLocalized
+ (SSKJLocalized *)sharedInstance{
    static SSKJLocalized *language=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        language = [[SSKJLocalized alloc] init];
    });
    return language;
}

- (void)initLanguage{
    NSString *language=[self currentLanguage];
    if (language.length>0) {
        SSLog(@"自设置语言:%@",language);
    }else{
        [self systemLanguage];
    }
}

- (NSString *)currentLanguage{
    NSString *language=[[NSUserDefaults standardUserDefaults]objectForKey:AppLanguage];
    return language;
}
- (void)setLanguage:(NSString *)language{
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:AppLanguage];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)systemLanguage{
    NSString *languageCode = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"][0];
    SSLog(@"系统语言:%@",languageCode);
    if([languageCode hasPrefix:@"zh-Hant"]){
        languageCode = @"zh-Hant";//繁体中文
    }else if([languageCode hasPrefix:@"zh-Hans"]){
        languageCode = @"zh-Hans";//简体中文
    }else if([languageCode hasPrefix:@"pt"]){
        languageCode = @"pt";//葡萄牙语
    }else if([languageCode hasPrefix:@"es"]){
        languageCode = @"es";//西班牙语
    }else if([languageCode hasPrefix:@"th"])
        { languageCode = @"th";//泰语
    }else if([languageCode hasPrefix:@"hi"]){
        languageCode = @"hi";//印地语
    }else if([languageCode hasPrefix:@"en"]){
        languageCode = @"en";//英语
    }else if([languageCode hasPrefix:@"ko"]){
        languageCode = @"ko";//韩语
    }else if([languageCode hasPrefix:@"ja"]){
        languageCode = @"ja";//日语
    }else{
        languageCode = @"zh-Hans";//简体中文
    }
    [self setLanguage:languageCode];
    
}


@end

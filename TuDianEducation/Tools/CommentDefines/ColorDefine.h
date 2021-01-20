//
//  ColorDefine.h
//  SSKJ
//
//  Created by James on 2018/6/13.
//  Copyright © 2018年 James. All rights reserved.
//


//获取当前是否是暗黑模式


#import "UIColor+DM.h"

//颜色
#define WLColor(r,g,b,a) [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:a]

//由十六进制转换成是十进制
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

//由十六进制转换成是十进制
#define UIColorFromARGB(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:a]

#define kDarkWhiteColor UIColorFromRGB(0xaaaaaa)

#define kWhiteColor [UIColor dm_colorWithColorLight:UIColorFromRGB(0xffffff) dark:kDarkWhiteColor]

#define kMainTxtColor [UIColor dm_colorWithColorLight:UIColorFromRGB(0x333333) dark:UIColorFromRGB(0x999999)]

#define kSubTxtColor [UIColor dm_colorWithColorLight:UIColorFromRGB(0x666666) dark:UIColorFromRGB(0x999999)]
#define kGrayTxtColor [UIColor dm_colorWithColorLight:UIColorFromRGB(0x999999) dark:UIColorFromRGB(0x999999)]

#define kMainBgColor [UIColor dm_colorWithColorLight:UIColorFromRGB(0xf2f2f2) dark:UIColorFromRGB(0x999999)]



#define kRedColor [UIColor dm_colorWithColorLight:UIColorFromRGB(0xea3106) dark:UIColorFromRGB(0x999999)]

#define kGreenColor [UIColor dm_colorWithColorLight:UIColorFromRGB(0x44D685) dark:UIColorFromRGB(0x999999)]

#define kBacColor UIColorFromARGB(0x000000,.3)

#define kTodayBacColor UIColorFromARGB(0x496ffc,.2)

#define kBlackColor UIColorFromRGB(0x121922)

#define kBlueColor [UIColor dm_colorWithColorLight:UIColorFromRGB(0x4385ff) dark:UIColorFromRGB(0x999999)]

#define kDeepBlueColor [UIColor dm_colorWithColorLight:UIColorFromRGB(0x1456D9) dark:UIColorFromRGB(0x999999)]

#define kBlueBacColor UIColorFromRGB(0xF3F7FF)

#define kMainLineColor [UIColor dm_colorWithColorLight:UIColorFromRGB(0xeeeeee) dark:UIColorFromRGB(0xaaaaaa)]

#define kPublishAlertBacColor UIColorFromARGB(0xffffff,.8)
//EDEDED
#define kGrayBtnBacColor UIColorFromRGB(0xdddddd)
//FF82B0
#define kSearchRedColor [UIColor dm_colorWithColorLight:UIColorFromRGB(0xFF82B0) dark:UIColorFromRGB(0x999999)]

///f6f6f6
#define kSubBacColor UIColorFromRGB(0xf6f6f6)


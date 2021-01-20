//
//  DYColorHelper.m
//  XILAIBANG
//
//  Created by ff on 2019/11/25.
//  Copyright © 2019 大點哥. All rights reserved.
//

#import "DYColorHelper.h"

@implementation DYColorHelper

// 是否暗黑模式
+(BOOL)isDarkSystemMode {
    if (@available(iOS 13.0, *)) {
        UIUserInterfaceStyle mode = UITraitCollection.currentTraitCollection.userInterfaceStyle;
        if (mode == UIUserInterfaceStyleDark) {
            return YES;
        } else if (mode == UIUserInterfaceStyleLight) {
            return NO;
        } else {
            return NO;
        }
    }else {
        return NO;
    }
}

// 背景色-非黑即白(默认白)
+ (UIColor *)sysBGColor {
    UIColor *color;
    if (@available(iOS 13.0, *)) {
        color = [UIColor systemBackgroundColor];
    } else {
        color = WHITE_COLOR;
    }
    return color;
}

// 背景色-gray
+ (UIColor *)sysGrayColor:(int)gray lightColor:(nullable UIColor *)lightColor{
    UIColor *color;
    if (@available(iOS 13.0, *)) {
        switch (gray) {
            case 0:
            case 1:
            {
                UIUserInterfaceStyle mode = UITraitCollection.currentTraitCollection.userInterfaceStyle;
                if (mode == UIUserInterfaceStyleDark) {
                    color = [UIColor systemGrayColor];
                } else if (mode == UIUserInterfaceStyleLight) {
                    if (lightColor != nil) {
                        color = lightColor;
                    }else {
                        color = [UIColor systemGrayColor];
                    }
                } else {
                    if (lightColor != nil) {
                        color = lightColor;
                    }else {
                        color = [UIColor systemGrayColor];
                    }
                }
            }
            break;
            case 2:
            {
                UIUserInterfaceStyle mode = UITraitCollection.currentTraitCollection.userInterfaceStyle;
                if (mode == UIUserInterfaceStyleDark) {
                    color = [UIColor systemGray2Color];
                } else if (mode == UIUserInterfaceStyleLight) {
                    if (lightColor != nil) {
                        color = lightColor;
                    }else {
                        color = [UIColor systemGray2Color];
                    }
                } else {
                    if (lightColor != nil) {
                        color = lightColor;
                    }else {
                        color = [UIColor systemGray2Color];
                    }
                }
            }
            break;
            case 3:
            {
                UIUserInterfaceStyle mode = UITraitCollection.currentTraitCollection.userInterfaceStyle;
                if (mode == UIUserInterfaceStyleDark) {
                    color = [UIColor systemGray3Color];
                } else if (mode == UIUserInterfaceStyleLight) {
                    if (lightColor != nil) {
                        color = lightColor;
                    }else {
                        color = [UIColor systemGray3Color];
                    }
                } else {
                    if (lightColor != nil) {
                        color = lightColor;
                    }else {
                        color = [UIColor systemGray3Color];
                    }
                }
            }
            break;
            case 4:
            {
                UIUserInterfaceStyle mode = UITraitCollection.currentTraitCollection.userInterfaceStyle;
                if (mode == UIUserInterfaceStyleDark) {
                    color = [UIColor systemGray4Color];
                } else if (mode == UIUserInterfaceStyleLight) {
                    if (lightColor != nil) {
                        color = lightColor;
                    }else {
                        color = [UIColor systemGray4Color];
                    }
                } else {
                    if (lightColor != nil) {
                        color = lightColor;
                    }else {
                        color = [UIColor systemGray4Color];
                    }
                }
            }
            break;
            case 5:
            {
                UIUserInterfaceStyle mode = UITraitCollection.currentTraitCollection.userInterfaceStyle;
                if (mode == UIUserInterfaceStyleDark) {
                    color = [UIColor systemGray5Color];
                } else if (mode == UIUserInterfaceStyleLight) {
                    if (lightColor != nil) {
                        color = lightColor;
                    }else {
                        color = [UIColor systemGray5Color];
                    }
                } else {
                    if (lightColor != nil) {
                        color = lightColor;
                    }else {
                        color = [UIColor systemGray5Color];
                    }
                }
            }
            break;
            case 6:
            {
                UIUserInterfaceStyle mode = UITraitCollection.currentTraitCollection.userInterfaceStyle;
                if (mode == UIUserInterfaceStyleDark) {
                    color = [UIColor systemGray6Color];
                } else if (mode == UIUserInterfaceStyleLight) {
                    if (lightColor != nil) {
                        color = lightColor;
                    }else {
                        color = [UIColor systemGray6Color];
                    }
                } else {
                    if (lightColor != nil) {
                        color = lightColor;
                    }else {
                        color = [UIColor systemGray6Color];
                    }
                }
            }
            break;
                
            default:
                break;
        }
        
    } else {
        if (lightColor != nil) {
            color = lightColor;
        }else {
            color = WHITE_COLOR;
        }
    }
    return color;
    
}

// 字体颜色- 51-221(默认51);
+ (UIColor *)default_51_221_Color {
    UIColor *color;
    if (@available(iOS 13.0, *)) {
        color = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return COLOR_221;
            }
            return COLOR_51;
        }];
    } else {
        color = COLOR_51;
    }
    return color;
}

// 字体颜色- 51-153(默认51)
+ (UIColor *)default_51_153_Color {
    UIColor *color;
    if (@available(iOS 13.0, *)) {
        color = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return COLOR_153;
            }
            return COLOR_51;
        }];
    } else {
        color = COLOR_51;
    }
    return color;
}

// 字体颜色- 51-242(默认51)
+ (UIColor *)default_51_242_Color {
    UIColor *color;
    if (@available(iOS 13.0, *)) {
        color = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return COLOR_242;
            }
            return COLOR_51;
        }];
    } else {
        color = COLOR_51;
    }
    return color;
}

// 背景色自定义
+(UIColor *)customDefaultColor:(UIColor *)defaultColor darkColor:(UIColor *)darkColor {
    UIColor *color;
    if (@available(iOS 13.0, *)) {
        color = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return darkColor;
            }
            return defaultColor;
        }];
    } else {
        color = defaultColor;
    }
    return color;
}

@end

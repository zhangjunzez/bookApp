//
//  BookhuiyuanCenterViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/7.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "BookhuiyuanCenterViewController.h"

@interface BookhuiyuanCenterViewController ()

@end

@implementation BookhuiyuanCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"会员说明";
    self.view.backgroundColor = kWhiteColor;
    UILabel *label = [WLTools allocLabel:@"用户在本APP上进行首次消费即可成为会员，之后再消费即可享受会员价格" font:systemFont(ScaleW(13)) textColor:kSubTxtColor frame:CGRectMake(ScaleW(15), ScaleW(15), ScreenWidth - ScaleW(30), ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
    [label sizeToFit];
    [self.view addSubview:label];
}





@end

//
//  BookItemsView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/7.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "BookItemsView.h"

@implementation BookItemsView
-(instancetype)initWithTop:(CGFloat)top x:(CGFloat)x name:(NSString *)name subName:(NSString *)subName bgImg:(NSString *)bgImg
{
    if (self = [super init]) {
        self.frame = CGRectMake(x, top, ScaleW(172), ScaleW(80));
        self.backgroundColor = kWhiteColor;
        self.cornerRadius = ScaleW(5);
        UIButton *bgBtn = [WLTools allocButtonTitle:@"" font:systemFont(0) textColor:kWhiteColor image:nil frame:CGRectMake(0, 0, self.width, self.height) sel:@selector(gotoAction:) taget:self];
        [self addSubview:bgBtn];
        [bgBtn setBackgroundImage:[UIImage imageNamed:bgImg] forState:(UIControlStateNormal)];
        UILabel *namelabel = [WLTools allocLabel:name font:systemBoldFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(12), ScaleW(25), ScaleW(80), ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
        [bgBtn addSubview:namelabel];
        UILabel *subnameLabel = [WLTools allocLabel:subName font:systemBoldFont(ScaleW(11)) textColor:kGrayTxtColor frame:CGRectMake(ScaleW(12), ScaleW(9) + namelabel.bottom, ScaleW(80), ScaleW(11)) textAlignment:(NSTextAlignmentLeft)];
        [bgBtn addSubview:subnameLabel];
    }
    return self;
};
-(void)gotoAction:(UIButton *)sender
{
    !self.gotoBlock?:self.gotoBlock();
}
@end

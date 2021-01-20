//
//  BookMoneyAccountView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/7.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "BookMoneyAccountView.h"
@interface BookMoneyAccountView()
@property (nonatomic,strong) UILabel *moneyLabel;
@end

@implementation BookMoneyAccountView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ScaleW(353), ScaleW(50));
        self.backgroundColor = kWhiteColor;
        self.cornerRadius = ScaleW(5);
        UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"64-金币_d"]];
        image.left = ScaleW(12);
        image.top = ScaleW(18);
        [self addSubview:image];
        UILabel *nameLabel = [WLTools allocLabel:@"资金账户" font:systemBoldFont(ScaleW(13)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(6) + image.right, ScaleW(19), ScaleW(200), ScaleW(13)) textAlignment:(NSTextAlignmentLeft)];
        [self addSubview:nameLabel];
        _moneyLabel =  [WLTools allocLabel:@"￥0.00" font:systemBoldFont(ScaleW(13)) textColor:kRedColor frame:CGRectMake(ScaleW(6) + image.right, ScaleW(19), ScaleW(200), ScaleW(13)) textAlignment:(NSTextAlignmentRight)];
        _moneyLabel.right = self.width - ScaleW(23);
        UIImageView *goimg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"chakanquanbu"]];
        goimg.centerY = self.height/2.f;
        goimg.right = self.width - ScaleW(13);
        [self addSubview:goimg];
        UIButton *btn = [WLTools allocButtonTitle:@"" font:systemFont(ScaleW(0)) textColor:kWhiteColor image:nil frame:self.bounds sel:@selector(gotoAccountAction) taget:self];
        self.userInteractionEnabled = YES;
        [self addSubview:btn];
    }
    return self;
}
-(void)gotoAccountAction{
    !self.gotoBlock?:self.gotoBlock();
}


@end

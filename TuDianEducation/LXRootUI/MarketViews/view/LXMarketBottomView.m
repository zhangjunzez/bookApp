//
//  LXMarketBottomView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/2.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//


#import "LXMarketBottomView.h"
@interface LXMarketBottomView()
@property (nonatomic,strong) UILabel *payTitleLabel;

@property (nonatomic,strong) UIButton *confirmDoneBtn;

@end

@implementation LXMarketBottomView

-(instancetype)init
{
    if (self = [super init])
    {
        [self viewConfig];
    }
    return self;
}
-(void)viewConfig{
    self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(50));
    [self addSubview:self.confirmDoneBtn];
    [self addSubview:self.payTitleLabel];
    [self addSubview:self.priceLabel];
    
}
-(UILabel *)payTitleLabel{
    if (!_payTitleLabel) {
        _payTitleLabel = [WLTools allocLabel:@"合计：" font:systemFont(ScaleW(13)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(12), 0, ScaleW(50), self.height) textAlignment:(NSTextAlignmentLeft)];
        _payTitleLabel.numberOfLines = 1;
    }
    return _payTitleLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [WLTools allocLabel:@"2269积分" font:systemBoldFont(ScaleW(13)) textColor:kRedColor frame:CGRectMake( _payTitleLabel.right, 0, ScaleW(150), self.height) textAlignment:(NSTextAlignmentLeft)];
    }
    return _priceLabel;
}
-(UIButton *)confirmDoneBtn{
    if (!_confirmDoneBtn) {
        _confirmDoneBtn = [WLTools allocButtonTitle:@"确认兑换" font:systemFont(ScaleW(14)) textColor:kWhiteColor image:nil frame:CGRectMake(ScaleW(234), ScaleW(5), ScaleW(126), ScaleW(40)) sel:@selector(confirmDoneBtnAction:) taget:self];
        _confirmDoneBtn.backgroundColor = kGreenColor;
        [_confirmDoneBtn setCornerRadius:_confirmDoneBtn.height/2.f];
    }
    return _confirmDoneBtn;
}

#pragma mark  ---Action

-(void)confirmDoneBtnAction:(UIButton *)sender
{
    !self.conformBuyBlock?:self.conformBuyBlock();
}

@end

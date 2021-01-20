//
//  BkConformBottomView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/14.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//


#import "BkConformBottomView.h"
@interface BkConformBottomView()


@property (nonatomic,strong) UIButton *confirmDoneBtn;

@end

@implementation BkConformBottomView

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
 
    [self addSubview:self.priceLabel];
    
}

-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [WLTools allocLabel:@"共1件商品，合计:￥870.00" font:systemBoldFont(ScaleW(13)) textColor:kMainTxtColor frame:CGRectMake( ScaleW(12), 0, ScaleW(220), self.height) textAlignment:(NSTextAlignmentLeft)];
        
        NSString *string = _priceLabel.text;
        NSRange range = [string rangeOfString:@"￥"];
        NSMutableAttributedString *atts = [[NSMutableAttributedString alloc] initWithString:string];
        [atts setAttributes:@{NSForegroundColorAttributeName:kRedColor} range:NSMakeRange(range.location, string.length - range.location)];
        _priceLabel.attributedText = atts;
    }
    return _priceLabel;
}
-(UIButton *)confirmDoneBtn{
    if (!_confirmDoneBtn) {
        _confirmDoneBtn = [WLTools allocButtonTitle:@"提交订单" font:systemFont(ScaleW(14)) textColor:kWhiteColor image:nil frame:CGRectMake(ScaleW(234), ScaleW(5), ScaleW(126), ScaleW(40)) sel:@selector(confirmDoneBtnAction:) taget:self];
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

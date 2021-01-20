//
//  BkMovieSelectView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/12.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "BkMovieSelectView.h"

@implementation BkMovieSelectView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(40));
        [self addSubview:self.aroundBtn];
        [self addSubview:self.saleBtn];
        [self addSubview:self.priceBtn];
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, .5f)];
        line.backgroundColor = kMainLineColor;
        UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 0.5f, self.width, .5f)];
        line1.backgroundColor = kMainLineColor;
        [self addSubview:line];
        [self addSubview:line1];
        
        
    }
    return self;
}

-(UIButton *)aroundBtn{
    if (!_aroundBtn) {
        _aroundBtn = [WLTools allocButtonTitle:@"综合排序" font:systemFont(ScaleW(13)) textColor:kMainTxtColor image:[UIImage imageNamed:@"jiage"] frame:CGRectMake(0, 0, ScaleW(90), self.height) sel:@selector(arroundBtnAction:) taget:self];
        [_aroundBtn setBtnLeftLabelRightImgOffSet:ScaleW(5)];
        [_aroundBtn setImage:[UIImage imageNamed:@"xiaoliang"] forState:(UIControlStateSelected)];
    }
    return _aroundBtn;
}
-(void)arroundBtnAction:(UIButton *)sender
{
    
}
-(UIButton *)saleBtn{
    if (!_saleBtn) {
        _saleBtn = [WLTools allocButtonTitle:@"销量" font:systemFont(ScaleW(13)) textColor:kMainTxtColor image:[UIImage imageNamed:@"jiage"] frame:CGRectMake(0, 0, ScaleW(90), self.height) sel:@selector(saleBtnAction:) taget:self];
        [_saleBtn setBtnLeftLabelRightImgOffSet:ScaleW(5)];
        [_saleBtn setImage:[UIImage imageNamed:@"xiaoliang"] forState:(UIControlStateSelected)];
        _saleBtn.centerX = ScreenWidth/2.f;
    }
    return _saleBtn;
}
-(void)saleBtnAction:(UIButton *)sender
{
    
}
-(UIButton *)priceBtn{
    if (!_priceBtn) {
        _priceBtn = [WLTools allocButtonTitle:@"价格" font:systemFont(ScaleW(13)) textColor:kMainTxtColor image:[UIImage imageNamed:@"jiage"] frame:CGRectMake(0, 0, ScaleW(90), self.height) sel:@selector(priceBtnAction:) taget:self];
        [_priceBtn setBtnLeftLabelRightImgOffSet:ScaleW(5)];
        [_priceBtn setImage:[UIImage imageNamed:@"xiaoliang"] forState:(UIControlStateSelected)];
        _priceBtn.right = self.width;
    }
    return _priceBtn;
}
-(void)priceBtnAction:(UIButton *)sender
{
    
}
@end

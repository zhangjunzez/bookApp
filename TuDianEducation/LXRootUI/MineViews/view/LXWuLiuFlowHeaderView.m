//
//  LXWuLiuFlowHeaderView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/14.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXWuLiuFlowHeaderView.h"
@interface LXWuLiuFlowHeaderView()
@property (nonatomic,strong) UIView *goodsView;
@property (nonatomic,strong) UIImageView *goodsPicImg;
@property (nonatomic,strong) UILabel *kindsLabel;
@property (nonatomic,strong) UILabel *amountLabel;
@property (nonatomic,strong) UILabel *wuliuNameLabel;
@property (nonatomic,strong) UILabel *wuLiuNumLabel;
@end

@implementation LXWuLiuFlowHeaderView
-(instancetype)init
{
    if (self = [super init])
    {
        [self viewConfig];
    }
    return self;
}
-(void)viewConfig{
    self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(100));
    [self addSubview:self.goodsView];
    [self.goodsView addSubview:self.goodsPicImg];
    [self.goodsView addSubview:self.kindsLabel];
    [self.goodsView addSubview:self.amountLabel];
    [self addSubview:self.wuliuNameLabel];
    [self addSubview:self.wuLiuNumLabel];
    self.height = self.wuLiuNumLabel.bottom + ScaleW(10);
}
-(UIView *)goodsView{
    if (!_goodsView) {
        _goodsView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(15) , ScaleW(345), ScaleW(115))];
        _goodsView.backgroundColor = kWhiteColor;
        [_goodsView setCornerRadius:ScaleW(5)];
    }
    return _goodsView;
}
-(UIImageView *)goodsPicImg{
    if (!_goodsPicImg) {
        _goodsPicImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(19),ScaleW(12),ScaleW(90) , ScaleW(90))];
        _goodsPicImg.backgroundColor = kBlueColor;
    }
    return _goodsPicImg;
}
-(UILabel *)kindsLabel{
    if (!_kindsLabel) {
        _kindsLabel = [WLTools allocLabel:@"科学减重体脂秤" font:systemBoldFont(ScaleW(16)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(14) + _goodsPicImg.right, ScaleW(20) , _goodsView.width - _goodsPicImg.right- ScaleW(15)*2, ScaleW(16)) textAlignment:(NSTextAlignmentLeft)];
        self.kindsLabel.numberOfLines = 0;
    }
    return _kindsLabel;
}
-(UILabel *)amountLabel{
    if (!_amountLabel) {
        _amountLabel = [WLTools allocLabel:@"x1" font:systemFont(ScaleW(14)) textColor:kGrayTxtColor frame:CGRectMake(_goodsPicImg.right, 0, _goodsView.width - _goodsPicImg.right -ScaleW(15), ScaleW(14)) textAlignment:(NSTextAlignmentRight)];
        _amountLabel.centerY = _goodsPicImg.centerY;
    }
    return _amountLabel;
}
-(UILabel *)wuliuNameLabel{
    if (!_wuliuNameLabel) {
        _wuliuNameLabel = [WLTools allocLabel:@"物流" font:systemBoldFont(ScaleW(16)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(20), ScaleW(20) + _goodsView.bottom, ScreenWidth - ScaleW(20), ScaleW(16)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _wuliuNameLabel;
}
-(UILabel *)wuLiuNumLabel{
    if (!_wuLiuNumLabel) {
        _wuLiuNumLabel = [WLTools allocLabel:@"物流单号：" font:systemFont(ScaleW(13)) textColor:kGrayTxtColor frame:CGRectMake(ScaleW(20), ScaleW(13) + _wuliuNameLabel.bottom, ScreenWidth - ScaleW(20), ScaleW(13)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _wuLiuNumLabel;
}
-(void)setModel:(LXMarketOrderDetailModel *)model{
    _model = model;
    NSString *url = [WLTools imageURLWithURL:_model.goodsimage];
    [self.goodsPicImg sd_setImageWithURL:[NSURL URLWithString:url]];
    self.amountLabel.hidden = YES;
    self.kindsLabel.text = _model.goodsname;
    [self.kindsLabel sizeToFit];
    _wuliuNameLabel.text = [NSString stringWithFormat:@"%@物流",_model.logisticscompany];
    _wuLiuNumLabel.text = [NSString stringWithFormat:@"物流单号：%@",_model.logistics];
}
@end

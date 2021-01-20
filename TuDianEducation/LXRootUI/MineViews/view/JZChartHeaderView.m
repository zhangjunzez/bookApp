//
//  JZChartHeaderView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/9/9.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "JZChartHeaderView.h"
@interface JZChartHeaderView()


@end
@implementation JZChartHeaderView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self viewConfig];
    }
    return self;
}
-(void)viewConfig{
    self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(120));
    [self addSubview:self.coinImgView];
    [self addSubview:self.inputTextFild];
    [self addSubview:self.titleLabel];
    self.height = self.titleLabel.bottom;
}

-(UIImageView *)coinImgView{
    if (!_coinImgView) {
        _coinImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"64-金币_d"]];
        _coinImgView.centerX = ScreenWidth/2.f;
        _coinImgView.top = ScaleW(5);
        _coinImgView.width = ScaleW(30);
        _coinImgView.height = ScaleW(30);
    }
    return _coinImgView;
}
-(UITextField *)inputTextFild{
    if (!_inputTextFild) {
        _inputTextFild = [WLTools allocTextFieldText:systemBoldFont(ScaleW(20)) placeHolderFont:systemBoldFont(ScaleW(20)) text:@"" placeText:@"请输入充值金额" textColor:kMainTxtColor placeHolderTextColor:kGrayTxtColor frame:CGRectMake(0, ScaleW(16) + _coinImgView.bottom, ScreenWidth, ScaleW(24))];
        _inputTextFild.textAlignment = NSTextAlignmentCenter;
        
    }
    return _inputTextFild;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:@"需支付" font:systemFont(ScaleW(13)) textColor:kGrayTxtColor frame:CGRectMake(_inputTextFild.left, ScaleW(30) + _inputTextFild.bottom, _inputTextFild.width, ScaleW(13)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _titleLabel;
}



@end

//
//  OrderDetailBottomOctionView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/9.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "OrderDetailBottomOctionView.h"
@interface OrderDetailBottomOctionView()
@property (nonatomic,strong) UIButton *cancellBtn;
@property (nonatomic,strong) UIButton *payBtn;
@end

@implementation OrderDetailBottomOctionView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(50));
        [self addSubview:self.cancellBtn];
        [self addSubview:self.payBtn];
    }
    return self;
}

-(UIButton *)cancellBtn{
    if (!_cancellBtn) {
        _cancellBtn = [WLTools allocButtonTitle:@"取消订单" font:systemFont(ScaleW(13)) textColor:kSubTxtColor image:nil frame:CGRectMake(ScaleW(180), ScaleW(12), ScaleW(75), ScaleW(26)) sel:@selector(cancellAction:) taget:self];
        _cancellBtn.cornerRadius = _cancellBtn.height/2.f;
        [_cancellBtn setBorderWithWidth:1 andColor:kGrayTxtColor];
    }
    return _cancellBtn;
}
-(void)cancellAction:(UIButton *)sender
{
    !self.cancellBlock?:self.cancellBlock();
}
-(UIButton *)payBtn{
    if (!_payBtn) {
        _payBtn = [WLTools allocButtonTitle:@"去付款" font:systemFont(ScaleW(13)) textColor:kGreenColor image:nil frame:CGRectMake(ScaleW(20) +_cancellBtn.right, ScaleW(12), ScaleW(75), ScaleW(26)) sel:@selector(payBtnAction:) taget:self];
        _payBtn.cornerRadius = _cancellBtn.height/2.f;
        [_payBtn setBorderWithWidth:1 andColor:kGreenColor];
    }
    return _payBtn;
}
-(void)payBtnAction:(UIButton *)sender
{
    !self.payBlock?:self.payBlock();
}
@end

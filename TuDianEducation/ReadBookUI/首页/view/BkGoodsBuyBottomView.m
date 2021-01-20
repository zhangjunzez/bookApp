//
//  BkGoodsBuyBottomView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/13.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "BkGoodsBuyBottomView.h"
@interface BkGoodsBuyBottomView()
@property (nonatomic,strong) UIButton *serverBtn;
@property (nonatomic,strong) UIButton *saveBtn;
@property (nonatomic,strong) UIButton *buyCarBtn;
@property (nonatomic,strong) UIButton *buyBtn;
@end
@implementation BkGoodsBuyBottomView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(50));
        [self addSubview:self.serverBtn];
        [self addSubview:self.saveBtn];
        [self addSubview:self.buyCarBtn];
        [self addSubview:self.buyBtn];
        self.backgroundColor = kWhiteColor;
        self.layer.shadowColor = kGrayBtnBacColor.CGColor;
        self.layer.shadowOpacity = .5f;
        self.layer.shadowRadius = 4.f;
        self.layer.shadowOffset = CGSizeMake(4.f, -4.f);
    }
    return self;
}

-(UIButton *)serverBtn{
    if (!_serverBtn) {
        _serverBtn = [WLTools allocButtonTitle:@"客服" font:systemFont(ScaleW(10)) textColor:kSubTxtColor image:[UIImage imageNamed:@"客服_d"] frame:CGRectMake(0, 0, ScaleW(50), self.height) sel:@selector(serverBtnAction:) taget:self];
        [_serverBtn setBtnDownLabelUpDownOffSet:ScaleW(0) leftOffset:ScaleW(0)];
    }
    return _serverBtn;
}
-(void)serverBtnAction:(UIButton *)sender
{
    
}
-(UIButton *)saveBtn{
    if (!_saveBtn) {
        _saveBtn = [WLTools allocButtonTitle:@"收藏" font:systemFont(ScaleW(10)) textColor:kSubTxtColor image:[UIImage imageNamed:@"收藏"] frame:CGRectMake(ScaleW(10) + _serverBtn.right, 0, ScaleW(50), self.height) sel:@selector(saveBtnAction:) taget:self];
        //[_saveBtn setBtnDownLabelUpImgOffSet:ScaleW(3)];
        [_saveBtn setBtnDownLabelUpDownOffSet:ScaleW(0) leftOffset:ScaleW(0)];
        [_saveBtn setImage:[UIImage imageNamed:@"收藏(1)"] forState:(UIControlStateSelected)];
    }
    return _saveBtn;
}

-(void)saveBtnAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
}

-(UIButton *)buyCarBtn{
    if (!_buyCarBtn) {
        _buyCarBtn = [WLTools allocButtonTitle:@"加入购物车" font:systemFont(ScaleW(13)) textColor:kWhiteColor image:nil frame:CGRectMake(ScaleW(144), ScaleW(8), ScaleW(104), ScaleW(35)) sel:@selector(buyCarBtnAction:) taget:self];
        _buyCarBtn.cornerRadius = _buyCarBtn.height/2.f;
        _buyCarBtn.backgroundColor = kRedColor;
    }
    return _buyCarBtn;
}
-(void)buyCarBtnAction:(UIButton *)sender
{
    
}

-(UIButton *)buyBtn{
    if (!_buyBtn) {
        _buyBtn = [WLTools allocButtonTitle:@"立即购买" font:systemFont(ScaleW(13)) textColor:kWhiteColor image:nil frame:CGRectMake(ScaleW(9) + _buyCarBtn.right, ScaleW(8), ScaleW(104), ScaleW(35)) sel:@selector(buyBtnAction:) taget:self];
        _buyBtn.cornerRadius = _buyBtn.height/2.f;
        _buyBtn.backgroundColor = kGreenColor;
    }
    return _buyBtn;
}
-(void)buyBtnAction:(UIButton *)sender
{
    !self.buyBlock?:self.buyBlock();
}
@end

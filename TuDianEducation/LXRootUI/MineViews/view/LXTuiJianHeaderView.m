//
//  LXTuiJianHeaderView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/24.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXTuiJianHeaderView.h"
@interface LXTuiJianHeaderView()
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UILabel *nameLabel;

@property (nonatomic,strong) UIButton *getMoneyBtn;
@property (nonatomic,strong) UILabel *orderRecodeLabel;
@end

@implementation LXTuiJianHeaderView

-(instancetype)init
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(100));
        [self viewConfig];
    }
    return self;
}
-(void)viewConfig{
    [self addSubview:self.backView];
    [self.backView addSubview:self.nameLabel];
    [self.backView addSubview:self.valueLabel];
    [self.backView addSubview:self.getMoneyBtn];
    [self addSubview:self.orderRecodeLabel];
    self.height = self.orderRecodeLabel.bottom + ScaleW(10);
}

-(UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(15), ScreenWidth - ScaleW(30), ScaleW(175))];
        _backView.backgroundColor = kBlueColor;
        [_backView setCornerRadius:ScaleW(15)];
        
    }
    return _backView;
}


-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(14)) textColor:kWhiteColor frame:CGRectMake(0, ScaleW(26), _backView.width, ScaleW(14)) textAlignment:(NSTextAlignmentCenter)];
        
    }
    return _nameLabel;
}
-(UILabel *)valueLabel{
    if (!_valueLabel) {
        _valueLabel = [WLTools allocLabel:@"0" font:systemBoldFont(ScaleW(32)) textColor:kWhiteColor frame:CGRectMake(0, ScaleW(19) + _nameLabel.bottom, _nameLabel.width, ScaleW(32)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _valueLabel;
}

-(UIButton *)getMoneyBtn{
    if (!_getMoneyBtn) {
        _getMoneyBtn = [WLTools allocButtonTitle:@"提现" font:systemFont(ScaleW(13)) textColor:kBlueColor image:nil frame:CGRectMake(ScaleW(130), ScaleW(32) + self.valueLabel.bottom, ScaleW(84), ScaleW(30)) sel:@selector(getMoneyBtnAction:) taget:self];
        _getMoneyBtn.backgroundColor = kWhiteColor;
        [_getMoneyBtn setCornerRadius:ScaleW(4)];
    }
    return _getMoneyBtn;
}

-(UILabel *)orderRecodeLabel{
    if (!_orderRecodeLabel) {
        _orderRecodeLabel = [WLTools allocLabel:@"账单记录" font:systemFont(14) textColor:kMainTxtColor frame:CGRectMake(0, _backView.bottom + ScaleW(23), ScreenWidth, ScaleW(14)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _orderRecodeLabel;
}
-(void)getMoneyBtnAction:(UIButton *)sender{
    !self.getMoneyBlock?:self.getMoneyBlock();
}
@end

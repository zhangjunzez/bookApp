//
//  BkInvateHearderView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/11.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "BkInvateHearderView.h"
@interface BkInvateHearderView()
@property (nonatomic,strong) UIImageView *backImgView;
@property (nonatomic,strong) UILabel *invateCodeLabel;
@property (nonatomic,strong) UIButton *commitBtn;
@property (nonatomic,strong) UILabel *todaySaveLabel;
@property (nonatomic,strong) UILabel *allSaveMoneyLabel;

@property (nonatomic,strong) UIImageView *myFirendImgView;
@property (nonatomic,strong) UILabel *myFirendLabel;


@end
@implementation BkInvateHearderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIImage *imag = [UIImage imageNamed:@"wdeyaoqing"];
        CGFloat h = (imag.size.height/imag.size.width) * ScreenWidth;
        self.frame = CGRectMake(0, 0, ScreenWidth, h);
        [self addSubview:self.backImgView];
        [self addSubview:self.invateCodeLabel];
        [self addSubview:self.commitBtn];
        [self addSubview:self.todaySaveLabel];
        [self addSubview:self.allSaveMoneyLabel];
        [self addSubview:self.myFirendImgView];
        self.height = self.myFirendImgView.bottom;
    }
    return self;
}
-(UIImageView *)backImgView{
    if (!_backImgView) {
        UIImage *imag = [UIImage imageNamed:@"wdeyaoqing"];
        CGFloat h = (imag.size.height/imag.size.width) * ScreenWidth;
        _backImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth , h)];
        _backImgView.image = imag;
    }
    return _backImgView;
}

-(UILabel *)invateCodeLabel{
    if (!_invateCodeLabel) {
        _invateCodeLabel = [WLTools allocLabel:@"邀请码：787878" font:systemFont(ScaleW(17)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(109), 0, ScaleW(158), ScaleW(33)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _invateCodeLabel;
}

-(UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [WLTools allocButtonTitle:@"立即邀请" font:systemFont(ScaleW(15)) textColor:kWhiteColor image:nil frame:CGRectMake(ScaleW(15), _backImgView.bottom, ScaleW(346), ScaleW(40)) sel:@selector(commitBtnAction:) taget:self];
        _commitBtn.backgroundColor = kBlueColor;
        [_commitBtn setCornerRadius:_commitBtn.height/2.f];
    }
    return _commitBtn;
}
-(void)commitBtnAction:(UIButton *)sender
{
    
}

-(UILabel *)todaySaveLabel{
    if (!_todaySaveLabel) {
        _todaySaveLabel = [WLTools allocLabel:@"今日收益:1000" font:systemFont(ScaleW(13)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(37), ScaleW(26) + _commitBtn.bottom, ScaleW(300), ScaleW(13)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _todaySaveLabel;
}
-(UILabel *)allSaveMoneyLabel{
    if (!_allSaveMoneyLabel) {
        _allSaveMoneyLabel = [WLTools allocLabel:@"累计收益:1000" font:systemFont(ScaleW(13)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(37), _todaySaveLabel.top, ScaleW(300), ScaleW(13)) textAlignment:(NSTextAlignmentRight)];
    }
    return _allSaveMoneyLabel;
}

-(UIImageView *)myFirendImgView{
    if (!_myFirendImgView) {
        _myFirendImgView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(42) + _todaySaveLabel.bottom,ScreenWidth - ScaleW(30), ScaleW(30))];
        _myFirendLabel = [WLTools allocLabel:@"我的好友（0)" font:systemFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(0, 0, _myFirendImgView.width, _myFirendImgView.height) textAlignment:(NSTextAlignmentCenter)];
        [_myFirendImgView addSubview:_myFirendLabel];
    }
    return _myFirendImgView;
}


@end

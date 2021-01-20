//
//  LXSearchSectionView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/3.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXSearchSectionView.h"
@interface LXSearchSectionView()
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIButton *reloadBtn;

@property (nonatomic,strong) UILabel *selectCityLabel;
@end

@implementation LXSearchSectionView

-(instancetype)init
{
    if (self = [super init]) {
        [self viewConfig];
    }
    return self;
}
-(void)viewConfig{
    self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(100));
    self.backgroundColor = kMainBgColor;
    [self addSubview:self.nameLabel];
    [self addSubview:self.reloadBtn];
    [self addSubview:self.loactionBtn];
    [self addSubview:self.selectCityLabel];
    self.height = self.selectCityLabel.bottom;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [WLTools allocLabel:@"当前定位城市" font:systemFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(15), ScaleW(15), ScaleW(90), ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
        
    }
    return _nameLabel;
}

-(UIButton *)reloadBtn{
    if (!_reloadBtn) {
        _reloadBtn = [WLTools allocButtonTitle:@"" font:systemFont(ScaleW(0)) textColor:kWhiteColor image:[UIImage imageNamed:@"dizhi_shuaxin"] frame:CGRectMake(_nameLabel.right, 0, ScaleW(22), ScaleW(22)) sel:@selector(reloadBtnAction:) taget:self];
        _reloadBtn.centerY = _nameLabel.centerY;
    }
    return _reloadBtn;
}
-(UIButton *)loactionBtn{
    if (!_loactionBtn) {
        _loactionBtn = [WLTools allocButtonTitle:@"郑州市" font:systemFont(ScaleW(14)) textColor:kMainTxtColor image:[UIImage imageNamed:@"wode_changyongdizhi"] frame:CGRectMake(ScaleW(15), ScaleW(15)+ _nameLabel.bottom, ScaleW(80), ScaleW(27)) sel:@selector(loacationAction:) taget:self];
        _loactionBtn.backgroundColor = kWhiteColor;
        [_loactionBtn setCornerRadius:_loactionBtn.height/2.f];
    }
    return _loactionBtn;
}
-(UILabel *)selectCityLabel{
    if (!_selectCityLabel) {
        _selectCityLabel = [WLTools allocLabel:@"选择城市" font:systemFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(_loactionBtn.left, ScaleW(15) + _loactionBtn.bottom, self.width - ScaleW(15), ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _selectCityLabel;
}
-(void)reloadBtnAction:(UIButton *)sender{
    !self.reloadBlock?:self.reloadBlock();
}
-(void)loacationAction:(UIButton *)sender{
    !self.locationBlock?:self.locationBlock();
}
@end

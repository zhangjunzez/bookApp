//
//  LXRealNameSelectView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/24.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXRealNameSelectView.h"
@interface LXRealNameSelectView()
@property (nonatomic, strong) UIView *bacView;
@property (nonatomic, strong) UIView *septorLine;

@end

@implementation LXRealNameSelectView

-(instancetype)init{
    if (self = [super init])
    {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(50));
        [self viewConfig];
    }
    return self;
}

-(void)viewConfig
{
    self.backgroundColor = kWhiteColor;
    [self addSubview:self.bacView];
    [self.bacView addSubview:self.nameLabel];
    [self.bacView addSubview:self.subNameLabel];
    [self.bacView addSubview:self.gotoImg];
    [self.bacView addSubview:self.septorLine];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapActionAction:)];
    self.bacView.userInteractionEnabled = YES;
    [self.bacView addGestureRecognizer:tap];
}
-(UIView *)bacView{
    if (!_bacView) {
        _bacView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(50))];
        _bacView.backgroundColor = kWhiteColor;
        [_bacView setCornerRadius:ScaleW(8)];
    }
    return _bacView;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [WLTools allocLabel:@"清除缓存" font:systemFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(28), 0, _bacView.width - ScaleW(28+15), ScaleW(50)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _nameLabel;
}
-(UILabel *)subNameLabel{
    if (!_subNameLabel) {
        _subNameLabel = [WLTools allocLabel:@"2.3M" font:systemFont(ScaleW(15)) textColor:kGrayTxtColor frame:CGRectMake(ScaleW(15), 0, _bacView.width - ScaleW(15)- ScaleW(41), ScaleW(50)) textAlignment:(NSTextAlignmentRight)];
    }
    return _subNameLabel;
}
-(UIImageView *)gotoImg{
    if (!_gotoImg) {
        _gotoImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"chakanquanbu"]];
        _gotoImg.right = ScreenWidth - ScaleW(15);
        _gotoImg.centerY = _nameLabel.centerY;
        
    }
    return _gotoImg;
}
-(UIView *)septorLine
{
    if (!_septorLine) {
        _septorLine = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), 0, _bacView.width - ScaleW(30), .5)];
        _septorLine.bottom = ScaleW(50) - 1;
        _septorLine.backgroundColor = kMainBgColor;
    }
    return _septorLine;
}
-(void)tapActionAction:(UITapGestureRecognizer *)tap
{
    !self.gotoBlock?:self.gotoBlock();
}
-(void)setIsEdting:(BOOL)isEdting
{
    _isEdting = isEdting;
    if (_isEdting) {
        _subNameLabel.hidden = YES;
        _gotoImg.hidden = YES;
        [self.bacView addSubview:self.subTextFild];
    }
}

-(UITextField *)subTextFild{
    if (!_subTextFild) {
        _subTextFild = [WLTools allocTextFieldTextFont:ScaleW(14) placeHolderFont:ScaleW(14) text:nil placeText:@"请输入" textColor:kMainTxtColor placeHolderTextColor:kGrayTxtColor frame:_subNameLabel.frame];
        _subTextFild.textAlignment = NSTextAlignmentRight;
        _subTextFild.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _subTextFild;
}
@end

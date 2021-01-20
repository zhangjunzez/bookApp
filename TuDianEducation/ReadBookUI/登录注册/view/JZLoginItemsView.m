//
//  JZLoginItemsView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/8/28.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//



#define leftOffSet ScaleW(38)
#import "JZLoginItemsView.h"
@interface JZLoginItemsView ()
@property (nonatomic,assign) BOOL hasgetCode;
@property (nonatomic,assign) CGFloat top;
@property (nonatomic,strong) NSString *placeHolder;
@property (nonatomic,strong) NSString *titleString;
@property (nonatomic,strong) UIView *bottomLine;

@end
@implementation JZLoginItemsView

-(instancetype)initWithTop:(CGFloat)top titleString:(NSString *)titleString placeHolder:(NSString *)placeHolder hasGetCode:(BOOL)hasgetCode;
{
    if (self = [super init]) {
        _top = top;
        _placeHolder = placeHolder;
        _hasgetCode = hasgetCode;
        _titleString = titleString;
        self.frame = CGRectMake(0, _top, ScreenWidth , ScaleW(77));
        [self viewConfig];
    }
    return self;
};
-(void)viewConfig
{
    [self addSubview:self.titleLabel];
    [self addSubview:self.textFied];
    [self addSubview:self.getCodeBtn];
    [self addSubview:self.bottomLine];
    [self.textFied addSubview:self.eyeBtn];
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:_titleString font:systemBoldFont(ScaleW(15)) textColor:kSubTxtColor frame:CGRectMake(leftOffSet, 0,self.width - leftOffSet, ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
        
    }
    return _titleLabel;
}
-(UITextField *)textFied
{
    if (!_textFied) {
        _textFied = [[UITextField alloc]initWithFrame:CGRectMake(leftOffSet, ScaleW(25) + _titleLabel.bottom, self.width - leftOffSet , ScaleW(15))];
        [_textFied settingTextField:_textFied textFont:systemFont(ScaleW(15)) placeHolderFont:ScaleW(15) text:nil placeText:_placeHolder textColor:kMainTxtColor placeHolderTextColor:kGrayTxtColor];
    }
    return _textFied;
};
-(UIButton *)eyeBtn{
    if (!_eyeBtn) {
        _eyeBtn = [WLTools allocButtonTitle:@"" font:systemFont(ScaleW(0)) textColor:kWhiteColor image:[UIImage imageNamed:@"闭眼"] frame:CGRectMake(_textFied.width - ScaleW(60), 0, ScaleW(25), _textFied.height) sel:@selector(eyeBtnAction:) taget:self];
        [_eyeBtn setImage:[UIImage imageNamed:@"睁眼"] forState:(UIControlStateSelected)];
        _eyeBtn.hidden = YES;
    }
    return _eyeBtn;
}
-(void)eyeBtnAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    _textFied.secureTextEntry = !sender.selected;
}
-(UIButton *)getCodeBtn
{
    if (!_getCodeBtn) {
        _getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _getCodeBtn.frame = CGRectMake(0, 0, ScaleW(100), ScaleW(33));
        _getCodeBtn.centerY = _textFied.centerY;
        _getCodeBtn.right = self.width - leftOffSet;
        [_getCodeBtn setCornerRadius:_getCodeBtn.height/2.f];
        [_getCodeBtn btn:_getCodeBtn font:ScaleW(15) textColor:kMainTxtColor text:@"获取验证码" image:nil sel:@selector(getCodeBtnAction:) taget:self];
        _getCodeBtn.hidden = !_hasgetCode;
       
        _getCodeBtn.backgroundColor = kGrayBtnBacColor;
        _getCodeBtn.cornerRadius = _getCodeBtn.height/2.f;
        
    }
    return _getCodeBtn;
}
-(UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(leftOffSet, self.height - 1, self.width - 2*leftOffSet, .5)];
        _bottomLine.backgroundColor = kMainLineColor;
    }
    return _bottomLine;
}
-(void)getCodeBtnAction:(UIButton *)sender
{
    !self.getCodeBlock?:self.getCodeBlock(sender);
}
@end

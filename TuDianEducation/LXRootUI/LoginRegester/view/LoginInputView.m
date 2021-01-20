//
//  LoginInputView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/23.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LoginInputView.h"
@interface LoginInputView ()
@property (nonatomic,assign) BOOL hasgetCode;
@property (nonatomic,assign) CGFloat top;
@property (nonatomic,strong) NSString *placeHolder;

@property (nonatomic,strong) UIView *bottomLine;
@end
@implementation LoginInputView

-(instancetype)initWithTop:(CGFloat)top placeHolder:(NSString *)placeHolder hasGetCode:(BOOL)hasgetCode
{
    if (self = [super init]) {
        _top = top;
        _placeHolder = placeHolder;
        _hasgetCode = hasgetCode;
        self.frame = CGRectMake(0, _top, ScreenWidth , ScaleW(55));
        [self viewConfig];
    }
    return self;
};
-(void)viewConfig
{
    [self addSubview:self.textFied];
    [self addSubview:self.getCodeBtn];
    [self addSubview:self.lookPswBtn];
    [self addSubview:self.bottomLine];
}
-(UITextField *)textFied
{
    if (!_textFied) {
        CGFloat x = ScaleW(34);
        _textFied = [[UITextField alloc]initWithFrame:CGRectMake(x, 0, self.width - 2*x , self.height)];
        [_textFied textField:_textFied textFont:ScaleW(15) placeHolderFont:ScaleW(15) text:nil placeText:_placeHolder textColor:kMainTxtColor placeHolderTextColor:kGrayTxtColor];
    }
    return _textFied;
};

-(UIButton *)getCodeBtn
{
    if (!_getCodeBtn) {
        _getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _getCodeBtn.frame = CGRectMake(self.width - ScaleW(110), 0, ScaleW(94), ScaleW(32));
        _getCodeBtn.bottom = self.height - ScaleW(10);
        [_getCodeBtn setCornerRadius:_getCodeBtn.height/2.f];
        [_getCodeBtn btn:_getCodeBtn font:ScaleW(15) textColor:kWhiteColor text:@"获取验证码" image:nil sel:@selector(getCodeBtnAction:) taget:self];
        _getCodeBtn.backgroundColor = kBlueColor;
        _getCodeBtn.hidden = !_hasgetCode;
    }
    return _getCodeBtn;
}
-(UIButton *)lookPswBtn
{
    if (!_lookPswBtn) {
        _lookPswBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _lookPswBtn.frame = CGRectMake(self.width - ScaleW(50), 0, ScaleW(34), ScaleW(32));
        _lookPswBtn.bottom = self.height - ScaleW(10);
        [_lookPswBtn btn:_lookPswBtn font:ScaleW(15) textColor:kWhiteColor text:@"" image:[UIImage imageNamed:@"闭眼_d"] sel:@selector(lookPswBtn:) taget:self];
        _lookPswBtn.hidden = YES;
        [_lookPswBtn setImage:[UIImage imageNamed:@"睁眼"] forState:(UIControlStateSelected)];
    }
    return _lookPswBtn;
}
-(UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(34), self.height - 1, self.width - ScaleW(68), 1)];
        _bottomLine.backgroundColor = kMainLineColor;
    }
    return _bottomLine;
}
-(void)getCodeBtnAction:(UIButton *)sender
{
    !self.getCodeBlock?:self.getCodeBlock(sender);
}
-(void)lookPswBtn:(UIButton *)sender{
    sender.selected = !sender.selected;
    _textFied.secureTextEntry = !sender.selected;
}
@end

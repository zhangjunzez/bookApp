//
//  LoginUserView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/22.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LoginUserView.h"
@interface LoginUserView ()
@property (nonatomic,assign) BOOL hasgetCode;
@property (nonatomic,assign) CGFloat top;
@property (nonatomic,strong) UIImage *headerImg;
@property (nonatomic,strong) NSString *placeHolder;

@property (nonatomic,strong) UIImageView *headerImgView;



@end
@implementation LoginUserView

-(instancetype)initWithTop:(CGFloat)top headerImg:(UIImage *)headerImg placeHolder:(NSString *)placeHolder hasGetCode:(BOOL)hasgetCode
{
    if (self = [super init]) {
        self.backgroundColor = kBlueBacColor;
        _top = top;
        _headerImg = headerImg;
        _placeHolder = placeHolder;
        _hasgetCode = hasgetCode;
        self.frame = CGRectMake(ScaleW(32), _top, ScreenWidth - ScaleW(32 *2), ScaleW(55));
        [self setCornerRadius:self.height/2.f];
        [self viewConfig];
    }
    return self;
};
-(void)viewConfig
{
    [self addSubview:self.textFied];
    [self addSubview:self.headerImgView];
    [self addSubview:self.getCodeBtn];
}
-(UITextField *)textFied
{
    if (!_textFied) {
        CGFloat x = _headerImg?ScaleW(67):ScaleW(30);
        _textFied = [[UITextField alloc]initWithFrame:CGRectMake(x, 0, self.width - x , self.height)];
        [_textFied textField:_textFied textFont:ScaleW(14) placeHolderFont:ScaleW(14) text:nil placeText:_placeHolder textColor:kMainTxtColor placeHolderTextColor:kGrayTxtColor];
    }
    return _textFied;
};
-(UIImageView *)headerImgView
{
    if (!_headerImgView) {
        _headerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(30), ScaleW(14), ScaleW(17), ScaleW(26))];
        _headerImgView.image = _headerImg;
        _headerImgView.hidden = !_headerImg;
    }
    return _headerImgView;
}
-(UIButton *)getCodeBtn
{
    if (!_getCodeBtn) {
        _getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _getCodeBtn.frame = CGRectMake(self.width - ScaleW(120), 0, ScaleW(120), self.height);
        [_getCodeBtn btn:_getCodeBtn font:ScaleW(15) textColor:kBlueColor text:@"获取验证码" image:nil sel:@selector(getCodeBtnAction:) taget:self];
        _getCodeBtn.hidden = !_hasgetCode;
    }
    return _getCodeBtn;
}
-(void)getCodeBtnAction:(UIButton *)sender
{
    !self.getCodeBlock?:self.getCodeBlock(sender);
}
@end

//
//  LXAddAddressItemView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/28.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//


#import "LXAddAddressItemView.h"
@interface LXAddAddressItemView ()
@property (nonatomic,assign) CGFloat top;
@property (nonatomic,strong) NSString *placeHolder;


@property (nonatomic,strong) NSString *titleString;
@property (nonatomic,strong) NSString *gotoImgString;
@property (nonatomic,strong) UILabel *titleLabel;
@end
@implementation LXAddAddressItemView

-(instancetype)initWithTitle:(NSString *)title top:(CGFloat)top  placeHolder:(NSString *)placeHolder gotoImgString:(NSString *)gotoImgString;
{
    if (self = [super init]) {
        _top = top;
        _placeHolder = placeHolder;
        _titleString = title;
        _gotoImgString = gotoImgString;
        self.frame = CGRectMake(0, _top, ScreenWidth , ScaleW(57));
        [self viewConfig];
    }
    return self;
};
-(void)viewConfig
{
    [self addSubview:self.titleLabel];
    [self addSubview:self.textFied];
    [self addSubview:self.gotoBtn];
    [self addSubview:self.bottomLine];
    if (self.gotoImgString.length ) {
        self.textFied.userInteractionEnabled = NO;
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
    }
}
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:_titleString font:systemFont(ScaleW(13)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(15), 0, ScaleW(74), self.height) textAlignment:(NSTextAlignmentLeft)];
    }
    return _titleLabel;;
}
-(UITextField *)textFied
{
    if (!_textFied) {
        _textFied = [[UITextField alloc]initWithFrame:CGRectMake(_titleLabel.right, 0, ScaleW(209) , self.height)];
        [_textFied textField:_textFied textFont:ScaleW(13) placeHolderFont:ScaleW(13) text:nil placeText:_placeHolder textColor:kMainTxtColor placeHolderTextColor:kGrayTxtColor];
    }
    return _textFied;
};

-(UIButton *)gotoBtn
{
    if (!_gotoBtn) {
        _gotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _gotoBtn.frame = CGRectMake(_textFied.right, 0, self.width - _textFied.right, self.height);
        [_gotoBtn btn:_gotoBtn font:ScaleW(15) textColor:kWhiteColor text:@"" image:[UIImage imageNamed:_gotoImgString?:@""] sel:@selector(gotoBtnAction:) taget:self];
        _gotoBtn.hidden = !_gotoImgString.length;
    }
    return _gotoBtn;
}
-(UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), self.height - .5, ScaleW(345), .5)];
        _bottomLine.backgroundColor = kMainLineColor;
    }
    return _bottomLine;
}
-(void)gotoBtnAction:(UIButton *)sender
{
    !self.gotoNextBlock?:self.gotoNextBlock();
}
-(void)tapAction:(id)semder{
    !self.gotoNextBlock?:self.gotoNextBlock();
}
@end

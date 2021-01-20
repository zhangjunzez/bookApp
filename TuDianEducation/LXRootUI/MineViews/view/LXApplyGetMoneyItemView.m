//
//  LXApplyGetMoneyItemView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/28.
//  Copyright © 2020 zhangbenchao. All rights reserved.

#import "LXApplyGetMoneyItemView.h"
@interface LXApplyGetMoneyItemView ()
@property (nonatomic,assign) CGFloat top;
@property (nonatomic,assign) BOOL isGotoAction;
@property (nonatomic,strong) NSString *placeHolder;

@property (nonatomic,strong) UIView *bottomLine;
@property (nonatomic,strong) NSString *titleString;
@property (nonatomic,strong) NSString *gotoImgString;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *redPointLabel;
@property (nonatomic,strong) UIImageView *gotoImg;
@end
@implementation LXApplyGetMoneyItemView

-(instancetype)initWithTitle:(NSString *)title top:(CGFloat)top  placeHolder:(NSString *)placeHolder;
{
    if (self = [super init]) {
        _top = top;
        _placeHolder = placeHolder;
        _titleString = title;
        self.frame = CGRectMake(0, _top, ScreenWidth , ScaleW(44));
        [self viewConfig];
    }
    return self;
};
-(instancetype)initWithTitle:(NSString *)title top:(CGFloat)top  placeHolder:(NSString *)placeHolder redHidden:(BOOL)redHidden
{
    if (self = [super init]) {
           _top = top;
           _placeHolder = placeHolder;
           _titleString = title;
           self.frame = CGRectMake(0, _top, ScreenWidth , ScaleW(44));
           [self viewConfig];
           self.redPointLabel.hidden = redHidden;
       }
       return self;
};
-(instancetype)initWithTitle:(NSString *)title top:(CGFloat)top  placeHolder:(NSString *)placeHolder redHidden:(BOOL)redHidden isgGotoAction:(BOOL)isgGotoAction
{
    if (self = [super init]) {
              _top = top;
              _placeHolder = placeHolder;
              _titleString = title;
              self.frame = CGRectMake(0, _top, ScreenWidth , ScaleW(44));
              self.isGotoAction = isgGotoAction;
              [self viewConfig];
              self.redPointLabel.hidden = redHidden;
            
          }
    return self;
};
-(void)viewConfig
{
    self.backgroundColor = kWhiteColor;
    [self addSubview:self.redPointLabel];
    [self addSubview:self.titleLabel];
    [self addSubview:self.textFied];
    [self addSubview:self.bottomLine];
    if (_isGotoAction) {
        _textFied.userInteractionEnabled = NO;
        _textFied.right = self.width - ScaleW(35);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoInforAction)];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:tap];
        [self addSubview:self.gotoImg];
    }
}
-(UILabel *)redPointLabel{
    if (!_redPointLabel) {
        _redPointLabel = [WLTools allocLabel:@"*" font:systemFont(ScaleW(14)) textColor:kRedColor frame:CGRectMake(ScaleW(16), 0, ScaleW(15), self.height) textAlignment:(NSTextAlignmentLeft)];
    }
    return _redPointLabel;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:_titleString font:systemFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(_redPointLabel.right, 0, ScaleW(84), self.height) textAlignment:(NSTextAlignmentLeft)];
    }
    return _titleLabel;;
}
-(UITextField *)textFied
{
    if (!_textFied) {
        _textFied = [[UITextField alloc]initWithFrame:CGRectMake(_titleLabel.right, 0, self.width - _titleLabel.right - ScaleW(15) , self.height)];
        [_textFied textField:_textFied textFont:ScaleW(15) placeHolderFont:ScaleW(15) text:nil placeText:_placeHolder textColor:kMainTxtColor placeHolderTextColor:kGrayTxtColor];
        _textFied.textAlignment = NSTextAlignmentRight;
    }
    return _textFied;
};

-(UIImageView *)gotoImg{
    if (!_gotoImg) {
        _gotoImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"chakanquanbu"]];
        _gotoImg.right = self.width - ScaleW(15);
        _gotoImg.centerY = _textFied.centerY;
       
    }
    return _gotoImg;
}
-(void)gotoInforAction{
    !self.gotoInforActionBlock?:self.gotoInforActionBlock();
}

@end

//
//  BkInputItemView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/11.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "BkInputItemView.h"
@interface BkInputItemView()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UITextField *inputTextField;
@end

@implementation BkInputItemView
-(instancetype)initWithTop:(CGFloat) top Title:(NSString *)title placeHolder:(NSString *)placeHoder{
    if (self = [super init])
    {
        self.frame = CGRectMake(0, top, ScreenWidth, ScaleW(64));
        [self addSubview:self.titleLabel];
        [self addSubview:self.inputTextField];
        self.titleLabel.text = title;
        self.inputTextField.placeholder = placeHoder;
    }
    return self;
};

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:@"昵称" font:systemFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(25), ScaleW(0), ScaleW(200), ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _titleLabel;
}

-(UITextField *)inputTextField
{
    if (!_inputTextField) {
        _inputTextField = [WLTools allocTextFieldText:systemFont(ScaleW(12)) placeHolderFont:systemFont(ScaleW(12)) text:nil placeText:@"请输入昵称" textColor:kMainTxtColor placeHolderTextColor:kSubTxtColor frame:CGRectMake(_titleLabel.left, ScaleW(16) + _titleLabel.bottom, ScaleW(325), ScaleW(33))];
        _inputTextField.backgroundColor = kSubBacColor;
        _inputTextField.layer.cornerRadius = ScaleW(3);
        UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(13), _inputTextField.height)];
        _inputTextField.leftViewMode = UITextFieldViewModeAlways;
        _inputTextField.leftView = v;
    }
    return _inputTextField;
}


@end

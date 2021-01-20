//
//  RegesiterItemView.m
//  HuaYiHuangCheng
//
//  Created by lixinkeji on 2020/10/28.
//  Copyright © 2020 lixinkeji. All rights reserved.
//

#import "RegesiterItemView.h"
@interface RegesiterItemView()
@property (nonatomic,assign) CGFloat top;
@property (nonatomic,strong) NSString *placeHolder;

@property (nonatomic,strong) UILabel *areaLabel;
@property (nonatomic,assign) BOOL red;

@end
@implementation RegesiterItemView

-(instancetype)initWithTop:(CGFloat)top isPhoneAccount:(BOOL)isAccount placeHolder:(NSString *)placeHolder
{
    self = [super init];
    if (self) {
        self.red = YES;
        self.frame = CGRectMake(0, top, ScreenWidth, ScaleW(50));
        self.placeHolder = placeHolder;
        [self addSubview:self.inputTextFiled];
        if (isAccount) {
            self.inputTextFiled.left = ScaleW(34) + ScaleW(54);
            self.inputTextFiled.width = ScreenWidth - ScaleW(68) - ScaleW(54);
            [self addSubview:self.areaLabel];
        }
    }
    return self;
};
-(instancetype)initWithTop:(CGFloat)top isPhoneAccount:(BOOL)isAccount placeHolder:(NSString *)placeHolder red:(BOOL)red
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, top, ScreenWidth, ScaleW(50));
        self.placeHolder = placeHolder;
        self.red = red;
        [self addSubview:self.inputTextFiled];
        UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(32), _inputTextFiled.bottom - 1, self.width - ScaleW(68), 1)];
        bottomLine.backgroundColor = kMainLineColor;
        [self addSubview:bottomLine];
        if (isAccount) {
            self.inputTextFiled.left = ScaleW(34) + ScaleW(54);
            self.inputTextFiled.width = ScreenWidth - ScaleW(68) - ScaleW(54);
            [self addSubview:self.areaLabel];
        }
        
    }
    return self;
};

-(UITextField *)inputTextFiled{
    if (!_inputTextFiled) {
        _inputTextFiled = [WLTools allocTextFieldText:systemFont(ScaleW(13)) placeHolderFont:systemFont(ScaleW(13)) text:nil placeText:_placeHolder textColor:kMainTxtColor placeHolderTextColor:kGrayTxtColor frame:CGRectMake(ScaleW(34), 0, ScreenWidth - ScaleW(68), self.height)];
        _inputTextFiled.leftViewMode = UITextFieldViewModeAlways;
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(15), _inputTextFiled.height)];
        UILabel *pointLabel = [WLTools allocLabel:@"*" font:systemFont(ScaleW(13)) textColor:kRedColor frame:CGRectMake(0, 0, leftView.width, leftView.height) textAlignment:(NSTextAlignmentLeft)];
        if (_red) {
            [leftView addSubview:pointLabel];
            _inputTextFiled.leftView = leftView;
        }
       
       
       
    }
    return _inputTextFiled;
}
-(UILabel *)areaLabel{
    if (!_areaLabel) {
        _areaLabel = [WLTools allocLabel:@"+86" font:systemFont(ScaleW(13)) textColor:kGrayTxtColor frame:CGRectMake(ScaleW(34), ScaleW(15), ScaleW(45), ScaleW(23)) textAlignment:(NSTextAlignmentCenter)];
        _areaLabel.backgroundColor = kMainBgColor;
        _areaLabel.layer.cornerRadius = ScaleW(3);
    }
    return _areaLabel;
}

@end

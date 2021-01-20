//
//  JZDelegateView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/8/28.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "JZDelegateView.h"
@interface JZDelegateView()

@property (nonatomic,strong) UILabel *delageLabel;
@property (nonatomic,strong) UILabel *andLabel;
@property (nonatomic,strong) UILabel *topiclabel;
@end
@implementation JZDelegateView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self agreeLabel];
        [self delageLabel];
        [self andLabel];
        [self topiclabel];
    }
    return self;
}
-(UILabel *)agreeLabel{
    if (!_agreeLabel) {
        _agreeLabel = [WLTools allocLabel:@"登录注册表示我已同意" font:systemFont(ScaleW(12)) textColor:kMainTxtColor frame:CGRectZero textAlignment:(NSTextAlignmentLeft)];
        [self addSubview: _agreeLabel];
        [_agreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self);
            
        }];
    }
    return _agreeLabel;
}
-(UILabel *)delageLabel{
    if (!_delageLabel) {
        _delageLabel = [WLTools allocLabel:@"《用户协议》" font:systemFont(ScaleW(12)) textColor:kBlueColor frame:CGRectZero textAlignment:(NSTextAlignmentLeft)];
        [self addSubview: _delageLabel];
        [_delageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_agreeLabel.mas_right);
            make.height.equalTo(self.mas_height);
            make.top.equalTo(self);
        }];
        _delageLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userDeleageAction:)];
        [_delageLabel addGestureRecognizer:tap];
    }
    return _delageLabel;
}


-(UILabel *)andLabel{
    if (!_andLabel) {
        _andLabel = [WLTools allocLabel:@"和" font:systemFont(ScaleW(12)) textColor:kMainTxtColor frame:CGRectZero textAlignment:(NSTextAlignmentLeft)];
        [self addSubview: _andLabel];
        _andLabel.hidden = YES;
        [_andLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_delageLabel.mas_right).offset(3);
            make.top.equalTo(_delageLabel);
        }];
    }
    return _andLabel;
}
-(UILabel *)topiclabel{
    if (!_topiclabel) {
        _topiclabel = [WLTools allocLabel:@"《隐私政策》" font:systemFont(ScaleW(12)) textColor:kBlueColor frame:CGRectZero textAlignment:(NSTextAlignmentLeft)];
        [self addSubview: _topiclabel];
        _topiclabel.hidden = YES;
        [_topiclabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_andLabel.mas_right).offset(3);
            make.height.equalTo(self.mas_height);
            make.top.equalTo(self);
        }];
        _topiclabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sercuratAction:)];
        [_topiclabel addGestureRecognizer:tap];
    }
    return _topiclabel;
}
-(void)userDeleageAction:(id)sender{
    !self.userDelegateBlcok?:self.userDelegateBlcok();
}
-(void)sercuratAction:(id)sender{
    !self.securatyBlcok?:self.securatyBlcok();
}
@end

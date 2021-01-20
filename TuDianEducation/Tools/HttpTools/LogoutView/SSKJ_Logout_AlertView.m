//
//  ETF_Logout_AlertView.m
//  SSKJ
//
//  Created by 刘小雨 on 2018/10/9.
//  Copyright © 2018年 James. All rights reserved.
//

#import "SSKJ_Logout_AlertView.h"

@interface SSKJ_Logout_AlertView ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *showView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIButton *confirmButton;
@end

@implementation SSKJ_Logout_AlertView

-(instancetype)init
{
    if (self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)]) {

        
        [self addSubview:self.backView];
        [self addSubview:self.showView];
        [self.showView addSubview:self.titleLabel];
        [self.showView addSubview:self.messageLabel];
        [self.showView addSubview:self.confirmButton];
    }
    return self;
}

-(UIView *)backView
{
    if (nil == _backView) {
        _backView = [[UIView alloc]initWithFrame:self.bounds];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0.7;
        
    }
    return _backView;
}

-(UIImageView *)showView
{
    if (nil == _showView) {
        _showView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(32), 0, self.width - ScaleW(64), ScaleW(190))];
        _showView.backgroundColor = kMainBgColor;
        _showView.layer.masksToBounds = YES;
        _showView.layer.cornerRadius = 6.0f;
        _showView.center = CGPointMake(ScreenWidth / 2, ScreenHeight / 2);
        _showView.userInteractionEnabled = YES;
    }
    return _showView;
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"退出登录", nil)  font:systemFont(ScaleW(15)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(15), ScaleW(37), self.showView.width - ScaleW(30), ScaleW(15)) textAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

-(UILabel *)messageLabel
{
    if (nil == _messageLabel) {
        _messageLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(12)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(15), self.titleLabel.bottom + ScaleW(23), self.showView.width - ScaleW(30), ScaleW(30)) textAlignment:NSTextAlignmentCenter];
    }
    return _messageLabel;
}


-(UIButton *)confirmButton
{
    if (nil == _confirmButton) {

        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(50), self.messageLabel.bottom + ScaleW(14), ScaleW(100), ScaleW(35))];
        _confirmButton.centerX = self.showView.width / 2;
        [_confirmButton setTitle:SSKJLocalized(@"确定",nil) forState:UIControlStateNormal];
        [_confirmButton setTitleColor:kBlueColor forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = systemBoldFont(ScaleW(15));
        [_confirmButton addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

-(void)showWithMessage:(NSString *)message
{
    self.isShow = YES;
    self.messageLabel.text = message;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

-(void)hide
{
    self.isShow = NO;
    [self removeFromSuperview];
}


-(void)confirmEvent
{
    [self hide];
    if (self.confirmBlock) {
        self.confirmBlock();
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

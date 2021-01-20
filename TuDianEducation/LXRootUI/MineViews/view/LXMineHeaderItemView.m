//
//  LXMineHeaderItemView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/23.
//  Copyright © 2020 zhangbenchao. All rights reserved.

#import "LXMineHeaderItemView.h"
@interface LXMineHeaderItemView()
@property (nonatomic,strong) UIImage *img;
@property (nonatomic,strong) NSString *message;
@property (nonatomic,strong) UIButton *contentBtn;
@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UILabel *messageLabel;

@end

@implementation LXMineHeaderItemView

-(instancetype)initWithImge:(UIImage *)img message:(NSString *)message
{
    if (self = [super init]){
        _img = img;
        _message = message;
        [self viewConfig];
    }
    return self;
}
-(void)viewConfig
{
    self.frame = CGRectMake(0, 0, ScaleW(90), ScaleW(54));
    [self addSubview:self.contentBtn];
    [self addSubview:self.imgView];
    [self addSubview:self.messageLabel];
}
-(UIButton *)contentBtn
{
    if (!_contentBtn) {
        _contentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _contentBtn.frame = CGRectMake(0, 0, self.width, self.height);
        [_contentBtn btn:_contentBtn font:ScaleW(0) textColor:kMainBgColor text:@"" image:nil sel:@selector(contentBtnAction:) taget:self];
    }
    return _contentBtn;
}

-(UIImageView * )imgView
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _img.size.width, _img.size.height)];
        _imgView.image = _img;
        _imgView.centerX = self.width/2.f;
    }
    return _imgView;
}

-(UILabel *)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [WLTools allocLabel:_message font:systemFont(ScaleW(15)) textColor:kMainTxtColor frame:CGRectMake(0, self.height - ScaleW(18), self.width, ScaleW(18)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _messageLabel;
}
#pragma mark --Action

-(void)contentBtnAction:(UIButton *)btn
{
    !self.itemClickBlock?:self.itemClickBlock();
}
@end

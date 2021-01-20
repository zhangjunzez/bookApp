//
//  BottomItemView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/24.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//


#import "BottomItemView.h"
@interface BottomItemView()
@property (nonatomic,strong) UIImage *img;
@property (nonatomic,strong) NSString *message;
@property (nonatomic,strong) UIButton *contentBtn;
@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UILabel *messageLabel;

@end

@implementation BottomItemView

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
    self.frame = CGRectMake(0, 0, ScaleW(345/4.f), ScaleW(153/2.f));
    [self addSubview:self.contentBtn];
    [self addSubview:self.imgView];
    [self addSubview:self.messageLabel];
}
-(UIButton *)contentBtn
{
    if (!_contentBtn) {
        _contentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _contentBtn.frame = CGRectMake(0, 0, self.width, self.height);
        [_contentBtn btn:_contentBtn font:ScaleW(0) textColor:kWhiteColor text:@"" image:nil sel:@selector(contentBtnAction:) taget:self];
    }
    return _contentBtn;
}

-(UIImageView * )imgView
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, ScaleW(15), _img.size.width, _img.size.height)];
        _imgView.image = _img;
        _imgView.centerX = self.width/2.f;
    }
    return _imgView;
}

-(UILabel *)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [WLTools allocLabel:_message font:systemFont(ScaleW(12)) textColor:kMainTxtColor frame:CGRectMake(0, self.height - ScaleW(25), self.width, ScaleW(15)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _messageLabel;
}
#pragma mark --Action

-(void)contentBtnAction:(UIButton *)btn
{
    !self.itemClickBlock?:self.itemClickBlock(_index);
}
@end

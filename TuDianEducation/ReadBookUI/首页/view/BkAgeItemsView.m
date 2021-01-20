//
//  BkAgeItemsView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/12.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "BkAgeItemsView.h"
@interface BkAgeItemsView()

@end
@implementation BkAgeItemsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.headerImgView];
        [self addSubview:self.messageLabel];
        [self addSubview:self.selectBtn];
    }
    return self;
}

-(UIImageView *)headerImgView{
    if (!_headerImgView) {
        _headerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(46), ScaleW(46))];
        _headerImgView.cornerRadius = _headerImgView.height/2.f;
        _headerImgView.backgroundColor = kGrayBtnBacColor;
        _headerImgView.centerX = self.width/2.f;
    }
    return _headerImgView;
}

-(UILabel *)messageLabel{
    if (!_messageLabel) {
        _messageLabel = [WLTools allocLabel:@"9~12岁" font:systemFont(ScaleW(12)) textColor:kMainTxtColor frame:CGRectMake(0, _headerImgView.bottom + ScaleW(4), ScaleW(54), ScaleW(20)) textAlignment:(NSTextAlignmentCenter)];
        _messageLabel.centerX = self.width/2.f;
        _messageLabel.cornerRadius = _messageLabel.height/2.f;
    }
    return _messageLabel;
}

-(UIButton *)selectBtn{
    if (!_selectBtn) {
        _selectBtn = [WLTools allocButtonTitle:@"" font:systemFont(ScaleW(0)) textColor:kWhiteColor image:nil frame:CGRectMake(0, 0, self.width, self.height) sel:@selector(selectAction:) taget:self];
    }
    return _selectBtn;
}

-(void)selectAction:(UIButton *)sender
{
    !self.selectBlock?:self.selectBlock(self);
}

-(void)setItemsSelct:(BOOL)selct
{
    if (selct) {
        self.messageLabel.backgroundColor = UIColorFromRGB(0xEFFFF6);
        self.messageLabel.textColor = kGreenColor;
    }else{
        self.messageLabel.backgroundColor = kWhiteColor;
        self.messageLabel.textColor = kMainTxtColor;
    }
};
@end

//
//  BkFaceDetailSelectView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/12.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "BkFaceDetailSelectView.h"
@interface BkFaceDetailSelectView()

@end
@implementation BkFaceDetailSelectView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(50));
        [self addSubview:self.allCommendsBtn];
        [self addSubview:self.onlyAuthsBtn];
        [self addSubview:self.timeShowBtn];
        self.backgroundColor = kWhiteColor;
        [self.allCommendsBtn sendActionsForControlEvents:(UIControlEventTouchUpInside)];
    }
    return self;
}
-(UIButton *)allCommendsBtn{
    if (!_allCommendsBtn) {
        _allCommendsBtn = [WLTools allocButtonTitle:@"全部评论" font:systemFont(ScaleW(12)) textColor:kSubTxtColor image:nil frame:CGRectMake(0, 0, ScaleW(75), self.height) sel:@selector(allCommendsBtnAction:) taget:self];
        [_allCommendsBtn setTitleColor:kMainTxtColor forState:(UIControlStateSelected)];
        
    }
    return _allCommendsBtn;
}

-(void)allCommendsBtnAction:(UIButton *)sender
{
    sender.selected = YES;
    sender.titleLabel.font = systemBoldFont(ScaleW(13));
    _onlyAuthsBtn.titleLabel.font = systemFont(ScaleW(12));
    _onlyAuthsBtn.selected = NO;
    
}
-(UIButton *)onlyAuthsBtn{
    if (!_onlyAuthsBtn) {
        _onlyAuthsBtn = [WLTools allocButtonTitle:@"只看作者" font:systemFont(ScaleW(12)) textColor:kSubTxtColor image:nil frame:CGRectMake(_allCommendsBtn.right, 0, ScaleW(75), self.height) sel:@selector(onlyAuthsBtnAction:) taget:self];
        [_onlyAuthsBtn setTitleColor:kMainTxtColor forState:(UIControlStateSelected)];
    }
    return _onlyAuthsBtn;
}

-(void)onlyAuthsBtnAction:(UIButton *)sender
{
    sender.selected = YES;
    sender.titleLabel.font = systemBoldFont(ScaleW(13));
    _allCommendsBtn.titleLabel.font = systemFont(ScaleW(12));
    _allCommendsBtn.selected = NO;
}



-(UIButton *)timeShowBtn{
    if (!_timeShowBtn) {
        _timeShowBtn = [WLTools allocButtonTitle:@"时间正序" font:systemFont(ScaleW(12)) textColor:kGreenColor image:[UIImage imageNamed:@"下拉"] frame:CGRectMake(_allCommendsBtn.right, ScaleW(10), ScaleW(75), ScaleW(22)) sel:@selector(timeShowBtnAction:) taget:self];
        [_timeShowBtn setTitleColor:kMainTxtColor forState:(UIControlStateSelected)];
        [_timeShowBtn setCornerRadius:_timeShowBtn.height/2.f];
        [_timeShowBtn setBorderWithWidth:1 andColor:kGreenColor];
        [_timeShowBtn setBtnLeftLabelRightImgOffSet:ScaleW(5)];
        _timeShowBtn.right = self.width - ScaleW(12);
    }
    return _timeShowBtn;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(11), self.height - .5f, self.width - ScaleW(22), .5f)];
        _lineView.backgroundColor = kMainLineColor;
    }
    return _lineView;
}
-(void)timeShowBtnAction:(UIButton *)sender
{
    !self.timeShowBlock?:self.timeShowBlock();
}

@end

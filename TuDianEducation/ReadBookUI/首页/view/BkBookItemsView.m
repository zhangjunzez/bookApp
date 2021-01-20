//
//  BkBookItemsView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/12.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "BkBookItemsView.h"
@interface BkBookItemsView()

@end

@implementation BkBookItemsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kSubBacColor;
        [self addSubview:self.nameLabel];
        [self addSubview:self.subNameLabel];
        [self addSubview:self.bookImgView];
        self.cornerRadius = ScaleW(5);
        UIButton *conBtn = [WLTools allocButtonTitle:@"" font:systemFont(0) textColor:kWhiteColor image:nil frame:CGRectMake(0, 0, self.width, self.height) sel:@selector(selectBtnAction:) taget:self];
        [self addSubview:conBtn];
    }
    return self;
}
-(void)selectBtnAction:(UIButton *)sender
{
    !self.selctBlock?:self.selctBlock(self);
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [WLTools allocLabel:@"科普百科" font:systemBoldFont(ScaleW(15)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(13), ScaleW(17), ScaleW(100), ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _nameLabel;
}


-(UILabel *)subNameLabel{
    if (!_subNameLabel) {
        _subNameLabel = [WLTools allocLabel:@"感受学习的乐趣" font:systemFont(ScaleW(12)) textColor:kGrayTxtColor frame:CGRectMake(_nameLabel.left, _nameLabel.bottom + ScaleW(10), _nameLabel.width, ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _subNameLabel;
}

-(UIImageView *)bookImgView{
    if (!_bookImgView) {
        _bookImgView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(112), ScaleW(14), ScaleW(40), ScaleW(40))];
        _bookImgView.backgroundColor = kGrayTxtColor;
    }
    return _bookImgView;
}




@end

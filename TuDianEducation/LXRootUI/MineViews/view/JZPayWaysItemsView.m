//
//  JZPayWaysItemsView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/9/2.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "JZPayWaysItemsView.h"
@interface JZPayWaysItemsView()



@property (nonatomic,strong) NSString *headerImg;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *subName;
@end

@implementation JZPayWaysItemsView

-(instancetype)initWiteTop:(CGFloat)top headerImg:(NSString *)headerImg name:(NSString *)name subName:(NSString*)subName
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, top, ScreenWidth, ScaleW(30));
        self.headerImg = headerImg;
        self.name = name;
        self.subName = subName;
        [self addSubview:self.headerImgView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.subNameLabel];
        [self addSubview:self.beSelectBtn];
    }
    return self;
};
-(UIImageView *)headerImgView{
    if (!_headerImgView) {
        _headerImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:_headerImg]];
        _headerImgView.left = ScaleW(20);
        _headerImgView.centerY = self.height/2.f;
    }
    return _headerImgView;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [WLTools allocLabel:_name font:systemFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(14) + _headerImgView.right, 0, ScaleW(70), ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
        _nameLabel.centerY = _headerImgView.centerY;
    }
    return _nameLabel;
}
-(UITextField *)subNameLabel{
    if (!_subNameLabel) {
        //_subNameLabel = [WLTools allocLabel:_subName font:systemFont(ScaleW(12)) textColor:kSubTxtColor frame:CGRectMake(_nameLabel.right, 0, ScaleW(200), ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
        _subNameLabel = [WLTools allocTextFieldText:systemFont(ScaleW(12))  placeHolderFont:systemFont(ScaleW(12))  text:nil placeText:@"请输入账号" textColor:kMainTxtColor placeHolderTextColor:kGrayTxtColor frame:CGRectMake(_nameLabel.right, 0, ScaleW(200), ScaleW(12))];
        _subNameLabel.centerY = _nameLabel.centerY;
    }
    return _subNameLabel;
}

-(UIButton *)beSelectBtn{
    if (!_beSelectBtn) {
        _beSelectBtn  = [WLTools allocButtonTitle:@"" font:systemFont(0) textColor:kWhiteColor image:[UIImage imageNamed:@"weixuanzhong"] frame:CGRectMake(self.width - ScaleW(54), 0, ScaleW(54), self.height) sel:@selector(beSelectBtnAction:) taget:self];
        [_beSelectBtn setImage:[UIImage imageNamed:@"xuanzhong"] forState:(UIControlStateSelected)];
    }
    return _beSelectBtn;
}

-(void)beSelectBtnAction:(UIButton *)sender{
//    sender.selected = !sender.selected;
    sender.selected = YES;
    if (self.selectBlock) {
        self.selectBlock(sender.selected);
    }
}
@end

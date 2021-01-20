//
//  BkAgeCollectionViewCell.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/12.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "BkAgeCollectionViewCell.h"
@interface BkAgeCollectionViewCell()
@property (nonatomic,strong) UIImageView *headImgView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *xxPriceLabel;

@property (nonatomic,strong) UIButton *gouwucheBtn;
@end

@implementation BkAgeCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = kSubBacColor;
        [self.contentView addSubview:self.headImgView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.xxPriceLabel];
        [self.contentView addSubview:self.priceLabel];
        [self.contentView addSubview:self.gouwucheBtn];
        [self.contentView setCornerRadius:ScaleW(5)];
    }
    return self;
}
-(UIImageView *)headImgView{
    if (!_headImgView) {
        _headImgView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(35), ScaleW(13), ScaleW(54), ScaleW(78))];
        _headImgView.backgroundColor = kGrayTxtColor;
        
    }
    return _headImgView;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [WLTools allocLabel:@"初中数学运算能手" font:systemFont(ScaleW(10)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(8), ScaleW(11) + _headImgView.bottom, self.width - ScaleW(28), ScaleW(10)) textAlignment:(NSTextAlignmentLeft)];
        //_nameLabel.numberOfLines = 2;
    }
    return _nameLabel;
}


-(UILabel *)xxPriceLabel{
    if (!_xxPriceLabel) {
        _xxPriceLabel = [WLTools allocLabel:@"￥93" font:systemFont(ScaleW(8)) textColor:kGrayTxtColor frame:CGRectMake(_nameLabel.left, _nameLabel.bottom + ScaleW(12) , _nameLabel.width, ScaleW(8)) textAlignment:(NSTextAlignmentLeft)];
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:_xxPriceLabel.text attributes:attribtDic];
        _xxPriceLabel.attributedText = attribtStr;
    }
    return _xxPriceLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [WLTools allocLabel:@"￥88.88" font:systemFont(ScaleW(8)) textColor:kRedColor frame:CGRectMake(_nameLabel.left, ScaleW(5) + _xxPriceLabel.bottom, _nameLabel.width, ScaleW(10)) textAlignment:(NSTextAlignmentLeft)];
        
        NSString *string = _priceLabel.text;
        NSMutableAttributedString *atts = [[NSMutableAttributedString alloc] initWithString:string];
        [atts setAttributes:@{NSFontAttributeName:systemBoldFont(ScaleW(10))} range:NSMakeRange(1,  string.length - 4)];
        _priceLabel.attributedText = atts;
    }
    return _priceLabel;
}
-(UIButton *)gouwucheBtn{
    if (!_gouwucheBtn) {
        _gouwucheBtn = [WLTools allocButtonTitle:@"" font:systemFont(ScaleW(0)) textColor:kWhiteColor image:[UIImage imageNamed:@"gouwuche_01"] frame:CGRectMake(ScaleW(88), ScaleW(125), ScaleW(25), ScaleW(25)) sel:@selector(gouwucheBtnAction:) taget:self];
    }
    return _gouwucheBtn;
}

-(void)gouwucheBtnAction:(UIButton *)sender
{
    
}
@end

//
//  BKScoreCollectionViewCell.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/7.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//


#import "BKScoreCollectionViewCell.h"
@interface BKScoreCollectionViewCell()
@property (nonatomic,strong) UIImageView *headImgView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *xxPriceLabel;


@end

@implementation BKScoreCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = kWhiteColor;
        [self.contentView addSubview:self.headImgView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.priceLabel];
        [self.contentView addSubview:self.xxPriceLabel];
    }
    return self;
}
-(UIImageView *)headImgView{
    if (!_headImgView) {
        _headImgView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(44), ScaleW(18), ScaleW(80), ScaleW(107))];
        _headImgView.backgroundColor = kSubBacColor;
        
    }
    return _headImgView;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [WLTools allocLabel:@"初中数学运算能手" font:systemFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(12), ScaleW(19) + _headImgView.bottom, self.width - ScaleW(28), ScaleW(13)) textAlignment:(NSTextAlignmentLeft)];
        //_nameLabel.numberOfLines = 2;
    }
    return _nameLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [WLTools allocLabel:@"10000积分" font:systemFont(ScaleW(12)) textColor:kRedColor frame:CGRectMake(_nameLabel.left, ScaleW(15) + _nameLabel.bottom, _nameLabel.width, ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _priceLabel;
}

-(UILabel *)xxPriceLabel{
    if (!_xxPriceLabel) {
        _xxPriceLabel = [WLTools allocLabel:@"￥93" font:systemFont(ScaleW(12)) textColor:kGrayTxtColor frame:CGRectMake(_nameLabel.left, _priceLabel.top , _nameLabel.width, ScaleW(12)) textAlignment:(NSTextAlignmentRight)];
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:_xxPriceLabel.text attributes:attribtDic];
        _xxPriceLabel.attributedText = attribtStr;
    }
    return _xxPriceLabel;
}

@end

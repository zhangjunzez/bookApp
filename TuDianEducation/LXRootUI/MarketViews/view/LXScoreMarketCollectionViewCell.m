//
//  LXScoreMarketCollectionViewCell.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/2.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXScoreMarketCollectionViewCell.h"
@interface LXScoreMarketCollectionViewCell()
@property (nonatomic,strong) UIImageView *headImgView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *alreadyLabel;


@end

@implementation LXScoreMarketCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = kWhiteColor;
        [self.contentView addSubview:self.headImgView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.priceLabel];
        [self.contentView addSubview:self.alreadyLabel];
    }
    return self;
}
-(UIImageView *)headImgView{
    if (!_headImgView) {
        _headImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, ScaleW(168))];
        _headImgView.backgroundColor = kBlueColor;
        
    }
    return _headImgView;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [WLTools allocLabel:@"【可味】开心果连贯500g分2罐装原味坚果" font:systemFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(5), ScaleW(14) + _headImgView.bottom, self.width - ScaleW(10), ScaleW(35)) textAlignment:(NSTextAlignmentLeft)];
        _nameLabel.numberOfLines = 2;
    }
    return _nameLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [WLTools allocLabel:@"10000积分" font:systemFont(ScaleW(12)) textColor:kRedColor frame:CGRectMake(_nameLabel.left, ScaleW(10) + _nameLabel.bottom, _nameLabel.width, ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _priceLabel;
}

-(UILabel *)alreadyLabel{
    if (!_alreadyLabel) {
        _alreadyLabel = [WLTools allocLabel:@"已兑换5000件" font:systemFont(ScaleW(12)) textColor:kGrayTxtColor frame:CGRectMake(_nameLabel.left, _priceLabel.bottom + ScaleW(5), _nameLabel.width, ScaleW(12)) textAlignment:(NSTextAlignmentRight)];
    }
    return _alreadyLabel;
}
-(void)setModel:(LXMarketGoodsListModel *)model
{
    _model = model;
    NSString *string = [WLTools imageURLWithURL:_model.goodsimage];
    [_headImgView sd_setImageWithURL:[NSURL URLWithString:string]];
    _nameLabel.text = _model.goodsname;
    _priceLabel.text = [self returnStringForShow:_model.goodsprice1 price2:_model.goodsprice];
    _alreadyLabel.text =_model.goodsstock.integerValue?[NSString stringWithFormat:@"库存%@件",_model.goodsstock]:@"已兑换完";
    
}

-(NSString *)returnStringForShow:(NSString *)price1 price2:(NSString *)price2{
    if (price1.doubleValue == 0) {
        return  [NSString stringWithFormat:@"%@积分",price2];
    }
    if (price2.doubleValue == 0) {
        return  [NSString stringWithFormat:@"￥%@",price1];
    }
    if (price2.doubleValue != 0 &&price1.doubleValue != 0) {
        return  [NSString stringWithFormat:@"￥%@+%@积分",price1,price2];
    }
    return @"免费";
}


@end

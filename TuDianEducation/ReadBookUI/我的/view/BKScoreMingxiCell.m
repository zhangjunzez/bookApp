//
//  BKScoreMingxiCell.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/7.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//


#import "BKScoreMingxiCell.h"


@interface BKScoreMingxiCell()
@property (nonatomic, strong) UIView *bacView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *subNameLabel;
@property (nonatomic, strong) UILabel *dateLable;
@property (nonatomic, strong) UIView *septorLine;
@end

@implementation BKScoreMingxiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self viewConfig];
    }
    return self;
}
-(void)viewConfig
{   self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = kMainBgColor;
    [self.contentView addSubview:self.bacView];
    [self.bacView addSubview:self.nameLabel];
    [self.bacView addSubview:self.moneyLabel];
    [self.bacView addSubview:self.subNameLabel];
    [self.bacView addSubview:self.dateLable];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(70) - 1, self.bacView.width - ScaleW(30), 1)];
    lineView.backgroundColor = kMainLineColor;
    [self.bacView addSubview:lineView];
    
}
-(UIView *)bacView{
    if (!_bacView) {
        _bacView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(0), 0, ScreenWidth, ScaleW(70))];
        _bacView.backgroundColor = kWhiteColor;
    }
    return _bacView;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [WLTools allocLabel:@"购物消费" font:systemBoldFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(15), ScaleW(20), _bacView.width - ScaleW(15)*2, ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _nameLabel;
}
-(UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [WLTools allocLabel:@"+￥0" font:systemBoldFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(15), ScaleW(20), _bacView.width - ScaleW(15)*2, ScaleW(14)) textAlignment:(NSTextAlignmentRight)];
    }
    return _moneyLabel;
}
-(UILabel *)subNameLabel{
    if (!_subNameLabel) {
        _subNameLabel = [WLTools allocLabel:@"购买书籍送积分" font:systemFont(ScaleW(11)) textColor:kSubTxtColor frame:CGRectMake(ScaleW(15), ScaleW(10) + _nameLabel.bottom, _bacView.width - ScaleW(15)*2, ScaleW(11)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _subNameLabel;
}
-(UILabel *)dateLable{
    if (!_dateLable) {
        _dateLable = [WLTools allocLabel:@"2020-04-09 00:00:00" font:systemFont(ScaleW(10)) textColor:kGrayTxtColor frame:CGRectMake(ScaleW(15), ScaleW(10) + _moneyLabel.bottom, _bacView.width - ScaleW(15)*2, ScaleW(10)) textAlignment:(NSTextAlignmentRight)];
        _dateLable.centerY = _subNameLabel.centerY;
    }
    return _dateLable;
}

@end

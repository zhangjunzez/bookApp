//
//  DJListTableViewCell.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/7.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "DJListTableViewCell.h"


@interface DJListTableViewCell()
@property (nonatomic, strong) UIView *bacView;
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic, strong) UILabel *dateLable;
@property (nonatomic,strong) UILabel *statusLabel;
@property (nonatomic,strong) UIImageView *headerImgView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic,strong) UILabel *scoreLabel;
@property (nonatomic, strong) UILabel *amountLabel;


@end

@implementation DJListTableViewCell

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
    [self.bacView addSubview:self.headerView];
    [self.bacView addSubview:self.headerImgView];
    [self.bacView addSubview:self.nameLabel];
    [self.bacView addSubview:self.scoreLabel];
    [self.bacView addSubview:self.moneyLabel];
    [self.bacView addSubview:self.amountLabel];
    
}
-(UIView *)bacView{
    if (!_bacView) {
        _bacView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(0), 0, ScreenWidth, ScaleW(107))];
        _bacView.backgroundColor = kWhiteColor;
    }
    return _bacView;
}
-(UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(30))];
        _headerView.backgroundColor = UIColorFromRGB(0xEAF3F7);
        [_headerView addSubview:self.dateLable];
        [_headerView addSubview:self.statusLabel];
    }
    return _headerView;
}
-(UILabel *)dateLable{
    if (!_dateLable) {
        _dateLable = [WLTools allocLabel:@"2020-04-09 00:00" font:systemFont(ScaleW(12)) textColor:UIColorFromRGB(0x6CB4D1) frame:CGRectMake(ScaleW(11), 0, _headerView.width - ScaleW(11)*2, ScaleW(30)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _dateLable;
}
-(UILabel *)statusLabel{
    if (!_statusLabel) {
        _statusLabel = [WLTools allocLabel:@"已兑换" font:systemFont(ScaleW(13)) textColor:UIColorFromRGB(0x6CB4D1) frame:CGRectMake(ScaleW(11), 0, _headerView.width - ScaleW(11)*2, ScaleW(30)) textAlignment:(NSTextAlignmentRight)];
        _statusLabel.centerY = _dateLable.centerY;
    }
    return _statusLabel;
}
-(UIImageView *)headerImgView{
    if (!_headerImgView) {
        _headerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(11), ScaleW(13) + _headerView.bottom, ScaleW(45), ScaleW(45))];
        _headerImgView.backgroundColor = kGrayTxtColor;
        
    }
    return _headerImgView;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [WLTools allocLabel:@"购物消费" font:systemBoldFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(13) + _headerImgView.right, ScaleW(16) + _headerView.bottom, ScaleW(230), ScaleW(13)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _nameLabel;
}
-(UILabel *)scoreLabel{
    if (!_scoreLabel) {
        _scoreLabel = [WLTools allocLabel:@"1000积分" font:systemBoldFont(ScaleW(14)) textColor:kRedColor frame:CGRectMake(ScaleW(13) + _headerImgView.right, ScaleW(16) + _headerView.bottom, ScaleW(230), ScaleW(13)) textAlignment:(NSTextAlignmentRight)];
        _scoreLabel.right = self.bacView.width - ScaleW(11);
    }
    return _scoreLabel;
}
-(UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [WLTools allocLabel:@"￥0.00" font:systemFont(ScaleW(13)) textColor:kGrayTxtColor frame:CGRectMake(_nameLabel.left, _nameLabel.bottom + ScaleW(10), _nameLabel.width, ScaleW(13)) textAlignment:(NSTextAlignmentLeft)];
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
       NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:_moneyLabel.text attributes:attribtDic];
        _moneyLabel.attributedText = attribtStr;
    }
    return _moneyLabel;
}
-(UILabel *)amountLabel{
    if (!_amountLabel) {
        _amountLabel = [WLTools allocLabel:@"x1" font:systemFont(ScaleW(12)) textColor:kMainTxtColor frame:CGRectMake(_scoreLabel.left, ScaleW(20) + _scoreLabel.bottom, _scoreLabel.width, ScaleW(12)) textAlignment:(NSTextAlignmentRight)];
    }
    return _amountLabel;
}

@end

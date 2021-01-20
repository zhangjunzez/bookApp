//
//  LXMineMoneyRecodeTableViewCell.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/24.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXMineMoneyRecodeTableViewCell.h"

#import "LXMoneyModel.h"

@interface LXMineMoneyRecodeTableViewCell()
@property (nonatomic, strong) UIView *bacView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UILabel *dateLable;
@property (nonatomic, strong) UIView *septorLine;
@end

@implementation LXMineMoneyRecodeTableViewCell

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
    [self.bacView addSubview:self.userNameLabel];
    [self.bacView addSubview:self.moneyLabel];
    [self.bacView addSubview:self.statusLabel];
    [self.bacView addSubview:self.dateLable];
    //[self.bacView addSubview:self.septorLine];
}
-(UIView *)bacView{
    if (!_bacView) {
        _bacView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), 0, ScaleW(342), ScaleW(75))];
        _bacView.backgroundColor = kWhiteColor;
        [_bacView setCornerRadius:ScaleW(8)];
    }
    return _bacView;
}
-(UILabel *)userNameLabel{
    if (!_userNameLabel) {
        _userNameLabel = [WLTools allocLabel:@"用户名称" font:systemBoldFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(15), ScaleW(20), _bacView.width - ScaleW(15)*2, ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _userNameLabel;
}
-(UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [WLTools allocLabel:@"+0" font:systemFont(ScaleW(16)) textColor:kRedColor frame:CGRectMake(ScaleW(15), ScaleW(20), _bacView.width - ScaleW(15)*2, ScaleW(16)) textAlignment:(NSTextAlignmentRight)];
    }
    return _moneyLabel;
}
-(UILabel *)statusLabel{
    if (!_statusLabel) {
        _statusLabel = [WLTools allocLabel:@"充值" font:systemFont(ScaleW(12)) textColor:kGrayTxtColor frame:CGRectMake(ScaleW(15), ScaleW(13) + _userNameLabel.bottom, _bacView.width - ScaleW(15)*2, ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _statusLabel;
}
-(UILabel *)dateLable{
    if (!_dateLable) {
        _dateLable = [WLTools allocLabel:@"2020-04-09 00:00:00" font:systemFont(ScaleW(12)) textColor:kGrayTxtColor frame:CGRectMake(ScaleW(15), ScaleW(15) + _moneyLabel.bottom, _bacView.width - ScaleW(15)*2, ScaleW(12)) textAlignment:(NSTextAlignmentRight)];
        _dateLable.centerY = _statusLabel.centerY;
    }
    return _dateLable;
}
-(void)setModel:(LXMoneyModel *)model{
    _model = model;
    _userNameLabel.text = _model.title;
    NSString *status = @"";
    //类型 0分销收益 1需求收益 2服务收益 3申请提现 4提现返还
    switch (_model.type.integerValue) {
        case 0:
            status = @"分销收益";
            break;
        case 1:
            status = @"需求收益";
            break;
        case 2:
            status = @"服务收益";
            break;
        case 3:
            status = @"申请提现";
            break;
        case 4:
            status = @"提现返还";
            break;
        default:
            break;
    }
    _statusLabel.text = status;
    _moneyLabel.text = _model.money;
    _dateLable.text = _model.adtime;
}

@end

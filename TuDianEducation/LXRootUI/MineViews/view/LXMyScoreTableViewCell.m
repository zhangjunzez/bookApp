//
//  LXMyScoreTableViewCell.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/24.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXMyScoreTableViewCell.h"
#import "LXScoreListModel.h"
@interface LXMyScoreTableViewCell()
@property (nonatomic, strong) UIView *bacView;


@property (nonatomic, strong) UIView *septorLine;
@end

@implementation LXMyScoreTableViewCell

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
        _moneyLabel = [WLTools allocLabel:@"+0" font:systemFont(ScaleW(16)) textColor:kRedColor frame:CGRectMake(ScaleW(15), ScaleW(0), _bacView.width - ScaleW(15)*2, _bacView.height) textAlignment:(NSTextAlignmentRight)];
    }
    return _moneyLabel;
}

-(UILabel *)dateLable{
    if (!_dateLable) {
        _dateLable = [WLTools allocLabel:@"2020-04-09 00:00:00" font:systemFont(ScaleW(12)) textColor:kGrayTxtColor frame:CGRectMake(ScaleW(15), ScaleW(15) + _userNameLabel.bottom, _bacView.width - ScaleW(15)*2, ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _dateLable;
}
-(void)setModel:(LXScoreListModel *)model{
    _model = model;
    _userNameLabel.text = _model.title;
    _dateLable.text = _model.adtime;
    _moneyLabel.text = _model.money;
//    if (_model.type.integerValue == 0) {
//
//    }
//    if (_model.type.integerValue == 1) {
//
//    }
}

@end

//
//  LXGetMoneyRecodeTableViewCell.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/28.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//


#import "LXGetMoneyRecodeTableViewCell.h"

#import "LXGetMoneyRecodeModel.h"
@interface LXGetMoneyRecodeTableViewCell()
@property (nonatomic, strong) UIView *bacView;
@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic,strong) UIImageView *statusImg;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UILabel *dateLable;
@property (nonatomic, strong) UIView *septorLine;
@end

@implementation LXGetMoneyRecodeTableViewCell

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
    [self.bacView addSubview:self.amountLabel];
    [self.bacView addSubview:self.statusImg];
    [self.bacView addSubview:self.dateLable];
    [self.bacView addSubview:self.statusImg];
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
-(UILabel *)amountLabel{
    if (!_amountLabel) {
        _amountLabel = [WLTools allocLabel:@"用户名称" font:systemBoldFont(ScaleW(16)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(15), ScaleW(20), _bacView.width - ScaleW(15)*2, ScaleW(16)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _amountLabel;
}


-(UILabel *)dateLable{
    if (!_dateLable) {
        _dateLable = [WLTools allocLabel:@"2020-04-09 00:00:00" font:systemFont(ScaleW(12)) textColor:kGrayTxtColor frame:CGRectMake(ScaleW(15), ScaleW(15) + _amountLabel.bottom, _bacView.width - ScaleW(15)*2, ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _dateLable;
}
-(UIImageView *)statusImg{
    if (!_statusImg) {
        _statusImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(280), ScaleW(19), ScaleW(47), ScaleW(36))];
    }
    return _statusImg;
}
-(void)setModel:(LXGetMoneyRecodeModel *)model{
    _model= model;
    _amountLabel.text = _model.money;
    if (_model.state.integerValue == 0) {
        _dateLable.text = _model.adtime;
    }else{
        _dateLable.text = _model.endtime;
    }
    NSString *stausImgName = @"";
    if (_model.state.integerValue == 0) {
        ///待审核
        stausImgName = @"tixian_daishenhe";
    }
    if (_model.state.integerValue == 1) {
        ///成功
        stausImgName = @"tixian_chenggong";
    }
    if (_model.state.integerValue == 2) {
           ///失败
           stausImgName = @"tixian_shibai";
       }
    _statusImg.image = [UIImage imageNamed:stausImgName];
}

@end

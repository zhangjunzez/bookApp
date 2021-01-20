//
//  LXTuijianTableViewCell.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/24.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//



#import "LXTuijianTableViewCell.h"
#import "LXMyTuijianModel.h"
#import "LXLearnModel.h"

@interface LXTuijianTableViewCell()
@property (nonatomic, strong) UIView *bacView;
@property (nonatomic,strong) UIImageView *headerImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *dateLabel;
@property (nonatomic, strong) UIView *septorLine;

@end

@implementation LXTuijianTableViewCell

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
    self.contentView.backgroundColor = kWhiteColor;
    [self.contentView addSubview:self.bacView];
    [self.bacView addSubview:self.headerImage];
    [self.bacView addSubview:self.nameLabel];
    [self.bacView addSubview:self.dateLabel];
    [self.bacView addSubview:self.septorLine];
}
-(UIView *)bacView{
    if (!_bacView) {
        _bacView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(70))];
        _bacView.backgroundColor = kWhiteColor;
    }
    return _bacView;
}
-(UIImageView *)headerImage{
    if (!_headerImage) {
        _headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(13), ScaleW(44), ScaleW(44))];
        _headerImage.backgroundColor = kGrayTxtColor;
        [_headerImage setCornerRadius:_headerImage.height/2.f];
    }
    return _headerImage;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [WLTools allocLabel:@"水木丹青" font:systemFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(10) + _headerImage.right, 0, _bacView.width - ScaleW(70 +15), ScaleW(70)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _nameLabel;
}
-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [WLTools allocLabel:@"注册时间：2020-03-29" font:systemFont(ScaleW(13)) textColor:kSubTxtColor frame:CGRectMake(ScaleW(10) + _headerImage.right, 0, _bacView.width - ScaleW(70 +15), ScaleW(70)) textAlignment:(NSTextAlignmentRight)];
    }
    return _dateLabel;
}
-(UIView *)septorLine
{
    if (!_septorLine) {
        _septorLine = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), 0, _bacView.width - ScaleW(30), .5)];
        _septorLine.bottom = ScaleW(70) - 1;
        _septorLine.backgroundColor = kMainBgColor;
    }
    return _septorLine;
}
-(void)setModel:(LXMyTuijianModel *)model{
    _model = model;
    _nameLabel.text = _model.username?:_model.engineername;
    _dateLabel.text = [NSString stringWithFormat:@"注册时间:%@",_model.adtime];
    [_headerImage sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:_model.userimage?:_model.engineericon]]];
}
-(void)setStudyModel:(LXLearnModel *)studyModel
{
    _studyModel = studyModel;
    _nameLabel.text = _studyModel.engineername;
    _dateLabel.text = [NSString stringWithFormat:@"学习时间:%@分钟",_studyModel.studytime];
    [_headerImage sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:_studyModel.engineericon]]];
}
@end

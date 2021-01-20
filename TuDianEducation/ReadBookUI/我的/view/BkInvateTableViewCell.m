//
//  BkInvateTableViewCell.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/11.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//


#import "BkInvateTableViewCell.h"


@interface BkInvateTableViewCell()
@property (nonatomic, strong) UIView *bacView;

@property (nonatomic,strong) UIImageView *headerImgView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *dataLabel;
@property (nonatomic,strong) UILabel *contentLabel;


@end

@implementation BkInvateTableViewCell

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

    [self.contentView addSubview:self.bacView];
    [self.bacView addSubview:self.headerImgView];
    [self.bacView addSubview:self.nameLabel];
    [self.bacView addSubview:self.dataLabel];
    [self.bacView addSubview:self.contentLabel];
}

-(UIView *)bacView{
    if (!_bacView) {
        _bacView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(14), ScaleW(0), ScreenWidth , ScaleW(70))];
        _bacView.backgroundColor = kWhiteColor;
    }
    return _bacView;
}
-(UIImageView *)headerImgView{
    if (!_headerImgView) {
        _headerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(11), ScaleW(15) , ScaleW(40), ScaleW(40))];
        _headerImgView.backgroundColor = kGrayTxtColor;
        _headerImgView.cornerRadius = _headerImgView.height/2.f;

    }
    return _headerImgView;
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [WLTools allocLabel:@"桑娜啊~" font:systemFont(ScaleW(15)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(11) + _headerImgView.right, _headerImgView.top, ScaleW(284), ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _nameLabel;
}

-(UILabel *)dataLabel{
    if (!_dataLabel) {
        _dataLabel = [WLTools allocLabel:@"2020.12.02  16:20" font:systemFont(ScaleW(11)) textColor:kGrayTxtColor frame:CGRectMake(_nameLabel.left, _headerImgView.top, ScaleW(284), ScaleW(15))  textAlignment:(NSTextAlignmentRight)];
    }
    return _dataLabel;
}
-(UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [WLTools allocLabel:@"累计消费：1000  累计回报：1000" font:systemFont(ScaleW(12)) textColor:kMainTxtColor frame:CGRectMake(_nameLabel.left, ScaleW(10) + _nameLabel.bottom, ScaleW(284), ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _contentLabel;
}
@end

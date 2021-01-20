//
//  LXNewsTableViewCell.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/30.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//


#import "LXNewsTableViewCell.h"
#import "LXNewsModel.h"

@interface LXNewsTableViewCell()
@property (nonatomic,strong) UILabel *headerLabel;
@property (nonatomic,strong) UIImageView *contenImg;
@property (nonatomic, strong) UILabel *dateLable;
@property (nonatomic,strong) UIView *septorLine;


@end

@implementation LXNewsTableViewCell

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
    [self.contentView addSubview:self.headerLabel];
    [self.contentView addSubview:self.contenImg];
    [self.contentView addSubview:self.dateLable];
    [self.contentView addSubview:self.septorLine];
}
-(UILabel *)headerLabel{
    if (!_headerLabel) {
        _headerLabel = [WLTools allocLabel:@"资讯标题名称资讯标题名称资讯标题名称资讯标题名称资讯标题名称" font:systemFont(ScaleW(17)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(15), ScaleW(17),ScreenWidth - ScaleW(30), ScaleW(40)) textAlignment:(NSTextAlignmentLeft)];
        _headerLabel.numberOfLines = 2;
    }
    return _headerLabel;
}
-(UIImageView *)contenImg{
    if (!_contenImg) {
        _contenImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(10) + _headerLabel.bottom , _headerLabel.width,ScaleW(195))];
        _contenImg.backgroundColor = kGrayBtnBacColor;
        [_contenImg setCornerRadius:ScaleW(5)];
    }
    return _contenImg;
}
-(UILabel *)dateLable{
    if (!_dateLable) {
        _dateLable = [WLTools allocLabel:@"发布时间：2020-3-12   16：46" font:systemFont(13) textColor:kGrayTxtColor frame:CGRectMake(_headerLabel.left, _contenImg.bottom + ScaleW(8), _headerLabel.width, ScaleW(13)) textAlignment:(NSTextAlignmentLeft)];
        _dateLable.hidden = YES;
    }
    return _dateLable;
}
-(UIView *)septorLine
{
    if (!_septorLine) {
        _septorLine = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), 0, ScreenWidth - ScaleW(30), .5)];
        _septorLine.bottom = ScaleW(292) - 1;
        _septorLine.backgroundColor = kMainBgColor;
    }
    return _septorLine;
}
-(void)setModel:(LXNewsModel *)model
{
    _model = model;
    _headerLabel.text = _model.title;
    UIImage *placeHolderImg = [UIImage imageWithColor:kGrayBtnBacColor];
    [_contenImg sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:_model.image]] placeholderImage:placeHolderImg];
    //_dateLable.text = [NSString stringWithFormat:@"发布时间：%@",[WLTools]]
}
@end

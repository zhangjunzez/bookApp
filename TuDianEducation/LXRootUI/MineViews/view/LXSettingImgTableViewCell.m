//
//  LXSettingImgTableViewCell.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/1.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXSettingImgTableViewCell.h"
@interface LXSettingImgTableViewCell()
@property (nonatomic, strong) UIView *bacView;
@property (nonatomic, strong) UIView *septorLine;

@end

@implementation LXSettingImgTableViewCell

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
    [self.bacView addSubview:self.nameLabel];
    [self.bacView addSubview:self.gotoImg];
    [self.bacView addSubview:self.headerImgView];
    [self.bacView addSubview:self.septorLine];
}
-(UIView *)bacView{
    if (!_bacView) {
        _bacView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(66))];
        _bacView.backgroundColor = kWhiteColor;
        [_bacView setCornerRadius:ScaleW(8)];
    }
    return _bacView;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [WLTools allocLabel:@"清除缓存" font:systemFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(15), 0, _bacView.width - ScaleW(15)*2, ScaleW(66)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _nameLabel;
}

-(UIImageView *)gotoImg{
    if (!_gotoImg) {
        _gotoImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"chakanquanbu"]];
        _gotoImg.right = ScreenWidth - ScaleW(15);
        _gotoImg.centerY = _nameLabel.centerY;
        
    }
    return _gotoImg;
}
-(UIImageView *)headerImgView{
    if (!_headerImgView) {
        _headerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, ScaleW(8), ScaleW(50), ScaleW(50))];
        _headerImgView.right = ScreenWidth - ScaleW(36);
        _headerImgView.backgroundColor = kSubBacColor;
        _headerImgView.cornerRadius =_headerImgView.height/2.f;
        _headerImgView.userInteractionEnabled = YES;
    }
    return _headerImgView;
}
-(UIView *)septorLine
{
    if (!_septorLine) {
        _septorLine = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), 0, _bacView.width - ScaleW(30), .5)];
        _septorLine.bottom = ScaleW(66) - 1;
        _septorLine.backgroundColor = kMainBgColor;
    }
    return _septorLine;
}

@end

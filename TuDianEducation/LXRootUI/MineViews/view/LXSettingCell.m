//
//  LXSettingCell.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/24.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXSettingCell.h"
@interface LXSettingCell()
@property (nonatomic, strong) UIView *bacView;

@property (nonatomic, strong) UIView *septorLine;

@end

@implementation LXSettingCell

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
    [self.bacView addSubview:self.subNameLabel];
    [self.bacView addSubview:self.gotoImg];
    [self.bacView addSubview:self.swithUnknow];
    [self.bacView addSubview:self.septorLine];
}
-(UIView *)bacView{
    if (!_bacView) {
        _bacView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(50))];
        _bacView.backgroundColor = kWhiteColor;
        [_bacView setCornerRadius:ScaleW(8)];
    }
    return _bacView;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [WLTools allocLabel:@"清除缓存" font:systemFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(15), 0, _bacView.width - ScaleW(15)*2, ScaleW(50)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _nameLabel;
}
-(UILabel *)subNameLabel{
    if (!_subNameLabel) {
        _subNameLabel = [WLTools allocLabel:@"2.3M" font:systemFont(ScaleW(15)) textColor:kGrayTxtColor frame:CGRectMake(ScaleW(15), 0, _bacView.width - ScaleW(15)- ScaleW(41), ScaleW(50)) textAlignment:(NSTextAlignmentRight)];
    }
    return _subNameLabel;
}
-(UIImageView *)gotoImg{
    if (!_gotoImg) {
        _gotoImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"chakanquanbu"]];
        _gotoImg.right = ScreenWidth - ScaleW(15);
        _gotoImg.centerY = _nameLabel.centerY;
        
    }
    return _gotoImg;
}
-(UIView *)septorLine
{
    if (!_septorLine) {
        _septorLine = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), 0, _bacView.width - ScaleW(30), .5)];
        _septorLine.bottom = ScaleW(50) - 1;
        _septorLine.backgroundColor = kMainBgColor;
    }
    return _septorLine;
}
-(UISwitch *)swithUnknow{
    if (!_swithUnknow) {
        _swithUnknow = [[UISwitch alloc]initWithFrame:CGRectMake(_bacView.width - ScaleW(30) - ScaleW(35), 0, ScaleW(30), ScaleW(16))];
        [_swithUnknow addTarget:self action:@selector(swichAction:) forControlEvents:(UIControlEventValueChanged)];
        _swithUnknow.centerY = _nameLabel.centerY;
        _swithUnknow.onTintColor = kBlueColor;
        [_swithUnknow setOn:YES];
        _swithUnknow.hidden = YES;
    }
    return _swithUnknow;
}
-(void)swichAction:(UISwitch *)sender
{
    
    !self.changeStatusBlock?:self.changeStatusBlock(sender);
    
}
-(void)setStatus:(BOOL)isOn
{
    [self.swithUnknow setOn:isOn];
    if (self.swithUnknow.on) {
       
    }else{
       
    }
}
@end

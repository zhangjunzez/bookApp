//
//  BkSliderTableViewCell.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/12.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//


#import "BkSliderTableViewCell.h"


@interface BkSliderTableViewCell()
@property (nonatomic, strong) UIView *bacView;

@property (nonatomic, strong) UIImageView *headerImg;
@property (nonatomic, strong) UILabel *nameLabel;





@end

@implementation BkSliderTableViewCell

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
    [self.bacView addSubview:self.headerImg];
    [self.bacView addSubview:self.nameLabel];
}

-(UIView *)bacView{
    if (!_bacView) {
        _bacView = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(0), ScaleW(110), ScaleW(50))];
        _bacView.backgroundColor = kWhiteColor;
    }
    return _bacView;
}

-(UIImageView *)headerImg{
    if (!_headerImg) {
        _headerImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"椭圆2"]];
        _headerImg.left = ScaleW(12);
        _headerImg.top = ScaleW(14);
    }
    return _headerImg;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [WLTools allocLabel:@"首届星洲" font:systemBoldFont(ScaleW(13)) textColor:kMainTxtColor frame:CGRectMake(_headerImg.right ,  ScaleW(18), ScaleW(90), ScaleW(13)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _nameLabel;
}


-(void)setIsSelct:(BOOL)isSelct{
    _isSelct = isSelct;
    if (_isSelct) {
        _nameLabel.textColor = kMainTxtColor;
        _bacView.backgroundColor = kWhiteColor;
        _nameLabel.font = systemFont(ScaleW(13));
        _headerImg.hidden = NO;
    }else{
        _nameLabel.textColor = kSubTxtColor;
        _bacView.backgroundColor = kSubBacColor;
        _nameLabel.font = systemFont(ScaleW(12));
        _headerImg.hidden = YES;
    }
}

@end

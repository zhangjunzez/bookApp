//
//  WuliuListTableViewCell.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/9.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//


#import "WuliuListTableViewCell.h"


@interface WuliuListTableViewCell()

@property (nonatomic,strong) UIView *pointView;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *dateLabel;
@end

@implementation WuliuListTableViewCell

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
    [self.contentView addSubview:self.pointView];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.dateLabel];
   
    
}


-(UIView *)pointView
{
    if (!_pointView) {
        _pointView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(27), 0, ScaleW(8), ScaleW(8))];
        _pointView.backgroundColor = kRedColor;
        _pointView.cornerRadius = _pointView.height/2.f;
        
    }
    return _pointView;
}
-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(30), _pointView.bottom, 0.5f, ScaleW(62))];
        _lineView.backgroundColor = kMainLineColor;
    }
    return _lineView;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [WLTools allocLabel:@"已取件，到达〔广州市〕快件已被本人去签收" font:systemBoldFont(ScaleW(13)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(15) + _pointView.right , ScaleW(0) , ScaleW(300), ScaleW(13)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _nameLabel;
}

-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [WLTools allocLabel:@"12-30  16:00" font:systemFont(ScaleW(10)) textColor:kGrayTxtColor frame:CGRectMake(_nameLabel.left , ScaleW(10) + _nameLabel.bottom , _nameLabel.width, ScaleW(10)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _dateLabel;
}

@end

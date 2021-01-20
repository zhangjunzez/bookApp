//
//  BkMineYueTableViewCell.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/8.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//


#import "BkMineYueTableViewCell.h"


@interface BkMineYueTableViewCell()
@property (nonatomic, strong) UIView *bacView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *dateLabel;
@property (nonatomic,strong) UILabel *moneyLabel;




@end

@implementation BkMineYueTableViewCell

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
    [self.bacView addSubview:self.moneyLabel];
    [self.bacView addSubview:self.dateLabel];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(10), self.bacView.height - 0.5, ScaleW(353), .5f)];
    line.backgroundColor = kMainLineColor;
    [self.bacView addSubview:line];
    
}
-(UIView *)bacView{
    if (!_bacView) {
        _bacView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(0), ScaleW(0), ScreenWidth, ScaleW(66))];
        _bacView.backgroundColor = kWhiteColor;
        _bacView.cornerRadius = ScaleW(5);
    }
    return _bacView;
}


-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [WLTools allocLabel:@"积分怎么用？" font:systemBoldFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(10) , ScaleW(19) , ScreenWidth - ScaleW(20), ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _nameLabel;
}
-(UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [WLTools allocLabel:@"-￥100.00" font:systemBoldFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(10) , ScaleW(19) , ScreenWidth - ScaleW(20), ScaleW(14)) textAlignment:(NSTextAlignmentRight)];
    }
    return _moneyLabel;
}
-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [WLTools allocLabel:@"2020-08-20  11:00" font:systemFont(ScaleW(10)) textColor:kGrayTxtColor frame:CGRectMake(ScaleW(10) , ScaleW(10) + _nameLabel.bottom , ScreenWidth - ScaleW(20), ScaleW(10)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _dateLabel;
}

@end

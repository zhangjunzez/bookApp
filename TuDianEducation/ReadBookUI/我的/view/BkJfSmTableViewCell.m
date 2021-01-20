//
//  BkJfSmTableViewCell.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/7.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//


#import "BkJfSmTableViewCell.h"


@interface BkJfSmTableViewCell()
@property (nonatomic, strong) UIView *bacView;
@property (nonatomic,strong) UIView *headerView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *descreapLabel;


@end

@implementation BkJfSmTableViewCell

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
    [self.bacView addSubview:self.headerView];
    [self.bacView addSubview:self.nameLabel];
    [self.bacView addSubview:self.descreapLabel];
    
}
-(UIView *)bacView{
    if (!_bacView) {
        _bacView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(11), ScaleW(10), ScreenWidth - ScaleW(22), ScaleW(100))];
        _bacView.backgroundColor = kSubBacColor;
        _bacView.cornerRadius = ScaleW(5);
    }
    return _bacView;
}
-(UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(-ScaleW(10), -ScaleW(10), ScaleW(112), ScaleW(30))];
        _headerView.backgroundColor = kGreenColor;
        _headerView.cornerRadius = ScaleW(10);
        
    }
    return _headerView;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [WLTools allocLabel:@"积分怎么用？" font:systemFont(ScaleW(13)) textColor:kWhiteColor frame:CGRectMake(ScaleW(15) , ScaleW(5) , ScaleW(102), ScaleW(13)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _nameLabel;
}

-(UILabel *)descreapLabel{
    if (!_descreapLabel) {
        _descreapLabel = [WLTools allocLabel:@"在图书APP“积分商城”中进行查看商品信息并进行商品兑换兑换成功后扣除相应积分" font:systemFont(ScaleW(12)) textColor:kSubTxtColor frame:CGRectMake(ScaleW(15), ScaleW(20) + _headerView.bottom, ScaleW(320), ScaleW(12)) textAlignment:(NSTextAlignmentRight)];
        [_descreapLabel sizeToFit];
    }
    return _descreapLabel;
}

@end

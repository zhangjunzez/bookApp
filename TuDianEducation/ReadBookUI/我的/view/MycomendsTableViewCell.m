//
//  MycomendsTableViewCell.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/9.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "MycomendsTableViewCell.h"


@interface MycomendsTableViewCell()
@property (nonatomic, strong) UIView *bacView;
@property (nonatomic, strong) UIImageView *headerImg;
@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *dateLable;
@property (nonatomic,strong) UILabel *contentLable;



@end

@implementation MycomendsTableViewCell

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
    [self.bacView addSubview:self.dateLable];
    [self.bacView addSubview:self.contentLable];
    
    
}

-(UIView *)bacView{
    if (!_bacView) {
        _bacView = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(0), ScreenWidth , ScaleW(115))];
        _bacView.backgroundColor = kWhiteColor;
    }
    return _bacView;
}
-(UIImageView *)headerImg{
    if (!_headerImg) {
        _headerImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(11), ScaleW(15), ScaleW(35), ScaleW(35))];
        [_headerImg setCornerRadius:_headerImg.height/2.f];
        _headerImg.backgroundColor = kGrayTxtColor;
 
    }
    return _headerImg;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [WLTools allocLabel:@"首届星洲" font:systemBoldFont(ScaleW(13)) textColor:kMainTxtColor frame:CGRectMake(_headerImg.right + ScaleW(11), _headerImg.top + ScaleW(12), ScaleW(300), ScaleW(13)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _nameLabel;
}


-(UILabel *)dateLable{
    if (!_dateLable) {
        _dateLable = [WLTools allocLabel:@"1天前" font:systemFont(ScaleW(11)) textColor:kGreenColor frame:CGRectMake(_nameLabel.left, _nameLabel.top, _nameLabel.width,ScaleW(11)) textAlignment:(NSTextAlignmentRight)];
        
       
    }
    return _dateLable;
}
-(UILabel *)contentLable{
    if (!_contentLable) {
        _contentLable = [WLTools allocLabel:@"一次很好的购物体验，服务周到，物流快速，配送也很周到，卖家态度也很好~ 下次还回购~" font:systemFont(ScaleW(12)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(10), ScaleW(11) + _headerImg.bottom, ScaleW(355), ScaleW(42)) textAlignment:(NSTextAlignmentLeft)];
        _contentLable.numberOfLines = 2;
    }
    return _contentLable;
}

@end

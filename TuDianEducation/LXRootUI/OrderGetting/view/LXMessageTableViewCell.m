//
//  LXMessageTableViewCell.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/30.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//


#import "LXMessageTableViewCell.h"
#import "LXMessageModel.h"

@interface LXMessageTableViewCell()
@property (nonatomic, strong) UIView *bacView;
@property (nonatomic, strong) UIImageView *headerImg;
@property (nonatomic, strong) UILabel *noticeLabel;
@property (nonatomic, strong) UILabel *subDetailLabel;
@property (nonatomic, strong) UILabel *dateLable;
@property (nonatomic, strong) UIImageView *gotoImg;

@property(nonatomic, strong)UIView *flagView;
@property (nonatomic,strong) UIView *redPoint;
@end

@implementation LXMessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

//- (void)setModel:(TDMessageModel *)model{
//    _model = model;
//    self.noticeLabel.text = model.typeString;
//    self.subDetailLabel.text = model.message;
//    self.dateLable.text = [WLTools getDetailedDateWithTimeInterval:model.timestamp.longLongValue];
//    self.flagView.hidden = model.isRead == 1;
//}

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
    self.contentView.backgroundColor = kMainBgColor;
    [self.contentView addSubview:self.bacView];
    [self.bacView addSubview:self.headerImg];
    [self.bacView addSubview:self.noticeLabel];
    [self.bacView addSubview:self.subDetailLabel];
    [self.bacView addSubview:self.dateLable];
    [self.bacView addSubview:self.gotoImg];
    
    self.flagView = [UIView new];
    self.flagView.backgroundColor = [UIColor redColor];
    self.flagView.layer.masksToBounds = YES;
    self.flagView.layer.cornerRadius = 8;
    [self.bacView addSubview:self.flagView];
    
    //
//    self.flagView.frame = CGRectMake(0, 0, 16, 16);
//    self.flagView.right = self.headerImg.right;
//    self.flagView.top = self.headerImg.top;
    [self.flagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self.headerImg);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    self.flagView.hidden = YES;
    
    [self.bacView addSubview:self.redPoint];
}
-(UIView *)redPoint{
    if (!_redPoint) {
        _redPoint = [[UIView alloc]initWithFrame:CGRectMake(self.bacView.width - ScaleW(40), ScaleW(10), ScaleW(10), ScaleW(10))];
        _redPoint.backgroundColor = kRedColor;
        [_redPoint setCornerRadius:ScaleW(5)];
        _redPoint.hidden = YES;
    }
    return _redPoint;
}
-(UIView *)bacView{
    if (!_bacView) {
        _bacView = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(0), ScreenWidth , ScaleW(82))];
        _bacView.backgroundColor = kWhiteColor;
    }
    return _bacView;
}
-(UIImageView *)headerImg{
    if (!_headerImg) {
        _headerImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(12), ScaleW(10), ScaleW(41), ScaleW(41))];
        [_headerImg setCornerRadius:_headerImg.height/2.f];
        _headerImg.backgroundColor = kGrayTxtColor;
        _headerImg.image = [UIImage imageNamed:@"xiaoxi_liebiap"];
//        UIImageView *centerImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(22), ScaleW(22))];
//        centerImg.centerX = _headerImg.width/2.f;
//        centerImg.centerY = _headerImg.height/2.f;
//        centerImg.image = BUNDLE_PNGIMG(@"homePage", @"noticeImg");
//        [_headerImg addSubview:centerImg];
        
    }
    return _headerImg;
}
-(UILabel *)noticeLabel{
    if (!_noticeLabel) {
        _noticeLabel = [WLTools allocLabel:@"系统消息" font:systemBoldFont(ScaleW(16)) textColor:kMainTxtColor frame:CGRectMake(_headerImg.right + ScaleW(12), ScaleW(16), _bacView.width - ScaleW(12)*2 - _headerImg.right, ScaleW(16)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _noticeLabel;
}
-(UILabel *)subDetailLabel{
    if (!_subDetailLabel) {
        _subDetailLabel = [WLTools allocLabel:@"您的佣金已到账" font:systemFont(ScaleW(13)) textColor:kSubTxtColor frame:CGRectMake(_noticeLabel.left, ScaleW(12) + _noticeLabel.bottom, _noticeLabel.width, ScaleW(13)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _subDetailLabel;
}

-(UILabel *)dateLable{
    if (!_dateLable) {
        _dateLable = [WLTools allocLabel:@"2020-04-09 00:00:00" font:systemFont(ScaleW(10)) textColor:kGrayTxtColor frame:CGRectMake(ScaleW(12), _noticeLabel.top, _bacView.width - ScaleW(14) - ScaleW(15), ScaleW(10)) textAlignment:(NSTextAlignmentRight)];
        _dateLable.bottom = self.bacView.height - ScaleW(30);
       
    }
    return _dateLable;
}
-(UIImageView *)gotoImg{
    if (!_gotoImg) {
        _gotoImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(20), ScaleW(20))];
        _gotoImg.right = _bacView.width - ScaleW(10);
        _gotoImg.centerY = _bacView.height/2.f;
        _gotoImg.image = BUNDLE_PNGIMG(@"mineCenter", @"Commentback");
    }
    return _gotoImg;
}
-(void)setModel:(LXMessageModel *)model{
    _model = model;
    _noticeLabel.text = _model.title;
    _subDetailLabel.text = _model.content;
    _dateLable.text = _model.adtime;
    _redPoint.hidden = _model.state.boolValue;
    _headerImg.image = [UIImage imageNamed:_model.type.boolValue?@"xuqiu":@"xiaoxi_liebiap"];
    
}
@end

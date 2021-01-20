
#import "LXMinePublishTableViewCell.h"
#import "LXLearnModel.h"
#import "LXMySkillModel.h"
#import "LXSaveUserInforTool.h"
#import "LXUserInforModel.h"
@interface LXMinePublishTableViewCell()
@property (nonatomic, strong) UIView *bacView;
@property (nonatomic,strong) UIImageView *headerImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *dateLabel;

@property (nonatomic, strong) UIView *septorLine;

@end

@implementation LXMinePublishTableViewCell

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
    [self.bacView addSubview:self.headerImage];
    [self.bacView addSubview:self.nameLabel];
    [self.bacView addSubview:self.dateLabel];
    [self.bacView addSubview:self.statusImg];
    [self.bacView addSubview:self.pointBtn];
    [self.bacView addSubview:self.viewsBtn];
    [self.bacView addSubview:self.septorLine];
}
-(UIView *)bacView{
    if (!_bacView) {
        _bacView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(90))];
        _bacView.backgroundColor = kWhiteColor;
    }
    return _bacView;
}
-(UIImageView *)headerImage{
    if (!_headerImage) {
        _headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(15), ScaleW(59), ScaleW(59))];
        _headerImage.backgroundColor = kGrayTxtColor;
        [_headerImage setCornerRadius:_headerImage.height/2.f];
    }
    return _headerImage;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [WLTools allocLabel:@"学习标题" font:systemBoldFont(ScaleW(16)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(10) + _headerImage.right, ScaleW(7) + _headerImage.top, _bacView.width - ScaleW(100), ScaleW(16)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _nameLabel;
}
-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [WLTools allocLabel:@"注册时间：2020-03-29" font:systemFont(ScaleW(13)) textColor:kSubTxtColor frame:CGRectMake(ScaleW(10) + _headerImage.right, ScaleW(19) + _nameLabel.bottom, _bacView.width - ScaleW(100), ScaleW(13)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _dateLabel;
}
-(UIImageView *)statusImg{
    if (!_statusImg) {
        _statusImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(215), ScaleW(20), ScaleW(65), ScaleW(50))];
    
    }
    return _statusImg;
}
-(UIButton *)pointBtn
{
    if (!_pointBtn) {
        _pointBtn = [WLTools allocButtonTitle:@"" font:systemFont(ScaleW(0)) textColor:kWhiteColor image:[UIImage imageNamed:@"fabu_gengduo"] frame:CGRectMake(self.bacView.width - ScaleW(77), ScaleW(10), ScaleW(77), ScaleW(20)) sel:@selector(pointBtnAction:) taget:self];
        _pointBtn.centerY = _nameLabel.centerY;
    }
    return _pointBtn;
}
-(UIButton *)viewsBtn
{
    if (!_viewsBtn) {
        _viewsBtn = [WLTools allocButtonTitle:@"9999" font:systemFont(ScaleW(13)) textColor:kGrayTxtColor image:[UIImage imageNamed:@"xuexi_yanjing"] frame:CGRectMake(ScreenWidth - ScaleW(106), 0, ScaleW(106), ScaleW(20)) sel:@selector(pointBtnAction:) taget:self];
        _viewsBtn.centerY  = _dateLabel.centerY;
    }
    return _viewsBtn;
}
-(UIView *)septorLine
{
    if (!_septorLine) {
        _septorLine = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), 0, _bacView.width - ScaleW(30), .5)];
        _septorLine.bottom = self.bacView.height - 1;
        _septorLine.backgroundColor = kMainBgColor;
    }
    return _septorLine;
}
-(void)pointBtnAction:(UIButton *)sender
{
    !self.pointsBlock?:self.pointsBlock();
}
-(void)setModel:(LXLearnModel *)model{
    _model = model;
    _nameLabel.text = _model.title;
    [_headerImage sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:_model.engineericon]]];
    _dateLabel.text = [NSString stringWithFormat:@"%@",_model.adtime?:@""];
    [_viewsBtn setTitle:_model.looknum forState:(UIControlStateNormal)];

}
-(void)setSkillModel:(LXMySkillModel *)skillModel{
    _skillModel = skillModel;
    //审核状态 0待审核 1已审核 2审核失败
    NSString *stausImgName = @"";
        if (_skillModel.authstate.integerValue == 0) {
            ///待审核
            stausImgName = @"tixian_daishenhe";
        }
        if (_skillModel.authstate.integerValue == 1) {
            ///成功
            stausImgName = @"tixian_chenggong";
        }
        if (_skillModel.authstate.integerValue == 2) {
               ///失败
               stausImgName = @"tixian_shibai";
           }
    _statusImg.image = [UIImage imageNamed:stausImgName];
    _nameLabel.text = _skillModel.title;
    [_headerImage sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:[LXSaveUserInforTool sharedUserTool].userInforModel.icon]]];
    _dateLabel.text = _skillModel.adtime;
    [_viewsBtn setTitle:_skillModel.looknum forState:(UIControlStateNormal)];
    [_viewsBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, ScaleW(5), 0, 0)];
    
}
@end

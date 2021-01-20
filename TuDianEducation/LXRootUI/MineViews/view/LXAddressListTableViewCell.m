//
//  LXAddressListTableViewCell.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/28.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXAddressListTableViewCell.h"
#import "LXAddressModel.h"
@interface LXAddressListTableViewCell()
@property (nonatomic, strong) UIView *bacView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *detailAddressLabel;
@property (nonatomic, strong) UIView *septorLine;
@property (nonatomic,strong) UIButton *setDefultBtn;
@property (nonatomic,strong) UIButton *deleteBtn;
@property (nonatomic,strong) UIButton *edtingBtn;
@property (nonatomic,strong) UILabel *defultLabel;
@end

@implementation LXAddressListTableViewCell

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
-(UILabel *)defultLabel{
    if (!_defultLabel) {
        _defultLabel = [WLTools allocLabel:@"默认地址" font:systemFont(ScaleW(11)) textColor:kWhiteColor frame:CGRectMake(_detailAddressLabel.left, _userNameLabel.top, ScaleW(55), ScaleW(17)) textAlignment:(NSTextAlignmentCenter)];
        [_defultLabel setCornerRadius:ScaleW(3)];
       
        _defultLabel.backgroundColor = kGrayTxtColor;
        _defultLabel.hidden = NO;
    }
    return _defultLabel;
}
-(void)viewConfig
{   self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = kSubBacColor;
    
    [self.contentView addSubview:self.bacView];
    [self.bacView addSubview:self.detailAddressLabel];
    [self.bacView addSubview:self.userNameLabel];
    [self.bacView addSubview:self.septorLine];
    [self.bacView addSubview:self.setDefultBtn];
    [self.bacView addSubview:self.edtingBtn];
    [self.bacView addSubview:self.deleteBtn];
    
    [self.bacView addSubview:self.defultLabel];
    
}
-(UIView *)bacView{
    if (!_bacView) {
        _bacView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(10), ScaleW(345), ScaleW(85))];
        _bacView.backgroundColor = kWhiteColor;
        [_bacView setCornerRadius:ScaleW(8)];
    }
    return _bacView;
}
-(UILabel *)detailAddressLabel{
    if (!_detailAddressLabel) {
        _detailAddressLabel = [WLTools allocLabel:@"河南省郑州市郑东新区通泰路与宏昌街交叉口商都世贸中心D座2002" font:systemFont(ScaleW(15)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(15), ScaleW(24), _bacView.width - ScaleW(15)*2, ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
        _detailAddressLabel.numberOfLines = 0;
    }
    return _detailAddressLabel;
}
-(UILabel *)userNameLabel{
    if (!_userNameLabel) {
        _userNameLabel = [WLTools allocLabel:@"用户名称 *******" font:systemFont(ScaleW(13)) textColor:kSubTxtColor frame:CGRectMake(ScaleW(15), ScaleW(12) + _detailAddressLabel.bottom, _bacView.width - ScaleW(15)*2, ScaleW(13)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _userNameLabel;
}

-(UIView *)septorLine
{
    if (!_septorLine) {
        _septorLine = [[UIView alloc]initWithFrame:CGRectMake(0, _userNameLabel.bottom + ScaleW(5), _bacView.width, .5)];
        _septorLine.backgroundColor = kSubBacColor;
    }
    return _septorLine;
}

-(UIButton *)setDefultBtn{
    if (!_setDefultBtn) {
        // [_agreeBtn setImage:[UIImage imageNamed:@"[denglu_weixuan]"] forState:(UIControlStateNormal)];
              // [_agreeBtn setImage:[UIImage imageNamed:@"denglu_yixuan"] forState:(UIControlStateSelected)];
        _setDefultBtn = [WLTools  allocButtonTitle:@"设为默认" font:systemFont(ScaleW(14)) textColor:kMainTxtColor image:[UIImage imageNamed:@"weixuanzhong"] frame:CGRectMake(0, _septorLine.bottom, ScaleW(140), ScaleW(50)) sel:@selector(setDefultBtnAction:) taget:self];
         [_setDefultBtn setImage:[UIImage imageNamed:@"xuanzhong"] forState:(UIControlStateSelected)];
        [_setDefultBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -ScaleW(10), 0, 0)];
    }
    return _setDefultBtn;
}
-(UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [WLTools allocButtonTitle:@"" font:systemFont(ScaleW(14)) textColor:kMainTxtColor image:[UIImage imageNamed:@"删除_d"] frame:CGRectMake(_edtingBtn.right + ScaleW(20), ScaleW(39), ScaleW(25), ScaleW(25)) sel:@selector(deleteBtnAction:) taget:self];
        
    }
    return _deleteBtn;
}
-(UIButton *)edtingBtn{
    if (!_edtingBtn) {
        _edtingBtn = [WLTools allocButtonTitle:@"" font:systemFont(ScaleW(14)) textColor:kMainTxtColor image:[UIImage imageNamed:@"编辑_d"] frame:CGRectMake(ScaleW(272), ScaleW(39), ScaleW(25), ScaleW(25)) sel:@selector(edtingBtnAction:) taget:self];
        
    }
    return _edtingBtn;
}
#pragma mark  ---Action
-(void)setDefultBtnAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    !self.setDefultBlock?:self.setDefultBlock(sender.selected);
}
-(void)deleteBtnAction:(UIButton *)sender
{
    !self.deleteBlock?:self.deleteBlock();
}
-(void)edtingBtnAction:(UIButton *)sender
{
    !self.edtingBlock?:self.edtingBlock();
}
-(void)setModel:(LXAddressModel *)model{
    _model = model;
    self.userNameLabel.text =[NSString stringWithFormat:@"%@      %@",_model.phone,_model.name];
   
    self.detailAddressLabel.text = [NSString stringWithFormat:@"%@",_model.address];
    [self.setDefultBtn setSelected:_model.isdefault.integerValue];
    self.setDefultBtn.hidden = _model.isdefault.integerValue;
    self.defultLabel.hidden = !_model.isdefault.integerValue;
    self.userNameLabel.left = _model.isdefault.integerValue?self.defultLabel.right + ScaleW(8):self.userNameLabel.left;
    
}
@end


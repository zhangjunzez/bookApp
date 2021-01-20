//
//  BkShopCarTableViewCell.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/11.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//


#import "BkShopCarTableViewCell.h"


@interface BkShopCarTableViewCell()
@property (nonatomic, strong) UIView *bacView;
@property (nonatomic,strong) UIButton *selectBtn;
@property (nonatomic,strong) UIImageView *headerImgView;
@property (nonatomic,strong) UILabel *bkNameLabel;
@property (nonatomic,strong) UILabel *moneyLabel;
@property (nonatomic,strong) UIView *septorLine;
@property (nonatomic,strong) UILabel *amountNameLabel;
@property (nonatomic,strong) UIButton *addBtn;
@property (nonatomic,strong) UIButton *reduceBtn;
@property (nonatomic,strong) UILabel *amountLabel;
@property (nonatomic,assign) NSInteger amountCount;

@end

@implementation BkShopCarTableViewCell

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
    [self.bacView addSubview:self.selectBtn];
    [self.bacView addSubview:self.headerImgView];
    [self.bacView addSubview:self.bkNameLabel];
    [self.bacView addSubview:self.moneyLabel];
    [self.bacView addSubview:self.amountNameLabel];
    [self.bacView addSubview:self.septorLine];
    [self.bacView addSubview:self.addBtn];
    [self.bacView addSubview:self.amountLabel];
    [self.bacView addSubview:self.reduceBtn];
    
    
}
-(UIButton *)selectBtn
{
    if (!_selectBtn) {
        _selectBtn = [WLTools allocButtonTitle:@"" font:systemFont(ScaleW(12)) textColor:kMainTxtColor image:[UIImage imageNamed:@"weixuanzhong"] frame:CGRectMake(0, ScaleW(37), ScaleW(27), ScaleW(27)) sel:@selector(selecBtnAction:) taget:self];
        [_selectBtn setImage:[UIImage imageNamed:@"xuanzhong"] forState:(UIControlStateSelected)];
    }
    return _selectBtn;
}
-(void)selecBtnAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
}
-(UIView *)bacView{
    if (!_bacView) {
        _bacView = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(0), ScreenWidth , ScaleW(105))];
        _bacView.backgroundColor = kWhiteColor;
    }
    return _bacView;
}
-(UIImageView *)headerImgView{
    if (!_headerImgView) {
        _headerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(3) + _selectBtn.right, ScaleW(17) , ScaleW(47), ScaleW(63))];
        _headerImgView.backgroundColor = kGrayTxtColor;

    }
    return _headerImgView;
}
-(UILabel *)bkNameLabel{
    if (!_bkNameLabel) {
        _bkNameLabel = [WLTools allocLabel:@"初中数学运算大法" font:systemFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(_headerImgView.right + ScaleW(10),   ScaleW(5) + _headerImgView.top, ScaleW(210), ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
        //_bkNameLabel.numberOfLines = 0;
    }
    return _bkNameLabel;
}
-(UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [WLTools allocLabel:@"￥999.00" font:systemFont(ScaleW(12)) textColor:kRedColor frame:CGRectMake(_headerImgView.right + ScaleW(10), _bkNameLabel.top, ScaleW(270), ScaleW(15)) textAlignment:(NSTextAlignmentRight)];
        NSString *string = _moneyLabel.text;
        NSMutableAttributedString *atts = [[NSMutableAttributedString alloc] initWithString:string];
        [atts setAttributes:@{NSFontAttributeName:systemBoldFont(ScaleW(15))} range:NSMakeRange(1,  string.length - 4)];
        _moneyLabel.attributedText = atts;
    }
    return _moneyLabel;
}
-(UILabel *)amountNameLabel{
    if (!_amountNameLabel) {
        _amountNameLabel = [WLTools allocLabel:@"数量x1" font:systemFont(ScaleW(12)) textColor:kMainTxtColor frame:CGRectMake(_headerImgView.right + ScaleW(10),   ScaleW(10) + _bkNameLabel.bottom, ScaleW(210), ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _amountNameLabel;
}
-(UIView *)septorLine{
    if (!_septorLine) {
        _septorLine = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(11),self.bacView.height - .5f, self.width - ScaleW(22), .5f)];
        _septorLine.backgroundColor = kMainLineColor;
    }
    return _septorLine;
}

-(UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [WLTools allocButtonTitle:@"+" font:systemBoldFont(18) textColor:kMainTxtColor image:nil frame:CGRectMake(ScreenWidth - ScaleW(25), _amountNameLabel.bottom + ScaleW(10), ScaleW(18), ScaleW(18)) sel:@selector(addAction:) taget:self];
        [_addBtn setTitleColor:kGrayTxtColor forState:(UIControlStateSelected)];
        
    }
    return _addBtn;
}
-(UILabel *)amountLabel{
    if (!_amountLabel) {
        _amountLabel = [WLTools allocLabel:@"1" font:systemFont(ScaleW(12)) textColor:kMainTxtColor frame:CGRectMake(0, 0, ScaleW(33), ScaleW(17)) textAlignment:(NSTextAlignmentCenter)];
        _amountLabel.backgroundColor = kMainBgColor;
        _amountLabel.centerY = _addBtn.centerY;
        _amountLabel.right = _addBtn.left;
         
    }
    return _amountLabel;
}
-(UIButton *)reduceBtn{
    if (!_reduceBtn) {
        _reduceBtn = [WLTools allocButtonTitle:@"-" font:systemBoldFont(18) textColor:kMainTxtColor image:nil frame:CGRectMake(0, _addBtn.top, ScaleW(18), ScaleW(18)) sel:@selector(reduceAction:) taget:self];
        [_reduceBtn setTitleColor:kGrayTxtColor forState:(UIControlStateSelected)];
        _reduceBtn.right = _amountLabel.left;
       
    }
    return _reduceBtn;
}
-(void)addAction:(UIButton *)sender{
    self.amountCount ++;
  
}
-(void)reduceAction:(UIButton *)sender
{
    if (self.amountCount<= 1) {
        self.amountCount = 1;
    }else{
        self.amountCount--;
    }
}
-(void)setAmountCount:(NSInteger)amountCount
{
    _amountCount = amountCount;
    
    _amountLabel.text = [NSString stringWithFormat:@"%ld",_amountCount];
//    if (_detailModel) {
//        double index  =  _detailModel.goodsprice1.floatValue *_amountCount;
//        _totalLabel.text = [NSString stringWithFormat:@"总计：￥%.2f",index];
//        _scoreLabel.text = [NSString stringWithFormat:@"%ld积分",_detailModel.goodsprice.integerValue *_amountCount];
//        !self.scoreAmountBlock?:self.scoreAmountBlock(_amountCount);
//    }
    
}
@end

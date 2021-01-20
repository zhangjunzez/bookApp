//
//  LXMarketEnsureTopView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/2.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXMarketEnsureTopView.h"
@interface LXMarketEnsureTopView()

@property (nonatomic,strong) UIView *addressView;
@property (nonatomic,strong) UIImageView *addressImg;
@property (nonatomic,strong) UILabel *userNameLabel;
@property (nonatomic,strong) UILabel *detailAddressLabel;
@property (nonatomic,strong) UIImageView *gotoImg;
@property (nonatomic,strong) UIView *goodsView;
@property (nonatomic,strong) UIImageView *goodsPicImg;
@property (nonatomic,strong) UILabel *kindsLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UIButton *addBtn;
@property (nonatomic,strong) UIButton *reduceBtn;
@property (nonatomic,strong) UILabel *amountLabel;
@property (nonatomic,strong) UILabel *totalLabel;

@property (nonatomic,strong) UIView *scoreView;
@property (nonatomic,strong) UILabel *scoreNameLabel;
@property (nonatomic,strong) UILabel *scoreLabel;

@property (nonatomic,strong) UIView *scoreOtherView;
@property (nonatomic,strong) UILabel *scoreOtherNameLabel;
@property (nonatomic,strong) UILabel *scoreOtherLabel;
@property (nonatomic,strong) UILabel *descreptLabel;




@end

@implementation LXMarketEnsureTopView

-(instancetype)init
{
    if (self = [super init])
    {
        [self viewConfig];
    }
    return self;
}
-(void)viewConfig{
    self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(100));
    
    [self addSubview:self.addressView];
    [self.addressView addSubview:self.addressImg];
    [self.addressView addSubview:self.userNameLabel];
    [self.addressView addSubview:self.detailAddressLabel];
    [self.addressView addSubview:self.gotoImg];
    [self addSubview:self.goodsView];
    [self.goodsView addSubview:self.goodsPicImg];
    [self.goodsView addSubview:self.kindsLabel];
    [self.goodsView addSubview:self.priceLabel];
    [self.goodsView addSubview:self.addBtn];
    [self.goodsView addSubview:self.amountLabel];
    [self.goodsView addSubview:self.reduceBtn];
    [self.goodsView addSubview:self.totalLabel];
    [self addSubview:self.scoreView];
    [self.scoreView addSubview:self.scoreNameLabel];
    [self.scoreView addSubview:self.scoreLabel];
    [self addSubview:self.scoreOtherView];
    [self.scoreOtherView addSubview:self.scoreOtherNameLabel];
    [self.scoreOtherView addSubview:self.scoreOtherLabel];
    [self addSubview:self.descreptLabel];
    self.height = self.descreptLabel.bottom +ScaleW(15);
    
    self.amountCount = 1;
}
-(UIView *)addressView{
    if (!_addressView) {
        _addressView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(10) + _goodsView.bottom, ScaleW(345), ScaleW(110))];
        _addressView.backgroundColor = kWhiteColor;
        [_addressView setCornerRadius:ScaleW(5)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoAddressVc)];
               _addressView.userInteractionEnabled = YES;
               [_addressView addGestureRecognizer:tap];
    }
    return _addressView;
}
-(UIImageView *)addressImg{
    if (!_addressImg) {
        _addressImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wode_changyongdizhi"]];
        _addressImg.left = ScaleW(13);
        _addressImg.centerY = _addressView.height/2.f;
    }
    return _addressImg;
}
-(UILabel *)userNameLabel{
    if (!_userNameLabel) {
        _userNameLabel = [WLTools allocLabel:@"李帅 134574477441" font:systemFont(ScaleW(15)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(14) + _addressImg.right, ScaleW(20), _addressView.width - ScaleW(14) - _addressImg.right, ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _userNameLabel;
}
-(UILabel *)detailAddressLabel{
    if (!_detailAddressLabel) {
        _detailAddressLabel = [WLTools allocLabel:@"河南省郑州市金水区商都世贸中心D座2202室" font:systemFont(ScaleW(14)) textColor:kGrayTxtColor frame:CGRectMake(_userNameLabel.left, _userNameLabel.bottom + ScaleW(16), ScaleW(270), ScaleW(35)) textAlignment:(NSTextAlignmentLeft)];
        _detailAddressLabel.numberOfLines = 2;
    }
    return _detailAddressLabel;
}
-(UIImageView *)gotoImg{
    if (!_gotoImg) {
        _gotoImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"chakanquanbu"]];
        _gotoImg.right = _addressView.width - ScaleW(8);
        _gotoImg.centerY = _addressImg.centerY;
       
    }
    return _gotoImg;
}
-(UIView *)goodsView{
    if (!_goodsView) {
        _goodsView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(10) + _addressView.bottom, ScaleW(345), ScaleW(153))];
        _goodsView.backgroundColor = kWhiteColor;
        [_goodsView setCornerRadius:ScaleW(5)];
    }
    return _goodsView;
}
-(UIImageView *)goodsPicImg{
    if (!_goodsPicImg) {
        _goodsPicImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(15),ScaleW(15),ScaleW(88) , ScaleW(88))];
        _goodsPicImg.backgroundColor = kBlueColor;
        [_goodsPicImg setCornerRadius:ScaleW(5)];
    }
    return _goodsPicImg;
}
-(UILabel *)kindsLabel{
    if (!_kindsLabel) {
        _kindsLabel = [WLTools allocLabel:@"科学减重体脂秤" font:systemFont(ScaleW(16)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(12) + _goodsPicImg.right, _goodsPicImg.top , ScaleW(208), ScaleW(35)) textAlignment:(NSTextAlignmentLeft)];
        _kindsLabel.numberOfLines = 2;
    }
    return _kindsLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [WLTools allocLabel:@"￥2269.0" font:systemBoldFont(ScaleW(13)) textColor:kMainTxtColor frame:CGRectMake(_kindsLabel.left, _kindsLabel.bottom + ScaleW(35), ScaleW(150), ScaleW(13)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _priceLabel;
}
-(UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [WLTools allocButtonTitle:@"+" font:systemBoldFont(18) textColor:kMainTxtColor image:nil frame:CGRectMake(self.goodsView.width - ScaleW(25), _priceLabel.top, ScaleW(18), ScaleW(18)) sel:@selector(addAction:) taget:self];
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
        _reduceBtn = [WLTools allocButtonTitle:@"-" font:systemBoldFont(18) textColor:kMainTxtColor image:nil frame:CGRectMake(self.goodsView.width - ScaleW(25), _priceLabel.top, ScaleW(18), ScaleW(18)) sel:@selector(reduceAction:) taget:self];
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
-(UILabel *)totalLabel{
    if (!_totalLabel) {
        _totalLabel = [WLTools allocLabel:@"总计：￥2269.0" font:systemBoldFont(ScaleW(13)) textColor:kMainTxtColor frame:CGRectMake(_kindsLabel.left, ScaleW(132), ScaleW(218), ScaleW(13)) textAlignment:(NSTextAlignmentRight)];
    }
    return _totalLabel;
}
-(UIView *)scoreView{
    if (!_scoreView) {
        _scoreView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(10) + _goodsView.bottom, ScaleW(345), ScaleW(60))];
        _scoreView.backgroundColor = kWhiteColor;
        [_scoreView setCornerRadius:ScaleW(5)];
    }
    return _scoreView;
}
-(UILabel *)scoreNameLabel{
    if (!_scoreNameLabel) {
        _scoreNameLabel = [WLTools allocLabel:@"所需积分" font:systemFont(ScaleW(15)) textColor:kSubTxtColor frame:CGRectMake(ScaleW(15), 0, _detailAddressLabel.width, _scoreView.height) textAlignment:(NSTextAlignmentLeft)];
    }
    return _scoreNameLabel;
}
-(UILabel *)scoreLabel{
    if (!_scoreLabel) {
        _scoreLabel = [WLTools allocLabel:@"1000积分" font:systemFont(ScaleW(15)) textColor:kRedColor frame:CGRectMake(_detailAddressLabel.left, 0, _detailAddressLabel.width, _scoreView.height) textAlignment:(NSTextAlignmentRight)];
    }
    return _scoreLabel;
}
-(UIView *)scoreOtherView{
    if (!_scoreOtherView) {
        _scoreOtherView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(10) + _scoreView.bottom, ScaleW(345), ScaleW(60))];
        _scoreOtherView.backgroundColor = kWhiteColor;
        [_scoreOtherView setCornerRadius:ScaleW(5)];
        _scoreOtherView.hidden=YES;
    }
    return _scoreOtherView;
}
-(UILabel *)scoreOtherNameLabel{
    if (!_scoreOtherNameLabel) {
        _scoreOtherNameLabel = [WLTools allocLabel:@"积分余额" font:systemFont(ScaleW(15)) textColor:kSubTxtColor frame:CGRectMake(ScaleW(15), 0, _detailAddressLabel.width, _scoreView.height) textAlignment:(NSTextAlignmentLeft)];
    }
    return _scoreOtherNameLabel;
}
-(UILabel *)scoreOtherLabel{
    if (!_scoreOtherLabel) {
        _scoreOtherLabel = [WLTools allocLabel:@"1000积分" font:systemFont(ScaleW(15)) textColor:kRedColor frame:CGRectMake(_detailAddressLabel.left, 0, _detailAddressLabel.width, _scoreView.height) textAlignment:(NSTextAlignmentRight)];
    }
    return _scoreOtherLabel;
}
-(UILabel *)descreptLabel{
    if (!_descreptLabel) {
        _descreptLabel = [WLTools allocLabel:@"结算说明：XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" font:systemFont(15) textColor:kSubTxtColor frame:CGRectMake(ScaleW(25), ScaleW(73) + _scoreOtherView.bottom, ScaleW(317), ScaleW(40)) textAlignment:(NSTextAlignmentLeft)];
        _descreptLabel.numberOfLines = 0;
        [_descreptLabel sizeToFit];
    }
    return _descreptLabel;
}
-(void)setAmountCount:(NSInteger)amountCount
{
    _amountCount = amountCount;
    
    _amountLabel.text = [NSString stringWithFormat:@"%ld",_amountCount];
    if (_detailModel) {
        double index  =  _detailModel.goodsprice1.floatValue *_amountCount;
        _totalLabel.text = [NSString stringWithFormat:@"总计：￥%.2f",index];
        _scoreLabel.text = [NSString stringWithFormat:@"%ld积分",_detailModel.goodsprice.integerValue *_amountCount];
        !self.scoreAmountBlock?:self.scoreAmountBlock(_amountCount);
    }
    
}
-(void)gotoAddressVc{
    !self.gotoAddressBlock?:self.gotoAddressBlock();
}

-(void)setModel:(LXAddressModel *)model{
    _model = model;
    self.userNameLabel.text =[NSString stringWithFormat:@"%@     %@",_model.name,model.phone];
    //self.detailAddressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",_model.province,_model.city,_model.area,_model.addressdetail];
}
-(void)setDetailModel:(LXMarketGoodsDetailModel *)detailModel{
    _detailModel = detailModel;
     [_goodsPicImg sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:_detailModel.goodsimage]]];
       _kindsLabel.text = _detailModel.goodsname;
       _priceLabel.text = [NSString stringWithFormat:@"￥%@",_detailModel.goodsprice1];
    //_alreadyLabel.text = [NSString stringWithFormat:@"已兑换%@件",_detailModel.];
     self.amountCount = 1;
    _descreptLabel.hidden = YES;
    
    
}
@end

//
//  LXMarketDetailHeaderView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/29.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXMarketDetailHeaderView.h"
@interface LXMarketDetailHeaderView()
@property (nonatomic,strong) UIView *headerMessageView;
@property (nonatomic,strong) UILabel *headerMessageLabel;
@property (nonatomic,strong) UIView *goodsView;
@property (nonatomic,strong) UIImageView *goodsPicImg;
@property (nonatomic,strong) UILabel *kindsLabel;
@property (nonatomic,strong) UILabel *amountLabel;
@property (nonatomic,strong) UIView *addressView;
@property (nonatomic,strong) UILabel *userNameLabel;
@property (nonatomic,strong) UILabel *detailAddressLabel;
@property (nonatomic,strong) UIView *scoreView;
@property (nonatomic,strong) UILabel *scoreNameLabel;
@property (nonatomic,strong) UILabel *scoreLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UIView *moneyView;
@property (nonatomic,strong) UILabel *moneynameLabel;
@property (nonatomic,strong) UILabel *moneyLabel;

@end

@implementation LXMarketDetailHeaderView

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
    [self addSubview:self.headerMessageView];
    [self.headerMessageView addSubview:self.headerMessageLabel];
    [self addSubview:self.goodsView];
    [self.goodsView addSubview:self.goodsPicImg];
    [self.goodsView addSubview:self.kindsLabel];
    [self.goodsView addSubview:self.amountLabel];
    [self.goodsView addSubview:self.priceLabel];
    [self addSubview:self.addressView];
    [self.addressView addSubview:self.userNameLabel];
    [self.addressView addSubview:self.detailAddressLabel];
    [self addSubview:self.scoreView];
    [self.scoreView addSubview:self.scoreNameLabel];
    [self.scoreView addSubview:self.scoreLabel];
    [self addSubview:self.moneyView];
    [self.moneyView addSubview:self.moneynameLabel];
    [self.moneyView addSubview:self.moneyLabel];
    self.height = self.moneyView.bottom;
}
-(UIView *)headerMessageView{
    if (!_headerMessageView) {
        _headerMessageView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(40))];
        _headerMessageView.backgroundColor = kBlueColor;
    }
    return _headerMessageView;
}
-(UILabel *)headerMessageLabel
{
    if (!_headerMessageLabel) {
        _headerMessageLabel = [WLTools allocLabel:@"订单当前状态：待收货             23天后自动确认收货" font:systemFont(14) textColor:kWhiteColor frame:CGRectMake(ScaleW(29), 0, ScreenWidth - ScaleW(29), _headerMessageView.height) textAlignment:(NSTextAlignmentLeft)];
    }
    return _headerMessageLabel;
}
-(UIView *)goodsView{
    if (!_goodsView) {
        _goodsView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(10) + _headerMessageView.bottom, ScaleW(345), ScaleW(115))];
        _goodsView.backgroundColor = kWhiteColor;
        [_goodsView setCornerRadius:ScaleW(5)];
    }
    return _goodsView;
}
-(UIImageView *)goodsPicImg{
    if (!_goodsPicImg) {
        _goodsPicImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(19),ScaleW(12),ScaleW(90) , ScaleW(90))];
        _goodsPicImg.backgroundColor = kBlueColor;
    }
    return _goodsPicImg;
}
-(UILabel *)kindsLabel{
    if (!_kindsLabel) {
        _kindsLabel = [WLTools allocLabel:@"科学减重体脂秤" font:systemBoldFont(ScaleW(16)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(14) + _goodsPicImg.right, ScaleW(20) , _goodsView.width - _goodsPicImg.right- ScaleW(15)*2, ScaleW(16)) textAlignment:(NSTextAlignmentLeft)];
        _kindsLabel.numberOfLines = 0;
    }
    return _kindsLabel;
}
-(UILabel *)amountLabel{
    if (!_amountLabel) {
        _amountLabel = [WLTools allocLabel:@"x1" font:systemFont(ScaleW(14)) textColor:kGrayTxtColor frame:CGRectMake(_goodsPicImg.right, 0, _goodsView.width - _goodsPicImg.right -ScaleW(15), ScaleW(14)) textAlignment:(NSTextAlignmentRight)];
        _amountLabel.bottom = _goodsPicImg.bottom;
    }
    return _amountLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(14)) textColor:kGrayTxtColor frame:CGRectMake(_goodsPicImg.right +ScaleW(14), 0, _goodsView.width - _goodsPicImg.right -ScaleW(15), ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
        _priceLabel.bottom = _goodsPicImg.bottom;
    }
    return _priceLabel;
}
-(UIView *)addressView{
    if (!_addressView) {
        _addressView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(10) + _goodsView.bottom, ScaleW(345), ScaleW(85))];
        _addressView.backgroundColor = kWhiteColor;
        [_addressView setCornerRadius:ScaleW(5)];
    }
    return _addressView;
}
-(UILabel *)userNameLabel{
    if (!_userNameLabel) {
        _userNameLabel = [WLTools allocLabel:@"李帅 134574477441" font:systemFont(ScaleW(15)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(20), ScaleW(18), _addressView.width - ScaleW(40), ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _userNameLabel;
}
-(UILabel *)detailAddressLabel{
    if (!_detailAddressLabel) {
        _detailAddressLabel = [WLTools allocLabel:@"河南省郑州市金水区商都世贸中心D座2202室" font:systemFont(ScaleW(14)) textColor:kGrayTxtColor frame:CGRectMake(_userNameLabel.left, _userNameLabel.bottom + ScaleW(19), _userNameLabel.width, ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _detailAddressLabel;
}
-(UIView *)scoreView{
    if (!_scoreView) {
        _scoreView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(10) + _addressView.bottom, ScaleW(345), ScaleW(50))];
        _scoreView.backgroundColor = kWhiteColor;
        [_scoreView setCornerRadius:ScaleW(5)];
    }
    return _scoreView;
}
-(UILabel *)scoreNameLabel{
    if (!_scoreNameLabel) {
        _scoreNameLabel = [WLTools allocLabel:@"消耗积分" font:systemFont(ScaleW(14)) textColor:kGrayTxtColor frame:CGRectMake(_detailAddressLabel.left, 0, _detailAddressLabel.width, _scoreView.height) textAlignment:(NSTextAlignmentLeft)];
    }
    return _scoreNameLabel;
}
-(UILabel *)scoreLabel{
    if (!_scoreLabel) {
        _scoreLabel = [WLTools allocLabel:@"1000积分" font:systemFont(ScaleW(14)) textColor:kRedColor frame:CGRectMake(_detailAddressLabel.left, 0, _detailAddressLabel.width, _scoreView.height) textAlignment:(NSTextAlignmentRight)];
    }
    return _scoreLabel;
}
-(UIView *)moneyView{
    if (!_moneyView) {
        _moneyView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(10) + _scoreView.bottom, ScaleW(345), ScaleW(50))];
        _moneyView.backgroundColor = kWhiteColor;
        [_moneyView setCornerRadius:ScaleW(5)];
    }
    return _moneyView;
}
-(UILabel *)moneynameLabel{
    if (!_moneynameLabel) {
        _moneynameLabel = [WLTools allocLabel:@"消耗总金额" font:systemFont(ScaleW(14)) textColor:kGrayTxtColor frame:CGRectMake(_detailAddressLabel.left, 0, _detailAddressLabel.width, _scoreView.height) textAlignment:(NSTextAlignmentLeft)];
    }
    return _moneynameLabel;
}
-(UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [WLTools allocLabel:@"1000积分" font:systemFont(ScaleW(14)) textColor:kRedColor frame:CGRectMake(_detailAddressLabel.left, 0, _detailAddressLabel.width, _moneyView.height) textAlignment:(NSTextAlignmentRight)];
    }
    return _moneyLabel;
}
-(void)setModel:(LXMarketOrderDetailModel *)model{
    _model = model;

     NSString *statusString = @"";
  
     switch (_model.state.integerValue) {
             ///0待付款
         case 0:
         {
             statusString = @"待发货";
             
         }
             break;
            ///1已取消
         case 1:
         {
             statusString = @"待收货";
            
         }
             break;
             ///2工程服务中
         case 2:
         {
             statusString = @"已完成";
         }
             break;
        
         default:
             break;
     }
     
     self.headerMessageLabel.text =[NSString stringWithFormat:@"订单状态：%@", statusString];
    NSString *url = [WLTools imageURLWithURL:_model.goodsimage];
    [self.goodsPicImg sd_setImageWithURL:[NSURL URLWithString:url]];
    self.amountLabel.text =  [NSString stringWithFormat:@"X %@",_model.amounts];
    self.kindsLabel.text = _model.goodsname;
    [self.kindsLabel sizeToFit];
    _userNameLabel.text = [NSString stringWithFormat:@"%@ %@",_model.name,_model.phone];
    _detailAddressLabel.text = [NSString stringWithFormat:@"%@",_model.address];
    _scoreLabel.text =  [NSString stringWithFormat:@"%@积分",_model.goodsprice];
    _priceLabel.text = [NSString stringWithFormat:@"￥%@ 积分%@",_model.goodsprice1,_model.goodsprice];
    _moneyLabel.text = [NSString stringWithFormat:@"￥%@",_model.allprice1];
}
@end

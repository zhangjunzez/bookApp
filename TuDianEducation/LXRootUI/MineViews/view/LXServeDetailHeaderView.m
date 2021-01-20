//
//  LXServeDetailHeaderView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/29.
//  Copyright © 2020 zhangbenchao. All rights reserved.

#import "LXServeDetailHeaderView.h"
#import "LXOrderMessageValueItemView.h"
@interface LXServeDetailHeaderView()
@property (nonatomic,strong) UIView *headerMessageView;
@property (nonatomic,strong) UILabel *headerMessageLabel;
@property (nonatomic,strong) UIView *goodsView;
@property (nonatomic,strong) UIImageView *goodsPicImg;
@property (nonatomic,strong) UILabel *kindsLabel;
@property (nonatomic,strong) UILabel *subKindsLabel;
@property (nonatomic,strong) UIView *addressView;
@property (nonatomic,strong) UILabel *userNameLabel;
@property (nonatomic,strong) UIImageView *addressImg;
@property (nonatomic,strong) UILabel *detailAddressLabel;
@property (nonatomic,strong) LXOrderMessageValueItemView *scoreView;
@property (nonatomic,strong) LXOrderMessageValueItemView *amountView;
@property (nonatomic,strong) LXOrderMessageValueItemView *quanView;
@property (nonatomic,strong) LXOrderMessageValueItemView *orderAmountView;

@end

@implementation LXServeDetailHeaderView

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
    self.backgroundColor = kWhiteColor;
    [self addSubview:self.headerMessageView];
    [self.headerMessageView addSubview:self.headerMessageLabel];
    [self addSubview:self.addressView];
    [self.addressView addSubview:self.addressImg];
    [self.addressView addSubview:self.userNameLabel];
    [self.addressView addSubview:self.detailAddressLabel];
    [self addSubview:self.goodsView];
    [self.goodsView addSubview:self.goodsPicImg];
    [self.goodsView addSubview:self.kindsLabel];
    [self.goodsView addSubview:self.subKindsLabel];
    [self addSubview:self.scoreView];
    [self addSubview:self.amountView];
    [self addSubview:self.quanView];
    [self addSubview:self.orderAmountView];
  
    self.height = self.orderAmountView.bottom;
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
        _headerMessageLabel = [WLTools allocLabel:@"订单当前状态：待付款" font:systemFont(14) textColor:kWhiteColor frame:CGRectMake(ScaleW(29), 0, ScreenWidth - ScaleW(29), _headerMessageView.height) textAlignment:(NSTextAlignmentLeft)];
    }
    return _headerMessageLabel;
}
-(UIView *)addressView{
    if (!_addressView) {
        _addressView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(10) + _headerMessageView.bottom, ScaleW(345), ScaleW(80))];
        _addressView.backgroundColor = kMainBgColor;
    }
    return _addressView;
}
-(UIImageView *)addressImg{
    if (!_addressImg) {
        _addressImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(7), ScaleW(12), ScaleW(20), ScaleW(20))];
        //_addressImg.backgroundColor = kBlueColor;
        _addressImg.image = [UIImage imageNamed:@"wode_changyongdizhi"];
    }
    return _addressImg;;
}
-(UILabel *)userNameLabel{
    if (!_userNameLabel) {
        _userNameLabel = [WLTools allocLabel:@"李帅 134574477441" font:systemFont(ScaleW(15)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(12) + _addressImg.right, ScaleW(5), _addressView.width - ScaleW(24) - _addressImg.right, ScaleW(36)) textAlignment:(NSTextAlignmentLeft)];
        _userNameLabel.numberOfLines = 2;
    }
    return _userNameLabel;
}
-(UILabel *)detailAddressLabel{
    if (!_detailAddressLabel) {
        _detailAddressLabel = [WLTools allocLabel:@"河南省郑州市金水区商都世贸中心D座2202室" font:systemFont(ScaleW(14)) textColor:kGrayTxtColor frame:CGRectMake(_userNameLabel.left, _userNameLabel.bottom + ScaleW(5), _userNameLabel.width, ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
        _detailAddressLabel.numberOfLines = 0;
        [_detailAddressLabel sizeToFit];
        
    }
    return _detailAddressLabel;
}
-(UIView *)goodsView{
    if (!_goodsView) {
        _goodsView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(0), ScaleW(10) + _addressView.bottom, ScreenWidth, ScaleW(82))];
        _goodsView.backgroundColor = kWhiteColor;
    }
    return _goodsView;
}
-(UIImageView *)goodsPicImg{
    if (!_goodsPicImg) {
        _goodsPicImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(13),ScaleW(10),ScaleW(62) , ScaleW(62))];
        _goodsPicImg.backgroundColor = kBlueColor;
    }
    return _goodsPicImg;
}
-(UILabel *)kindsLabel{
    if (!_kindsLabel) {
        _kindsLabel = [WLTools allocLabel:@"服务标题" font:systemBoldFont(ScaleW(15)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(10) + _goodsPicImg.right, ScaleW(5) + _goodsPicImg.top , _goodsView.width - _goodsPicImg.right- ScaleW(10)*2, ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _kindsLabel;
}
-(UILabel *)subKindsLabel{
    if (!_subKindsLabel) {
        _subKindsLabel = [WLTools allocLabel:@"副标题副标题内容副标题副标题内容副标题副标题内容副标题副标题内容副" font:systemFont(ScaleW(14)) textColor:kGrayTxtColor frame:CGRectMake(_kindsLabel.left, ScaleW(9) + _kindsLabel.bottom, _kindsLabel.width, ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
        _subKindsLabel.numberOfLines = 0;
        [_subKindsLabel sizeToFit];
    }
    return _subKindsLabel;
}

- (LXOrderMessageValueItemView *)scoreView{
    if (!_scoreView) {
        _scoreView = [[LXOrderMessageValueItemView alloc]initWithTop:_goodsView.bottom titleString:@"可获得积分" valueString:@"200" isRedValue:YES];
    }
    return _scoreView;
}
-(LXOrderMessageValueItemView *)amountView{
    if (!_amountView) {
        _amountView = [[LXOrderMessageValueItemView alloc]initWithTop:_scoreView.bottom titleString:@"预约金额" valueString:@"￥0" isRedValue:YES];
    }
    return _amountView;
}
-(LXOrderMessageValueItemView *)quanView{
    if (!_quanView) {
        _quanView = [[LXOrderMessageValueItemView alloc]initWithTop:_amountView.bottom titleString:@"优惠券" valueString:@"-￥0" isRedValue:YES];
    }
    return _quanView;
}

-(LXOrderMessageValueItemView *)orderAmountView{
    if (!_orderAmountView) {
        _orderAmountView = [[LXOrderMessageValueItemView alloc]initWithTop:_quanView.bottom titleString:@"订单总额" valueString:@"￥300" isRedValue:YES];
    }
    return _orderAmountView;
}
-(void)setModel:(LXServerOrderDetailModel *)model{
    _model = model;
    _headerMessageLabel.text = [NSString stringWithFormat:@"订单当前状态：%@",_model.serverStausString];
    _userNameLabel.text =  [NSString stringWithFormat:@"%@  %@",_model.name,_model.phone];
    _detailAddressLabel.text = _model.addressdetail;
    NSString *url = @"";
    if (_model.servicesbannerimages) {
        url = _model.servicesbannerimages;
    }
    [_goodsPicImg sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:url]]];
    _kindsLabel.text = _model.servicesname;
    _subKindsLabel.text = _model.servicestitle;
    _amountView.valueLabel.text =[NSString stringWithFormat:@"￥%.2f",_model.allprice.doubleValue + _model.cmprice.doubleValue];
    _quanView.valueLabel.text = [NSString stringWithFormat:@"-￥%@",_model.cmprice];
    ///_scoreView.valueLabel.text = _model.
    _orderAmountView.valueLabel.text =[NSString stringWithFormat:@"￥%@",_model.allprice];
    
    
}
@end

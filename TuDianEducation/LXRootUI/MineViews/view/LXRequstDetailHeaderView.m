//
//  LXRequstDetailHeaderView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/29.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//


#import "LXRequstDetailHeaderView.h"
#import "LXOrderMessageValueItemView.h"
#import "LXTitleImgView.h"
#import "LXSaveUserInforTool.h"
#import "LXUserInforModel.h"

@interface LXRequstDetailHeaderView()
@property (nonatomic,strong) UIView *headerMessageView;
@property (nonatomic,strong) UILabel *headerMessageLabel;
@property (nonatomic,strong) UIView *goodsMessageView;
@property (nonatomic,strong) UIImageView *headerImgView;
@property (nonatomic,strong) UILabel *bkNameLabel;
@property (nonatomic,strong) UILabel *moneyLabel;
@property (nonatomic,strong) UILabel *sevendaysLabel;
@property (nonatomic,strong) UILabel *amountLabel;
@property (nonatomic,strong) LXOrderMessageValueItemView *goodsAllPriceView;
@property (nonatomic,strong) LXOrderMessageValueItemView *yunfeiView;
@property (nonatomic,strong) LXOrderMessageValueItemView *youhui;
@property (nonatomic,strong) LXOrderMessageValueItemView *orderAllPriceView;

@property (nonatomic,strong) UIView *addressView;
@property (nonatomic,strong) UIImageView *addressImg;
@property (nonatomic,strong) UILabel *detailAddressLabel;
@property (nonatomic,strong) UIImageView *gotoImg;
@property (nonatomic,strong) UILabel *userNameLabel;





@end

@implementation LXRequstDetailHeaderView

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
    self.backgroundColor = kSubBacColor;
    [self addSubview:self.headerMessageView];
    [self.headerMessageView addSubview:self.headerMessageLabel];
    [self addSubview:self.addressView];
    [self.addressView addSubview:self.addressImg];
    [self.addressView addSubview:self.detailAddressLabel];
    [self.addressView addSubview:self.userNameLabel];
    
    [self.addressView addSubview:self.gotoImg];
    [self addSubview:self.goodsMessageView];
    [self.goodsMessageView addSubview:self.headerImgView];
    [self.goodsMessageView addSubview:self.bkNameLabel];
    [self.goodsMessageView addSubview:self.moneyLabel];
    [self.goodsMessageView addSubview:self.sevendaysLabel];
    [self.goodsMessageView addSubview:self.amountLabel];
    [self.goodsMessageView addSubview:self.goodsAllPriceView];
    [self.goodsMessageView addSubview:self.yunfeiView];
    [self.goodsMessageView addSubview:self.youhui];
    [self.goodsMessageView addSubview:self.orderAllPriceView];
    self.goodsMessageView.height = self.orderAllPriceView.bottom + ScaleW(5);
    self.height = self.goodsMessageView.bottom + ScaleW(6);
    
   
   
}
-(UIView *)headerMessageView{
    if (!_headerMessageView) {
        _headerMessageView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(40))];
       
    }
    return _headerMessageView;
}
-(UILabel *)headerMessageLabel
{
    if (!_headerMessageLabel) {
        _headerMessageLabel = [WLTools allocLabel:@"待付款" font:systemBoldFont(20) textColor:kMainTxtColor frame:CGRectMake(ScaleW(11), 0, ScreenWidth - ScaleW(29), _headerMessageView.height) textAlignment:(NSTextAlignmentLeft)];
    }
    return _headerMessageLabel;
}
-(UIView *)addressView{
    if (!_addressView) {
        _addressView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(12), ScaleW(10) + _headerMessageView.bottom, ScaleW(350), ScaleW(84))];
        _addressView.backgroundColor = kWhiteColor;
        [_addressView setCornerRadius:ScaleW(10)];
         UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoAddressVc)];
        _addressView.userInteractionEnabled = YES;
        [_addressView addGestureRecognizer:tap];
    }
    return _addressView;
}
-(UIImageView *)addressImg{
    if (!_addressImg) {
        _addressImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(10), ScaleW(36), ScaleW(12), ScaleW(12))];
        _addressImg.image = [UIImage imageNamed:@"shouhuodizhi"];
        
    }
    return _addressImg;;
}
-(UILabel *)detailAddressLabel{
    if (!_detailAddressLabel) {
        _detailAddressLabel = [WLTools allocLabel:@"河南省郑州市金水区商都世贸中心D座2202室" font:systemFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(10) + _addressImg.right,  ScaleW(27), ScaleW(300), ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
       
        
    }
    return _detailAddressLabel;
}
-(UILabel *)userNameLabel{
    if (!_userNameLabel) {
        _userNameLabel = [WLTools allocLabel:@"李帅 134574477441" font:systemFont(ScaleW(12)) textColor:kGrayTxtColor frame:CGRectMake(ScaleW(12) + _addressImg.right, _detailAddressLabel.bottom + ScaleW(8), ScaleW(300), ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _userNameLabel;
}

-(UIImageView *)gotoImg{
    if (!_gotoImg) {
        _gotoImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"chakanquanbu"]];
        _gotoImg.right = _addressView.width - ScaleW(10);
        _gotoImg.centerY = _addressView.height/2.f;
        _gotoImg.hidden = YES;
    }
    return _gotoImg;
}
-(UIView *)goodsMessageView{
    if (!_goodsMessageView) {
        _goodsMessageView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(13), ScaleW(10) + _addressView.bottom, ScreenWidth - ScaleW(26), ScaleW(82))];
        _goodsMessageView.backgroundColor = kWhiteColor;
        _goodsMessageView.cornerRadius = ScaleW(10);
    }
    return _goodsMessageView;
}
-(UIImageView *)headerImgView{
    if (!_headerImgView) {
        _headerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(23), ScaleW(47), ScaleW(63))];
        _headerImgView.backgroundColor = kGrayTxtColor;

    }
    return _headerImgView;
}
-(UILabel *)bkNameLabel{
    if (!_bkNameLabel) {
        _bkNameLabel = [WLTools allocLabel:@"初中数学运算大法" font:systemFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(_headerImgView.right + ScaleW(10),  _headerImgView.top + ScaleW(4), ScaleW(210), ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
        //_bkNameLabel.numberOfLines = 0;
    }
    return _bkNameLabel;
}
-(UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [WLTools allocLabel:@"￥999.00" font:systemFont(ScaleW(12)) textColor:kMainTxtColor frame:CGRectMake(_headerImgView.right + ScaleW(10), _bkNameLabel.top, ScaleW(260), ScaleW(15)) textAlignment:(NSTextAlignmentRight)];
        NSString *string = _moneyLabel.text;
        NSMutableAttributedString *atts = [[NSMutableAttributedString alloc] initWithString:string];
        [atts setAttributes:@{NSFontAttributeName:systemBoldFont(ScaleW(15))} range:NSMakeRange(1,  string.length - 4)];
        _moneyLabel.attributedText = atts;
    }
    return _moneyLabel;
}
-(UILabel *)sevendaysLabel{
    if (!_sevendaysLabel) {
        _sevendaysLabel = [WLTools allocLabel:@"7天无理由退换" font:systemFont(10) textColor:UIColorFromRGB(0xD95F35) frame:CGRectMake(_bkNameLabel.left, ScaleW(9) + _bkNameLabel.bottom, ScaleW(80), ScaleW(15)) textAlignment:(NSTextAlignmentCenter)];
        _sevendaysLabel.backgroundColor = UIColorFromRGB(0xFFF1F1);
        _sevendaysLabel.cornerRadius = _sevendaysLabel.height/2.f;
        
    }
    return _sevendaysLabel;
}
-(UILabel *)amountLabel{
    if (!_amountLabel) {
        _amountLabel = [WLTools allocLabel:@"x1" font:systemFont(12) textColor:kGrayTxtColor frame:CGRectMake(_moneyLabel.left, ScaleW(37) + _moneyLabel.bottom, _moneyLabel.width , ScaleW(12)) textAlignment:(NSTextAlignmentRight)];
    }
    return _amountLabel;
}

- (LXOrderMessageValueItemView *)goodsAllPriceView{
    if (!_goodsAllPriceView) {
        _goodsAllPriceView = [[LXOrderMessageValueItemView alloc]initWithTop:ScaleW(23) + _headerImgView.bottom titleString:@"商品总价" valueString:@"￥80.00" isRedValue:NO];
        _goodsAllPriceView.titleLabel.textColor = kGrayTxtColor;
        _goodsAllPriceView.titleLabel.font = systemFont(ScaleW(12));
        _goodsAllPriceView.valueLabel.textColor = kMainTxtColor;
        _goodsAllPriceView.valueLabel.font = systemFont(ScaleW(12));
        NSString *string = _goodsAllPriceView.valueLabel.text;
        NSMutableAttributedString *atts = [[NSMutableAttributedString alloc] initWithString:string];
        [atts setAttributes:@{NSFontAttributeName:systemBoldFont(ScaleW(15))} range:NSMakeRange(1,  string.length - 4)];
        _goodsAllPriceView.valueLabel.attributedText = atts;
    }
    return _goodsAllPriceView;
}
- (LXOrderMessageValueItemView *)yunfeiView{
    if (!_yunfeiView) {
        _yunfeiView = [[LXOrderMessageValueItemView alloc]initWithTop: _goodsAllPriceView.bottom titleString:@"运费" valueString:@"￥80.00" isRedValue:NO];
        _yunfeiView.titleLabel.textColor = kGrayTxtColor;
        _yunfeiView.titleLabel.font = systemFont(ScaleW(12));
        _yunfeiView.valueLabel.textColor = kGrayTxtColor;
        _yunfeiView.valueLabel.font = systemFont(ScaleW(12));
        NSString *string = _yunfeiView.valueLabel.text;
        NSMutableAttributedString *atts = [[NSMutableAttributedString alloc] initWithString:string];
        [atts setAttributes:@{NSFontAttributeName:systemBoldFont(ScaleW(15))} range:NSMakeRange(1,  string.length - 4)];
        _yunfeiView.valueLabel.attributedText = atts;
    }
    return _yunfeiView;
}
- (LXOrderMessageValueItemView *)youhui{
    if (!_youhui) {
        _youhui = [[LXOrderMessageValueItemView alloc]initWithTop:_yunfeiView.bottom titleString:@"商品总价" valueString:@"￥80.00" isRedValue:NO];
        _youhui.titleLabel.textColor = kGrayTxtColor;
        _youhui.titleLabel.font = systemFont(ScaleW(12));
        _youhui.valueLabel.textColor = kGreenColor;
        _youhui.valueLabel.font = systemFont(ScaleW(12));
        
    }
    return _youhui;
}
- (LXOrderMessageValueItemView *)orderAllPriceView{
    if (!_orderAllPriceView) {
        _orderAllPriceView = [[LXOrderMessageValueItemView alloc]initWithTop:ScaleW(10) + _youhui.bottom titleString:@"订单总价" valueString:@"￥80.00" isRedValue:YES];
        _orderAllPriceView.titleLabel.textColor = kMainTxtColor;
        _orderAllPriceView.titleLabel.font = systemFont(ScaleW(12));
        _orderAllPriceView.valueLabel.font = systemFont(ScaleW(12));
        NSString *string = _orderAllPriceView.valueLabel.text;
        NSMutableAttributedString *atts = [[NSMutableAttributedString alloc] initWithString:string];
        [atts setAttributes:@{NSFontAttributeName:systemBoldFont(ScaleW(15))} range:NSMakeRange(1,  string.length - 4)];
        _orderAllPriceView.valueLabel.attributedText = atts;
    }
    return _orderAllPriceView;
}
-(void)gotoAddressVc{
    !self.gotoAddressBlock?:self.gotoAddressBlock();
}

@end

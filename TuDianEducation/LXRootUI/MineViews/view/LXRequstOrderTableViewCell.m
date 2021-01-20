//
//  LXRequstOrderTableViewCell.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/28.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//
typedef NS_ENUM(NSInteger,OrderCellUiStyle) {
    OrderCellUiStyleBottomTimeStyle,
    OrderCellUiStyleBottomComfimBtnStyle,
    OrderCellUiStyleNoBottomStyle,
};
typedef NS_ENUM(NSInteger,OrderStatusType) {
    OrderStatusTypeWaitPay,///等待付款
    OrderStatusTypeIsGoing,///进行中
    OrderStatusTypeWaitRate,///待评论
    OrderStatusTypeHasDone,///已完成
    OrderStatusSomethingWrong,///异常
};
#import "LXRequstOrderTableViewCell.h"
@interface LXRequstOrderTableViewCell()
@property (nonatomic,assign) OrderStatusType statusType;
@property (nonatomic,assign) OrderCellUiStyle UiStyle;
@property (nonatomic, strong) UIView *bacView;
@property (nonatomic, strong) UILabel *orderNumLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIView *septorLine;
@property (nonatomic,strong) UILabel *bkNameLabel;
@property (nonatomic,strong) UILabel *moneyLabel;
@property (nonatomic,strong) UILabel *sevendaysLabel;
@property (nonatomic,strong) UILabel *amountLabel;
@property (nonatomic,strong) UIView *bottomLine;
@property (nonatomic,strong) UIButton *confirmDoneBtn;
@property (nonatomic,strong) UILabel *totalAmountLabel;
@property (nonatomic,strong) UILabel *totalLabel;
@property (nonatomic,strong) UIImageView *headerImgView;
@property (nonatomic,strong) UIButton *cancellBtn;
@end

@implementation LXRequstOrderTableViewCell

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
    self.contentView.backgroundColor = kMainBgColor;
    [self.contentView addSubview:self.bacView];
    [self.bacView addSubview:self.orderNumLabel];
    [self.bacView addSubview:self.statusLabel];
    [self.bacView addSubview:self.septorLine];
    [self.bacView addSubview:self.headerImgView];
    [self.bacView addSubview:self.bkNameLabel];
    [self.bacView addSubview:self.moneyLabel];
    [self.bacView addSubview:self.sevendaysLabel];
    [self.bacView addSubview:self.amountLabel];
     [self.bacView addSubview:self.bottomLine];
    [self.bacView addSubview:self.totalAmountLabel];
    [self.bacView addSubview:self.totalLabel];
    
    [self.bacView addSubview:self.confirmDoneBtn];
    [self.bacView addSubview:self.cancellBtn];
    
}
-(UIView *)bacView{
    if (!_bacView) {
        _bacView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(10), ScaleW(345), ScaleW(230))];
        _bacView.backgroundColor = kWhiteColor;
        [_bacView setCornerRadius:ScaleW(10)];
    }
    return _bacView;
}
-(UILabel *)orderNumLabel{
    if (!_orderNumLabel) {
        _orderNumLabel = [WLTools allocLabel:@"订单编号：20201525452" font:systemFont(ScaleW(12)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(15), ScaleW(17), _bacView.width - ScaleW(15)*2, ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _orderNumLabel;
}
-(UILabel *)statusLabel{
    if (!_statusLabel) {
        _statusLabel = [WLTools allocLabel:@"已完成" font:systemFont(ScaleW(13)) textColor:kGreenColor frame:CGRectMake(ScaleW(15), ScaleW(17), _bacView.width - ScaleW(15)*2, ScaleW(13)) textAlignment:(NSTextAlignmentRight)];
    }
    return _statusLabel;
}
-(UIView *)septorLine
{
    if (!_septorLine) {
        _septorLine = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(14) + _orderNumLabel.bottom, _orderNumLabel.width, .5)];
        _septorLine.backgroundColor = kMainLineColor;
    }
    return _septorLine;
}
-(UIImageView *)headerImgView{
    if (!_headerImgView) {
        _headerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(15) + _septorLine.bottom, ScaleW(47), ScaleW(63))];
        _headerImgView.backgroundColor = kGrayTxtColor;

    }
    return _headerImgView;
}
-(UILabel *)bkNameLabel{
    if (!_bkNameLabel) {
        _bkNameLabel = [WLTools allocLabel:@"初中数学运算大法" font:systemFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(_headerImgView.right + ScaleW(10),  _septorLine.bottom + ScaleW(18), ScaleW(210), ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
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
-(UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(_headerImgView.left, ScaleW(13) + _headerImgView.bottom, ScaleW(318), .5)];
        _bottomLine.backgroundColor = kMainLineColor;
       }
       return _bottomLine;
}
-(UILabel *)totalAmountLabel
{
    if (!_totalAmountLabel) {
        _totalAmountLabel = [WLTools allocLabel:@"共1件商品" font:systemFont(12) textColor:kMainTxtColor frame:CGRectMake(ScaleW(15), ScaleW(14) + _bottomLine.bottom, _bacView.width - ScaleW(15)*2, ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _totalAmountLabel;
}
-(UILabel *)totalLabel
{
    if (!_totalLabel) {
        _totalLabel = [WLTools allocLabel:@"合计：￥100.00" font:systemFont(12) textColor:kMainTxtColor frame:CGRectMake(ScaleW(15), ScaleW(14) + _bottomLine.bottom, _bacView.width - ScaleW(15)*2, ScaleW(12)) textAlignment:(NSTextAlignmentRight)];
        NSString *string = _totalLabel.text;
        NSMutableAttributedString *atts = [[NSMutableAttributedString alloc] initWithString:string];
        [atts setAttributes:@{NSFontAttributeName:systemBoldFont(ScaleW(15))} range:NSMakeRange(4,  string.length - 7)];
        _totalLabel.attributedText = atts;
    }
    return _totalLabel;
}
-(UIButton *)confirmDoneBtn{
    if (!_confirmDoneBtn) {
        _confirmDoneBtn = [WLTools allocButtonTitle:@"去付款" font:systemFont(ScaleW(14)) textColor:kGreenColor image:nil frame:CGRectMake(ScaleW(260), ScaleW(52) + _bottomLine.bottom, ScaleW(75), ScaleW(26)) sel:@selector(confirmDoneBtnAction:) taget:self];
        [_confirmDoneBtn setBorderWithWidth:1 andColor:kGreenColor];
        [_confirmDoneBtn setCornerRadius:_confirmDoneBtn.height/2.f];
    }
    return _confirmDoneBtn;
}
-(UIButton *)cancellBtn{
    if (!_cancellBtn) {
        _cancellBtn = [WLTools allocButtonTitle:@"取消订单" font:systemFont(ScaleW(14)) textColor:kSubTxtColor image:nil frame:CGRectMake(ScaleW(165), ScaleW(52) + _bottomLine.bottom, ScaleW(75), ScaleW(26)) sel:@selector(confirmDoneBtnAction:) taget:self];
        [_cancellBtn setBorderWithWidth:1 andColor:kGrayTxtColor];
        [_cancellBtn setCornerRadius:_confirmDoneBtn.height/2.f];
    }
    return _cancellBtn;
}
#pragma mark  ---Action

-(void)confirmDoneBtnAction:(UIButton *)sender
{
    !self.ensureBtnBlock?:self.ensureBtnBlock();
}
#pragma mark --getterSetter

-(void)setUiStyle:(OrderCellUiStyle)UiStyle
{
    _UiStyle = UiStyle;
     _bottomLine.hidden = _totalAmountLabel.hidden = _confirmDoneBtn.hidden = NO;
    switch (_UiStyle) {
        case OrderCellUiStyleNoBottomStyle:
        {
            _bottomLine.hidden = _totalAmountLabel.hidden = _confirmDoneBtn.hidden = YES;
        }
            break;
         case OrderCellUiStyleBottomTimeStyle:
        {
            _confirmDoneBtn.hidden = YES;
        }
            break;
        case OrderCellUiStyleBottomComfimBtnStyle:
        {
            _totalAmountLabel.hidden = YES;
        }
            break;
        default:
            break;
    }
}
-(void)setModel:(LXMineRequstOrderListModel *)model{
    //工程师端订单状态只有4及以后的状态 0待审核 1审核失败 2待接单 3已取消 4待支付 5工程师服务中 6用户待确认 7待评价 8已完成 9异常订单
    _model = model;
   // CGFloat height = ScaleW(168);
    CGFloat height = ScaleW(218);
    NSString *statusString = @"";
    OrderCellUiStyle style = OrderCellUiStyleNoBottomStyle;
    switch (_model.state.integerValue) {
            ///用户已取消
        case 3:
        {
            height = ScaleW(168);
            statusString = @"用户已取消";
            style = OrderCellUiStyleNoBottomStyle;
            break;
        }
            ///4待支付
        case 4:
        {
            
            statusString = @"待支付";
            style = OrderCellUiStyleBottomTimeStyle;
            height = ScaleW(218);
        }
            break;
            ///5工程师服务中
        case 5:
        {
            statusString = @"工程师服务中";
            style = OrderCellUiStyleBottomComfimBtnStyle;
            [self.confirmDoneBtn setTitle:@"确认完成" forState:(UIControlStateNormal)];
            self.ensureBtnBlock = self.confirmDoneBlock;
            height = ScaleW(218);
        }
            break;
            ///6用户待确认
        case 6:
        {
            height = ScaleW(168);
            statusString = @"用户待确认";
            style = OrderCellUiStyleNoBottomStyle;
        }
            break;
            ///7待评价
        case 7:
        {
            height = ScaleW(168);
            statusString = @"待评价";
            style = OrderCellUiStyleNoBottomStyle;
        }
            break;
            ///8已完成
        case 8:
        {
            statusString = @"已完成";
            style = OrderCellUiStyleBottomComfimBtnStyle;
             [self.confirmDoneBtn setTitle:@"删除" forState:(UIControlStateNormal)];
            self.ensureBtnBlock = self.deleteOrderBlock;
            height = ScaleW(218);
        }
            break;
            ///9异常订单
        case 9:
        {
            height = ScaleW(168);
            style = OrderCellUiStyleNoBottomStyle;
            statusString = @"异常订单";
        }
            break;
        default:
            break;
    }
    self.UiStyle = style;
    self.statusLabel.text = statusString;
    self.bacView.height = height;
    _orderNumLabel.text = [NSString stringWithFormat:@"订单编号:%@",_model.ordernum];
    _bkNameLabel.text = [NSString stringWithFormat:@"%@--%@",_model.industrys,_model.equipmentname];
    _bkNameLabel.width = _bacView.width - ScaleW(120);
    [_bkNameLabel sizeToFit];
    _moneyLabel.text = [NSString stringWithFormat:@"酬金:￥%@",_model.price];
    _sevendaysLabel.text = [NSString stringWithFormat:@"期望到达时间:%@",_model.expecttime];
    _amountLabel.text = [NSString stringWithFormat:@"创建时间:%@",_model.adtime];
    _sevendaysLabel.top = ScaleW(27) + _bkNameLabel.bottom;
     _amountLabel.top = ScaleW(27) + _sevendaysLabel.bottom;
    _bottomLine.top = ScaleW(16) + _amountLabel.bottom;
   
    _totalAmountLabel.top = _bacView.height - _bottomLine.bottom;
    _confirmDoneBtn.top = ScaleW(6) + _bottomLine.bottom;
     _bacView.height = height - ScaleW(14) + _model.offHeight;
    _totalAmountLabel.top = _bottomLine.bottom;
   
}

@end

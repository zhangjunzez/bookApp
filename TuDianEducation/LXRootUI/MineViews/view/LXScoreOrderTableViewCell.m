//
//  LXScoreOrderTableViewCell.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/29.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

typedef NS_ENUM(NSInteger,OrderCellUiStyle) {
    OrderCellUiStyleBottomTimeStyle,
    OrderCellUiStyleBottomComfimBtnStyle,
    OrderCellUiStyleNoBottomStyle,
    OrderCellUiStyleOneDeleteStyle,
};
typedef NS_ENUM(NSInteger,OrderServerStatusType) {
    OrderServerStatusTypeWaitSetting,///等待发货
    OrderServerStatusTypeWaitGetting,///待收货
   // OrderServerStatusTypeWaitRate,///待评论
    OrderServerStatusTypeHasDone,///已完成
    OrderStatusSomethingWrong,///异常
};
#import "LXScoreOrderTableViewCell.h"
@interface LXScoreOrderTableViewCell()
@property (nonatomic,assign) OrderServerStatusType statusType;
@property (nonatomic,assign) OrderCellUiStyle UiStyle;
@property (nonatomic, strong) UIView *bacView;
@property (nonatomic, strong) UILabel *orderNumLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIView *septorLine;
@property (nonatomic,strong) UIImageView *goodsPicImg;
@property (nonatomic,strong) UILabel *kindsLabel;
@property (nonatomic,strong) UILabel *moneyLabel;
@property (nonatomic,strong) UILabel *wantDateLabel;
@property (nonatomic,strong) UILabel *createDateLabel;
@property (nonatomic,strong) UIView *bottomLine;
@property (nonatomic,strong) UIButton *confirmDoneBtn;
@property (nonatomic,strong) UIButton *seeFlowBtn;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *amountlabel;
@end

@implementation LXScoreOrderTableViewCell

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
    [self.bacView addSubview:self.goodsPicImg];
    [self.bacView addSubview:self.kindsLabel];
  
    [self.bacView addSubview:self.moneyLabel];
  
    [self.bacView addSubview:self.createDateLabel];
     [self.bacView addSubview:self.bottomLine];
    [self.bacView addSubview:self.timeLabel];
    [self.bacView addSubview:self.amountlabel];
    
    [self.bacView addSubview:self.confirmDoneBtn];
    [self.bacView addSubview:self.seeFlowBtn];
    
}
-(UIView *)bacView{
    if (!_bacView) {
        _bacView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(10), ScaleW(345), ScaleW(245))];
        _bacView.backgroundColor = kWhiteColor;
        [_bacView setCornerRadius:ScaleW(8)];
    }
    return _bacView;
}
-(UILabel *)orderNumLabel{
    if (!_orderNumLabel) {
        _orderNumLabel = [WLTools allocLabel:@"订单编号：20201525452" font:systemFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(15), ScaleW(17), _bacView.width - ScaleW(15)*2, ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _orderNumLabel;
}
-(UILabel *)statusLabel{
    if (!_statusLabel) {
        _statusLabel = [WLTools allocLabel:@"已完成" font:systemFont(ScaleW(13)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(15), ScaleW(17), _bacView.width - ScaleW(15)*2, ScaleW(13)) textAlignment:(NSTextAlignmentRight)];
    }
    return _statusLabel;
}
-(UIView *)septorLine
{
    if (!_septorLine) {
        _septorLine = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(13) + _orderNumLabel.bottom, _bacView.width, .5)];
        _septorLine.backgroundColor = kMainBgColor;
    }
    return _septorLine;
}
-(UIImageView *)goodsPicImg{
    if (!_goodsPicImg) {
        _goodsPicImg = [[UIImageView alloc]initWithFrame:CGRectMake(_orderNumLabel.left, _septorLine.bottom + ScaleW(13),ScaleW(90) , ScaleW(90))];
        _goodsPicImg.backgroundColor = kBlueColor;
    }
    return _goodsPicImg;
}
-(UILabel *)kindsLabel{
    if (!_kindsLabel) {
        _kindsLabel = [WLTools allocLabel:@"科学减重体脂秤" font:systemFont(ScaleW(16)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(14) + _goodsPicImg.right, ScaleW(20) + _septorLine.bottom, _bacView.width - _goodsPicImg.right- ScaleW(15)*2, ScaleW(16)) textAlignment:(NSTextAlignmentLeft)];
        _kindsLabel.numberOfLines = 0;
    }
    return _kindsLabel;
}
-(UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [WLTools allocLabel:@"酬金：￥999" font:systemFont(ScaleW(14)) textColor:kRedColor frame:CGRectMake(ScaleW(15), _kindsLabel.top, _bacView.width - ScaleW(15)*2, ScaleW(14)) textAlignment:(NSTextAlignmentRight)];
        _moneyLabel.bottom = _goodsPicImg.bottom;
    }
    return _moneyLabel;
}

-(UILabel *)createDateLabel{
    if (!_createDateLabel) {
        _createDateLabel = [WLTools allocLabel:@"创建时间：2020-04-21  14:32" font:systemFont(12) textColor:kMainTxtColor frame:CGRectMake(ScaleW(15), ScaleW(122) + _septorLine.bottom, _bacView.width - ScaleW(15)*2, ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _createDateLabel;
}
-(UILabel *)amountlabel{
    if (!_amountlabel) {
        _amountlabel = [WLTools allocLabel:@"x1" font:systemFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(15), _kindsLabel.top, _bacView.width - ScaleW(15)*2, ScaleW(14)) textAlignment:(NSTextAlignmentRight)];
        _amountlabel.bottom = _timeLabel.bottom;
    }
    return _amountlabel;
}
-(UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(5) + _createDateLabel.bottom, _bacView.width, .5)];
        _bottomLine.backgroundColor = kMainBgColor;
       }
       return _bottomLine;
}
-(UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [WLTools allocLabel:@"30分钟后订单自动取消" font:systemFont(12) textColor:kGrayTxtColor frame:CGRectMake(ScaleW(15), _bottomLine.bottom, _bacView.width - ScaleW(15)*2, _bacView.height - _bottomLine.bottom) textAlignment:(NSTextAlignmentLeft)];
        _timeLabel.hidden = YES;
    }
    return _timeLabel;
}
-(UIButton *)confirmDoneBtn{
    if (!_confirmDoneBtn) {
        _confirmDoneBtn = [WLTools allocButtonTitle:@"确认完成" font:systemFont(ScaleW(14)) textColor:kMainTxtColor image:nil frame:CGRectMake(ScaleW(248), ScaleW(12) + _bottomLine.bottom, ScaleW(83), ScaleW(31)) sel:@selector(confirmDoneBtnAction:) taget:self];
        [_confirmDoneBtn setBorderWithWidth:1 andColor:kGrayTxtColor];
        [_confirmDoneBtn setCornerRadius:_confirmDoneBtn.height/2.f];
    }
    return _confirmDoneBtn;
}
-(UIButton *)seeFlowBtn{
    if (!_seeFlowBtn) {
        _seeFlowBtn = [WLTools allocButtonTitle:@"查看物流" font:systemFont(ScaleW(14)) textColor:kMainTxtColor image:nil frame:CGRectMake(ScaleW(151), ScaleW(12) + _bottomLine.bottom, ScaleW(83), ScaleW(31)) sel:@selector(seeFlowBtnAction:) taget:self];
        [_seeFlowBtn setBorderWithWidth:1 andColor:kGrayTxtColor];
        [_seeFlowBtn setCornerRadius:_confirmDoneBtn.height/2.f];
    }
    return _seeFlowBtn;
}
#pragma mark  ---Action

-(void)confirmDoneBtnAction:(UIButton *)sender
{
    !self.rightBtnBlock?:self.rightBtnBlock();
}
-(void)seeFlowBtnAction:(UIButton *)sender
{
    !self.seeFlowsBlock?:self.seeFlowsBlock();
}
#pragma mark --getterSetter

-(void)setUiStyle:(OrderCellUiStyle)UiStyle
{
    _UiStyle = UiStyle;
     _bottomLine.hidden = _seeFlowBtn.hidden = _confirmDoneBtn.hidden = NO;
    switch (_UiStyle) {
        case OrderCellUiStyleNoBottomStyle:
        {
            _bottomLine.hidden = _seeFlowBtn.hidden = _confirmDoneBtn.hidden = YES;
        }
            break;
        
        case OrderCellUiStyleBottomComfimBtnStyle:
        {
            _bottomLine.hidden = _seeFlowBtn.hidden = _confirmDoneBtn.hidden = NO;
            [_confirmDoneBtn setTitle:@"确认完成" forState:(UIControlStateNormal)];
            self.rightBtnBlock = self.confirmDoneBlock;
        }
            break;
            
        case OrderCellUiStyleOneDeleteStyle:
        {
            _bottomLine.hidden =  _confirmDoneBtn.hidden = NO;
            _seeFlowBtn.hidden = YES;
            [_confirmDoneBtn setTitle:@"删除" forState:(UIControlStateNormal)];
            self.rightBtnBlock = self.deleteBlock;
            
        }
            break;
        default:
            break;
    }
}
-(void)setModel:(LXScoreOrderListModel *)model{
    _model = model;
    ///状态 0待发货 1待收货 2已完成

       NSString *statusString = @"";
       OrderCellUiStyle style = OrderCellUiStyleNoBottomStyle;
       UIColor *color = kMainTxtColor;
       CGFloat height = ScaleW(196);
       switch (_model.state.integerValue) {
               ///0待付款
           case 0:
           {
               statusString = @"待发货";
               style = OrderCellUiStyleNoBottomStyle;
           }
               break;
              ///1已取消
           case 1:
           {
               statusString = @"待收货";
               style = OrderCellUiStyleBottomComfimBtnStyle;
               height = ScaleW(245);
           }
               break;
               ///2工程服务中
           case 2:
           {
               statusString = @"已完成";
               style = OrderCellUiStyleOneDeleteStyle;
               height = ScaleW(245);
           }
               break;
          
           default:
               break;
       }
       self.UiStyle = style;
       self.statusLabel.text = statusString;
       self.statusLabel.textColor = color;
       self.bacView.height = height;
       _orderNumLabel.text = [NSString stringWithFormat:@"订单编号：%@",_model.ordernum];
       _kindsLabel.text = [NSString stringWithFormat:@"%@",_model.goodsname];
       [_kindsLabel sizeToFit];
       _moneyLabel.text = [NSString stringWithFormat:@"实付：￥%@积分%@",_model.allprice1,_model.allprice];
       _createDateLabel.text = [NSString stringWithFormat:@"创建时间：%@",_model.adtime];
    _amountlabel.text = [NSString stringWithFormat:@"X %@",_model.amounts];
        NSString *urlString = [WLTools imageURLWithURL:_model.goodsimage];
       [_goodsPicImg sd_setImageWithURL:[NSURL URLWithString:urlString]];
  
}

@end

//
//  LXServerTableViewCell.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/29.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

typedef NS_ENUM(NSInteger,OrderCellUiStyle) {
    OrderCellUiStyleBottomTimeStyle,
    OrderCellUiStyleBottomComfimBtnStyle,
    OrderCellUiStyleNoBottomStyle,
};
typedef NS_ENUM(NSInteger,OrderServerStatusType) {
    OrderServerStatusTypeWaitPay,///等待付款
    OrderServerStatusTypeGoing,///进行中
    OrderServerStatusTypeWaitRate,///待评论
    OrderServerStatusTypeHasDone,///已完成
    OrderStatusSomethingWrong,///异常
};
#import "LXServerTableViewCell.h"
@interface LXServerTableViewCell()
@property (nonatomic,assign) OrderServerStatusType statusType;
@property (nonatomic,assign) OrderCellUiStyle UiStyle;
@property (nonatomic, strong) UIView *bacView;
@property (nonatomic, strong) UILabel *orderNumLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIView *septorLine;
@property (nonatomic,strong) UILabel *kindsLabel;
@property (nonatomic,strong) UILabel *moneyLabel;
@property (nonatomic,strong) UILabel *subTitleLabels;
@property (nonatomic,strong) UILabel *createDateLabel;
@property (nonatomic,strong) UIView *bottomLine;
@property (nonatomic,strong) UIButton *confirmDoneBtn;
@property (nonatomic,strong) UILabel *timeLabel;
@end

@implementation LXServerTableViewCell

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
    [self.bacView addSubview:self.kindsLabel];
    [self.bacView addSubview:self.moneyLabel];
    [self.bacView addSubview:self.subTitleLabels];
    [self.bacView addSubview:self.createDateLabel];
     [self.bacView addSubview:self.bottomLine];
    [self.bacView addSubview:self.timeLabel];
    
    [self.bacView addSubview:self.confirmDoneBtn];
    
}
-(UIView *)bacView{
    if (!_bacView) {
        _bacView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(10), ScaleW(345), ScaleW(223))];
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
-(UILabel *)kindsLabel{
    if (!_kindsLabel) {
        _kindsLabel = [WLTools allocLabel:@"行业分类--设备名称" font:systemFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(15), ScaleW(13) + _septorLine.bottom, _bacView.width - ScaleW(15)*2, ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _kindsLabel;
}
-(UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [WLTools allocLabel:@"酬金：￥999" font:systemFont(ScaleW(13)) textColor:kRedColor frame:CGRectMake(ScaleW(15), _kindsLabel.top, _bacView.width - ScaleW(15)*2, ScaleW(13)) textAlignment:(NSTextAlignmentRight)];
    }
    return _moneyLabel;
}
-(UILabel *)subTitleLabels{
    if (!_subTitleLabels) {
        _subTitleLabels = [WLTools allocLabel:@"服务副标题服务副标题服务副标题服务副标题服务副标题" font:systemFont(14) textColor:kMainTxtColor frame:CGRectMake(ScaleW(15), ScaleW(27) + _kindsLabel.bottom, _bacView.width - ScaleW(15)*2, ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
        _subTitleLabels.numberOfLines = 0;
        [_subTitleLabels sizeToFit];
    }
    return _subTitleLabels;
}
-(UILabel *)createDateLabel{
    if (!_createDateLabel) {
        _createDateLabel = [WLTools allocLabel:@"创建时间：2020-04-21  14:32" font:systemFont(12) textColor:kGrayTxtColor frame:CGRectMake(ScaleW(15), ScaleW(99) + _septorLine.bottom, _bacView.width - ScaleW(15)*2, ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _createDateLabel;
}
-(UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(16) + _createDateLabel.bottom, _bacView.width, .5)];
        _bottomLine.backgroundColor = kMainBgColor;
       }
       return _bottomLine;
}
-(UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [WLTools allocLabel:@"30分钟后订单自动取消" font:systemFont(12) textColor:kGrayTxtColor frame:CGRectMake(ScaleW(15), _bottomLine.bottom, _bacView.width - ScaleW(15)*2, _bacView.height - _bottomLine.bottom) textAlignment:(NSTextAlignmentLeft)];
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
#pragma mark  ---Action

-(void)confirmDoneBtnAction:(UIButton *)sender
{
    !self.ensureBtnBlock?:self.ensureBtnBlock();
}
#pragma mark --getterSetter

-(void)setUiStyle:(OrderCellUiStyle)UiStyle
{
    _UiStyle = UiStyle;
     _bottomLine.hidden = _timeLabel.hidden = _confirmDoneBtn.hidden = NO;
    switch (_UiStyle) {
        case OrderCellUiStyleNoBottomStyle:
        {
            _bottomLine.hidden = _timeLabel.hidden = _confirmDoneBtn.hidden = YES;
        }
            break;
         case OrderCellUiStyleBottomTimeStyle:
        {
            _confirmDoneBtn.hidden = YES;
        }
            break;
        case OrderCellUiStyleBottomComfimBtnStyle:
        {
            _timeLabel.hidden = YES;
        }
            break;
        default:
            break;
    }
}
-(void)setModel:(LXMineRequstOrderListModel *)model{
    ////状态 0待付款 1已取消 2工程师服务中 3用户待确认 4待评价 5已完成 6异常订单
    _model = model;
    
    NSString *statusString = @"";
    OrderCellUiStyle style = OrderCellUiStyleNoBottomStyle;
    UIColor *color = kMainTxtColor;
    CGFloat height = ScaleW(173);
    switch (_model.state.integerValue) {
            ///0待付款
        case 0:
        {
            statusString = @"待支付";
            style = OrderCellUiStyleBottomTimeStyle;
        }
            break;
           ///1已取消
        case 1:
        {
            statusString = @"已取消";
            style = OrderCellUiStyleBottomComfimBtnStyle;
            self.ensureBtnBlock = self.deleteOrderBlock;
            [self.confirmDoneBtn setTitle:@"删除" forState:(UIControlStateNormal)];
            height = ScaleW(223);
        }
            break;
            ///2工程服务中
        case 2:
        {
            statusString = @"工程师服务中";
            style = OrderCellUiStyleBottomComfimBtnStyle;
            self.ensureBtnBlock = self.confirmDoneBlock;
            [self.confirmDoneBtn setTitle:@"确认完成" forState:(UIControlStateNormal)];
            height = ScaleW(223);
        }
            break;
            ///3用户待确认
        case 3:
        {
            statusString = @"用户待确认";
            style = OrderCellUiStyleNoBottomStyle;
        }
            break;
            ///4待评价
        case 4:
        {
            statusString = @"待评价";
            style = OrderCellUiStyleNoBottomStyle;
        }
            break;
            ///5已完成
        case 5:
        {
            statusString = @"已完成";
            style = OrderCellUiStyleBottomComfimBtnStyle;
            self.ensureBtnBlock = self.deleteOrderBlock;
            [self.confirmDoneBtn setTitle:@"删除" forState:(UIControlStateNormal)];
            height = ScaleW(223);
        }
            break;
            ///6异常订单
        case 6:
        {
            style = OrderCellUiStyleNoBottomStyle;
            statusString = @"异常订单";
            color = kRedColor;
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
    _kindsLabel.text = [NSString stringWithFormat:@"%@",_model.servicesname];
    _moneyLabel.text = [NSString stringWithFormat:@"酬金：￥%@",_model.servicesprice];
    _subTitleLabels.text = [NSString stringWithFormat:@"%@",_model.servicestitle];
    _createDateLabel.text = [NSString stringWithFormat:@"创建时间：%@",_model.adtime];
}
@end

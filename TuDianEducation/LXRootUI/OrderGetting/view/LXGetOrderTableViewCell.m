//
//  LXGetOrderTableViewCell.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/30.
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
#import "LXGetOrderTableViewCell.h"
@interface LXGetOrderTableViewCell()
@property (nonatomic,assign) OrderStatusType statusType;
@property (nonatomic,assign) OrderCellUiStyle UiStyle;
@property (nonatomic, strong) UIView *bacView;
@property (nonatomic, strong) UILabel *orderNumLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIView *septorLine;
@property (nonatomic,strong) UILabel *kindsLabel;
@property (nonatomic,strong) UILabel *moneyLabel;
@property (nonatomic,strong) UILabel *wantDateLabel;
@property (nonatomic,strong) UILabel *guzhangTitleLabel;
@property (nonatomic,strong) UILabel *guzhangLabel;
@property (nonatomic,strong) NSArray *picArray;
@property (nonatomic,strong) NSMutableArray *picUiArray;
@property (nonatomic,strong) UILabel *addressLabel;
@property (nonatomic,strong) UILabel *derecetLabel;
@property (nonatomic,strong) UIButton *getOrderBtn;
@property (nonatomic,strong) UIScrollView *backScrollView;
@end

@implementation LXGetOrderTableViewCell

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
    [self.bacView addSubview:self.dateLabel];
    [self.bacView addSubview:self.septorLine];
    [self.bacView addSubview:self.kindsLabel];
    [self.bacView addSubview:self.moneyLabel];
    [self.bacView addSubview:self.wantDateLabel];
    [self.bacView addSubview:self.guzhangTitleLabel];
    [self.bacView addSubview:self.guzhangLabel];
    self.picArray = @[@"",@""];
    [self.bacView addSubview:self.addressLabel];
    [self.bacView  addSubview:self.derecetLabel];
    [self.bacView addSubview:self.getOrderBtn];
    
}
-(UIView *)bacView{
    if (!_bacView) {
        _bacView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(10), ScaleW(345), ScaleW(410))];
        _bacView.backgroundColor = kWhiteColor;
        [_bacView setCornerRadius:ScaleW(3)];
    }
    return _bacView;
}
-(UILabel *)orderNumLabel{
    if (!_orderNumLabel) {
        _orderNumLabel = [WLTools allocLabel:@"订单编号：20201525452" font:systemBoldFont(ScaleW(12)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(15), ScaleW(17), _bacView.width - ScaleW(15)*2, ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _orderNumLabel;
}
-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [WLTools allocLabel:@"2020-04-21  14:32" font:systemFont(ScaleW(11)) textColor:kGrayTxtColor frame:CGRectMake(ScaleW(15), ScaleW(17), _bacView.width - ScaleW(15)*2, ScaleW(13)) textAlignment:(NSTextAlignmentRight)];
    }
    return _dateLabel;
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
        _kindsLabel = [WLTools allocLabel:@"行业分类--设备名称" font:systemFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(15),  _septorLine.bottom + ScaleW(13), _bacView.width - ScaleW(120), ScaleW(40)) textAlignment:(NSTextAlignmentLeft)];
        _kindsLabel.numberOfLines = 0;
    }
    return _kindsLabel;
}
-(UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [WLTools allocLabel:@"酬金：￥999" font:systemFont(ScaleW(13)) textColor:kRedColor frame:CGRectMake(ScaleW(15),_septorLine.bottom + ScaleW(13), _bacView.width - ScaleW(15)*2, ScaleW(13)) textAlignment:(NSTextAlignmentRight)];
    }
    return _moneyLabel;
}
-(UILabel *)wantDateLabel{
    if (!_wantDateLabel) {
        _wantDateLabel = [WLTools allocLabel:@"期望到达时间：2020-04-21  14:32" font:systemFont(14) textColor:kMainTxtColor frame:CGRectMake(ScaleW(15), ScaleW(14) + _kindsLabel.bottom, _bacView.width - ScaleW(15)*2, ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _wantDateLabel;
}
-(UILabel *)guzhangTitleLabel{
    if (!_guzhangTitleLabel) {
        _guzhangTitleLabel = [WLTools allocLabel:@"故障描述：" font:systemFont(14) textColor:kMainTxtColor frame:CGRectMake(ScaleW(15), ScaleW(27) + _wantDateLabel.bottom, _bacView.width - ScaleW(15)*2, ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _guzhangTitleLabel;
}

-(UILabel *)guzhangLabel{
    if (!_guzhangLabel) {
        _guzhangLabel = [WLTools allocLabel:@"描述内容描述内容描述内容描述内容描述内容描述内容描述内容描述内容描述内容描述内容描述内容" font:systemFont(ScaleW(14)) textColor:kGrayTxtColor frame:CGRectMake(ScaleW(15), _guzhangTitleLabel.bottom + ScaleW(12), _guzhangTitleLabel.width, ScaleW(40)) textAlignment:(NSTextAlignmentLeft)];
        _guzhangLabel.numberOfLines = 0;
    }
    return _guzhangLabel;
}

-(UILabel *)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [WLTools allocLabel:@"所属区域：金水区" font:systemFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(15), ScaleW(108) + _guzhangLabel.bottom, _bacView.width - ScaleW(15)*2, ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _addressLabel;
}
-(UILabel *)derecetLabel{
    if (!_derecetLabel) {
        _derecetLabel = [WLTools allocLabel:@"相距约4.8km" font:systemFont(ScaleW(13)) textColor:kGrayTxtColor frame:CGRectMake(ScaleW(15), _addressLabel.top, _bacView.width - ScaleW(15)*2, ScaleW(13)) textAlignment:(NSTextAlignmentRight)];
    }
    return _derecetLabel;
}

-(UIButton *)getOrderBtn{
    if (!_getOrderBtn) {
        _getOrderBtn = [WLTools allocButtonTitle:@"抢单" font:systemFont(ScaleW(14)) textColor:kWhiteColor image:nil frame:CGRectMake(ScaleW(27), ScaleW(30) + _addressLabel.bottom, ScaleW(290), ScaleW(40)) sel:@selector(getOrderBtnAction:) taget:self];
        _getOrderBtn.backgroundColor = kBlueColor;
        [_getOrderBtn setCornerRadius:_getOrderBtn.height/2.f];
    }
    return _getOrderBtn;
}
-(NSMutableArray *)picUiArray
{
    if (!_picUiArray) {
        _picUiArray = [NSMutableArray array];
    }
    return _picUiArray;
}
#pragma mark  ---Action

-(void)getOrderBtnAction:(UIButton *)sender
{
    !self.getOrderBlock?:self.getOrderBlock();
}
#pragma mark --getterSetter

-(void)setPicArray:(NSArray *)picArray
{
    _picArray = picArray;
    for (UIView *v  in self.picUiArray) {
        [v removeFromSuperview];
    }
    for (int i = 0; i < _picArray.count; i ++) {
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(12) + i * ScaleW(80), 0, ScaleW(70), ScaleW(70))];
        [img setCornerRadius:ScaleW(5)];
        img.backgroundColor = kBlueColor;
        [self.backScrollView addSubview:img];
        self.backScrollView.contentSize = CGSizeMake(img.right + ScaleW(10), 0);
        [img sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:_picArray[i]]]];
        
        [self.picUiArray addObject:img];
    }
    [_bacView addSubview:self.backScrollView];
    
}
-(UIScrollView *)backScrollView{
    if (!_backScrollView) {
        _backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _guzhangLabel.bottom + ScaleW(10), _bacView.width, ScaleW(70))];
        _backScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _backScrollView;
}
-(void)setModel:(LXGetOrderListModel *)model{
    _model = model;
    _orderNumLabel.text = [NSString stringWithFormat:@"订单编号：%@",_model.ordernum];
    _dateLabel.text = _model.adtime;
    _kindsLabel.text = [NSString stringWithFormat:@"%@--%@",_model.industrys,_model.equipmentname];
    [_kindsLabel sizeToFit];
    _moneyLabel.text = [NSString stringWithFormat:@"酬金：￥%@",_model.price];
    _wantDateLabel.text = [NSString stringWithFormat:@"期望到达时间：%@",_model.expecttime];
    _guzhangLabel.text = _model.describes;
    [_guzhangLabel sizeToFit];
    self.picArray = _model.describeimage;
    //address
    _addressLabel.text =[NSString stringWithFormat:@"所属区域：%@",_model.address];
    _derecetLabel.text =[NSString stringWithFormat:@"相距约：%@",_model.distance];
    self.bacView.height = ScaleW(357) + model.offHeight;
    [self reloadFrame];
}
-(void)reloadFrame{
    _wantDateLabel.top = ScaleW(14) + _kindsLabel.bottom;
    _guzhangTitleLabel.top = ScaleW(27) + _wantDateLabel.bottom;
    _guzhangLabel.top = _guzhangTitleLabel.bottom + ScaleW(12);
    _backScrollView.top = _guzhangLabel.bottom + ScaleW(10);
    _addressLabel.top = ScaleW(108) + _guzhangLabel.bottom;
    _derecetLabel.top = _addressLabel.top;
    _getOrderBtn.top = ScaleW(30) + _addressLabel.bottom;
}
@end

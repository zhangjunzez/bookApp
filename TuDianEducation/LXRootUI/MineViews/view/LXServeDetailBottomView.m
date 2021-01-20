//
//  LXServeDetailBottomView.m
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
#import "LXServeDetailBottomView.h"
#import "LXOrderMessageValueItemView.h"
@interface LXServeDetailBottomView()
@property (nonatomic,strong) LXOrderMessageValueItemView *orderNumView;
@property (nonatomic,strong) LXOrderMessageValueItemView *createTimeView;
@property (nonatomic,strong) LXOrderMessageValueItemView *orderStatusView;
@property (nonatomic,strong) LXOrderMessageValueItemView *amountView;
@property (nonatomic,strong) UIButton*payBtn;
@end
@implementation LXServeDetailBottomView
-(instancetype)init{
    if (self = [super init]) {
        [self viewConfig];
    }
    return self;
}
-(void)viewConfig{
    self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(100));
    self.backgroundColor = kWhiteColor;
    [self addSubview:self.orderNumView];
    [self addSubview:self.createTimeView];
    [self addSubview:self.orderStatusView];
    [self addSubview:self.amountView];
    [self addSubview:self.payBtn];
    self.height = self.payBtn.bottom + ScaleW(30);
}
- (LXOrderMessageValueItemView *)orderNumView{
    if (!_orderNumView) {
        _orderNumView = [[LXOrderMessageValueItemView alloc]initWithTop:0 titleString:@"订单号" valueString:@"20200542010152461" isRedValue:NO];
    }
    return _orderNumView;
}
-(LXOrderMessageValueItemView *)createTimeView{
    if (!_createTimeView) {
        _createTimeView = [[LXOrderMessageValueItemView alloc]initWithTop:_orderNumView.bottom titleString:@"创建时间" valueString:@"2020/05/04 20:10:15" isRedValue:NO];
    }
    return _createTimeView;
}
-(LXOrderMessageValueItemView *)orderStatusView{
    if (!_orderStatusView) {
        _orderStatusView = [[LXOrderMessageValueItemView alloc]initWithTop:_createTimeView.bottom titleString:@"订单状态" valueString:@"待审核" isRedValue:NO];
    }
    return _orderStatusView;
}

-(LXOrderMessageValueItemView *)amountView{
    if (!_amountView) {
        _amountView = [[LXOrderMessageValueItemView alloc]initWithTop:_orderStatusView.bottom titleString:@"待支付金额" valueString:@"￥300" isRedValue:YES];
    }
    return _amountView;
}
-(UIButton *)payBtn{
    if (!_payBtn) {
        _payBtn = [WLTools allocButtonTitle:@"立即支付" font:systemFont(ScaleW(14)) textColor:kBlueColor image:nil frame:CGRectMake(ScaleW(285), ScaleW(25) + _amountView.bottom, ScaleW(78), ScaleW(30)) sel:@selector(payBtnAction:) taget:self];
        [_payBtn setBorderWithWidth:1 andColor:kBlueColor];
    }
    return _payBtn;
}
-(void)payBtnAction:(UIButton *)sender
{
    !self.ensureBtnBlock?:self.ensureBtnBlock();
}
-(void)setModel:(LXServerOrderDetailModel *)model{
    _model = model;
    _orderNumView.valueLabel.text = _model.ordernum;
    _createTimeView.valueLabel.text = _model.adtime;
    _orderStatusView.valueLabel.text = _model.serverStausString;
    
     self.payBtn.hidden = YES;
    self.amountView.hidden = NO;
    switch (_model.state.integerValue) {
              ///0待付款
          case 0:
          {
              _amountView.titleLabel.text = @"待支付";
              _amountView.valueLabel.text = [NSString stringWithFormat:@"￥%@",_model.allprice];
          }
              break;
             ///1已取消
          case 1:
          {
              _amountView.titleLabel.text = @"待支付";
              _amountView.valueLabel.text = [NSString stringWithFormat:@"￥%@",_model.allprice];
              self.payBtn.hidden = NO;
              self.ensureBtnBlock = self.deleteOrderBlock;
              [self.payBtn setTitle:@"删除" forState:(UIControlStateNormal)];
          }
              break;
              ///2工程服务中
          case 2:
          {
              _amountView.titleLabel.text = @"待支付";
              _amountView.valueLabel.text = [NSString stringWithFormat:@"￥%@",_model.allprice];
              self.payBtn.hidden = NO;
              self.ensureBtnBlock = self.confirmDoneBlock;
              [self.payBtn setTitle:@"确认完成" forState:(UIControlStateNormal)];

          }
              break;
              ///3用户待确认
          case 3:
          {
              _amountView.titleLabel.text = @"已支付";
              _amountView.valueLabel.text = [NSString stringWithFormat:@"￥%@",_model.allprice];
          }
              break;
              ///4待评价
          case 4:
          {
              _amountView.titleLabel.text = @"已支付";
              _amountView.valueLabel.text = [NSString stringWithFormat:@"￥%@",_model.allprice];
          }
              break;
              ///5已完成
          case 5:
          {
              _amountView.titleLabel.text = @"已支付";
              _amountView.valueLabel.text = [NSString stringWithFormat:@"￥%@",_model.allprice];
              self.payBtn.hidden = NO;
              self.ensureBtnBlock = self.deleteOrderBlock;
              [self.payBtn setTitle:@"删除" forState:(UIControlStateNormal)];
            
          }
              break;
              ///6异常订单
          case 6:
          {
              self.amountView.hidden = YES;
          }
              break;
          default:
              break;
      }
}
@end

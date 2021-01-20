//
//  LXRequstBottomView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/29.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//
#import "LXRequstBottomView.h"
#import "LXOrderMessageValueItemView.h"
@interface LXRequstBottomView()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) LXOrderMessageValueItemView *orderNumView;
///复制按钮
@property (nonatomic,strong) UIButton *copBtn;
@property (nonatomic,strong) LXOrderMessageValueItemView *createTimeView;
@property (nonatomic,strong) LXOrderMessageValueItemView *payTimeView;

@property (nonatomic,strong) LXOrderMessageValueItemView *fahuoTimeView;

@property (nonatomic,strong) LXOrderMessageValueItemView *finishTimeView;


@property (nonatomic,strong) UIButton*contactBtn;
@end
@implementation LXRequstBottomView
-(instancetype)init{
    if (self = [super init]) {
        [self viewConfig];
    }
    return self;
}
-(void)viewConfig{
    self.frame = CGRectMake(ScaleW(11), 0, ScreenWidth - ScaleW(22), ScaleW(100));
    self.backgroundColor = kWhiteColor;
    self.cornerRadius = ScaleW(8);
    [self addSubview:self.titleLabel];
    [self addSubview:self.orderNumView];
    [self addSubview:self.createTimeView];
    [self addSubview:self.payTimeView];
    [self addSubview:self.fahuoTimeView];
    [self addSubview:self.finishTimeView];
    
 
    [self addSubview:self.contactBtn];
    self.height = self.contactBtn.bottom;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:@"订单信息" font:systemBoldFont(ScaleW(15)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(11), ScaleW(13), ScaleW(200), ScaleW(40)) textAlignment:(NSTextAlignmentLeft)];

    }
    return _titleLabel;
}
- (LXOrderMessageValueItemView *)orderNumView{
    if (!_orderNumView) {
        _orderNumView = [[LXOrderMessageValueItemView alloc]initWithTop:_titleLabel.bottom titleString:@"订单号" valueString:@"20200542010152461" isRedValue:NO];
        _orderNumView.valueLabel.right = _orderNumView.width - ScaleW(30);
        _copBtn = [WLTools allocButtonTitle:@"" font:systemFont(0) textColor:kWhiteColor image:[UIImage imageNamed:@"添加"] frame:CGRectMake(_orderNumView.valueLabel.right, 0, ScaleW(30), _orderNumView.height) sel:@selector(copyOrderAction:) taget:self];
        [_orderNumView addSubview:_copBtn];
    }
    return _orderNumView;
}
-(void)copyOrderAction:(UIButton *)sender
{
    
}
-(LXOrderMessageValueItemView *)createTimeView{
    if (!_createTimeView) {
        _createTimeView = [[LXOrderMessageValueItemView alloc]initWithTop:_orderNumView.bottom titleString:@"创建时间" valueString:@"2020/05/04 20:10:15" isRedValue:NO];
    }
    return _createTimeView;
}
-(LXOrderMessageValueItemView *)payTimeView{
    if (!_payTimeView) {
        _payTimeView = [[LXOrderMessageValueItemView alloc]initWithTop:_createTimeView.bottom titleString:@"付款时间" valueString:@"2020/05/04 20:10:15" isRedValue:NO];
       
    }
    return _payTimeView;
}

-(LXOrderMessageValueItemView *)fahuoTimeView{
    if (!_fahuoTimeView) {
        _fahuoTimeView = [[LXOrderMessageValueItemView alloc]initWithTop:_payTimeView.bottom titleString:@"确认完成时间" valueString:@"2020/05/04 20:10:15" isRedValue:NO];
        
    }
    return _fahuoTimeView;
}
-(LXOrderMessageValueItemView *)finishTimeView{
    if (!_finishTimeView) {
        _finishTimeView = [[LXOrderMessageValueItemView alloc]initWithTop:_fahuoTimeView.bottom titleString:@"完成时间" valueString:@"2020/05/04 20:10:15" isRedValue:NO];
       
    }
    return _finishTimeView;
}


-(UIButton *)contactBtn{
    if (!_contactBtn) {
        _contactBtn = [WLTools allocButtonTitle:@"联系卖家" font:systemFont(ScaleW(14)) textColor:kMainTxtColor image:[UIImage imageNamed:@"lianximaijia"] frame:CGRectMake(0, _finishTimeView.bottom, self.width, ScaleW(42)) sel:@selector(contactBtnAction:) taget:self];
        [_contactBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,ScaleW(10), 0, 0)];
    }
    return _contactBtn;
}
-(void)contactBtnAction:(UIButton *)sender
{
    !self.ensureBtnBlock?:self.ensureBtnBlock();
}

//-(void)setModel:(LXRequstOrderDetailModel *)model{
//    _model = model;
//    //工程师端订单状态只有4及以后的状态 0待审核 1审核失败 2待接单 3已取消 4待支付 5工程师服务中 6用户待确认 7待评价 8已完成 9异常订单
//       _model = model;
//    self.orderNumView.valueLabel.text = _model.ordernum;
//    self.createTimeView.valueLabel.text = _model.adtime;
//    _orderStatusView.valueLabel.text = _model.statusString;
//
//      self.contactBtn.hidden = YES;
//    _amountView.titleLabel.text = @"待支付";
//    _amountView.valueLabel.text = [NSString stringWithFormat:@"￥%@",_model.price];
////
////    "adtime":""//下单时间
////     "shtime":""//审核时间
////     "jdtime":""//接单时间
////     "qxtime":""//取消时间
////     "zftime":""//支付时间
////     "gcsqrtime":""//工程师确认时间
////     "yhqrtime":""//用户确认时间
////     "pjtime":""//评价时间
//       switch (_model.state.integerValue) {
//        case 3:
//           {
//               ///用户取消
//               _amountView.titleLabel.text = @"待支付";
//               _amountView.valueLabel.text = [NSString stringWithFormat:@"￥%@",_model.price];
//               //时间
//
//               break;
//           }
//               ///4待支付
//           case 4:
//           {
//             _amountView.titleLabel.text = @"待支付";
//             _amountView.valueLabel.text = [NSString stringWithFormat:@"￥%@",_model.price];
//
//           }
//               break;
//               ///5工程师服务中
//           case 5:
//           {
//               self.contactBtn.hidden = NO;
//                self.ensureBtnBlock = self.confirmDoneBlock;
//                [self.contactBtn setTitle:@"确认完成" forState:(UIControlStateNormal)];
//               _amountView.titleLabel.text = @"支付金额";
//               _amountView.valueLabel.text = [NSString stringWithFormat:@"￥%@",_model.allprice.length?_model.allprice:_model.price];
//                [self reloadFraneWith:@[@"支付时间"] hasBtn:YES];
//           }
//               break;
//               ///6用户待确认
//           case 6:
//           {
//
//               _amountView.titleLabel.text = @"支付金额";
//               _amountView.valueLabel.text = [NSString stringWithFormat:@"￥%@",_model.allprice.length?_model.allprice:_model.price];
//               [self reloadFraneWith:@[@"支付时间",@"完成时间"] hasBtn:NO];
//           }
//               break;
//               ///7待评价
//           case 7:
//           {
//
//                 _amountView.titleLabel.text = @"支付金额";
//                 _amountView.valueLabel.text = [NSString stringWithFormat:@"￥%@",_model.allprice.length?_model.allprice:_model.price];
//                [self reloadFraneWith:@[@"支付时间",@"完成时间",@"确认完成时间"] hasBtn:NO];
//
//           }
//               break;
//               ///8已完成
//           case 8:
//           {
//
//                self.contactBtn.hidden = NO;
//                self.ensureBtnBlock = self.deleteOrderBlock;
//                [self.contactBtn setTitle:@"删除" forState:(UIControlStateNormal)];
//
//                 _amountView.titleLabel.text = @"支付金额";
//                 _amountView.valueLabel.text = [NSString stringWithFormat:@"￥%@",_model.allprice.length?_model.allprice:_model.price];
//               [self reloadFraneWith:@[@"支付时间",@"完成时间",@"确认完成时间",@"评价时间"] hasBtn:YES];
//           }
//               break;
//               ///9异常订单
//           case 9:
//           {
//
////               self.contactBtn.hidden = NO;
////               self.ensureBtnBlock = self.contactBlock;
////               [self.contactBtn setTitle:@"联系客服" forState:(UIControlStateNormal)];
//                 _amountView.titleLabel.text = @"支付金额";
//                 _amountView.valueLabel.text = [NSString stringWithFormat:@"￥%@",_model.allprice.length?_model.allprice:_model.price];
//                [self reloadFraneWith:@[@"支付时间",@"完成时间"] hasBtn:NO];
//           }
//               break;
//           default:
//               break;
//       }
//
//}
//-(void)reloadFraneWith:(NSArray *)array hasBtn:(BOOL)hasBtn
//{
//    UIView *bottomView = nil;
//    if (array.count == 1) {
//        self.payTimeView.hidden = NO;
//        self.payTimeView.valueLabel.text = _model.zftime;
//        bottomView = self.payTimeView;
//    }
//    if (array.count == 2) {
//        self.payTimeView.hidden = NO;
//        self.payTimeView.valueLabel.text = _model.zftime;
//        self.fahuoTimeView.hidden = NO;
//        self.fahuoTimeView.valueLabel.text = _model.gcsqrtime;
//        bottomView = self.fahuoTimeView;
//    }
//    if (array.count == 3) {
//        self.payTimeView.hidden = NO;
//        self.payTimeView.valueLabel.text = _model.zftime;
//        self.fahuoTimeView.hidden = NO;
//        self.fahuoTimeView.valueLabel.text = _model.gcsqrtime;
//        self.finishTimeView.hidden = NO;
//        self.finishTimeView.valueLabel.text = _model.yhqrtime;
//        bottomView = self.finishTimeView;
//    }
//    if (array.count == 4) {
//        self.payTimeView.hidden = NO;
//        self.payTimeView.valueLabel.text = _model.zftime;
//        self.fahuoTimeView.hidden = NO;
//        self.fahuoTimeView.valueLabel.text = _model.gcsqrtime;
//        self.finishTimeView.hidden = NO;
//        self.finishTimeView.valueLabel.text = _model.yhqrtime;
//        self.pingjiaTimeView.hidden = NO;
//        self.pingjiaTimeView.valueLabel.text = _model.pjtime;
//        bottomView = self.pingjiaTimeView;
//    }
//    _orderStatusView.top = bottomView.bottom;
//    _amountView.top = _orderStatusView.bottom;
//    if (hasBtn) {
//        self.contactBtn.top = ScaleW(25) + _amountView.bottom;
//        self.height = self.contactBtn.bottom + ScaleW(30);
//    }else{
//        self.height = _amountView.bottom + ScaleW(10);
//    }
//    !self.reloadFrameBlcok?:self.reloadFrameBlcok();
//}
@end

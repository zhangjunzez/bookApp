//
//  BkMoneyBackView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/9.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "BkMoneyBackView.h"
#import "LXOrderMessageValueItemView.h"
#import "LXTitleImgeArrayItemView.h"
#import "LXSaveUserInforTool.h"
@interface BkMoneyBackView()
@property (nonatomic,strong) UIImageView *headerImgView;
@property (nonatomic,strong) UILabel *bkNameLabel;
@property (nonatomic,strong) UILabel *moneyLabel;
@property (nonatomic,strong) UIView *septorLine;
@property (nonatomic,strong) UILabel *amountNameLabel;
@property (nonatomic,strong) UIButton *addBtn;
@property (nonatomic,strong) UIButton *reduceBtn;
@property (nonatomic,strong) UILabel *amountLabel;
@property (nonatomic,strong) LXOrderMessageValueItemView *moneyView;
@property (nonatomic,strong) UILabel *descrpNameLabel;
@property (nonatomic,strong) UITextField  *descrpTextFied;

@property (nonatomic,strong) LXTitleImgeArrayItemView *uploadImgView;

@property (nonatomic,strong) UIButton *ensureBtn;


@end
@implementation BkMoneyBackView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(100));
        self.backgroundColor = kSubBacColor;
        [self addSubview:self.headerImgView];
        [self addSubview:self.bkNameLabel];
        [self addSubview:self.moneyLabel];
        [self addSubview:self.septorLine];
        
        [self addSubview:self.amountNameLabel];
        [self addSubview:self.addBtn];
        [self addSubview:self.amountLabel];
        [self addSubview:self.reduceBtn];
        [self addSubview:self.moneyView];
        
        [self addSubview:self.descrpNameLabel];
        [self addSubview:self.descrpTextFied];
        
        [self addSubview:self.uploadImgView];
        [self addSubview:self.ensureBtn];
        self.height = self.ensureBtn.bottom + ScaleW(20);
    }
    return self;
}
-(UIImageView *)headerImgView{
    if (!_headerImgView) {
        _headerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(11), ScaleW(15) , ScaleW(47), ScaleW(63))];
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
        _moneyLabel = [WLTools allocLabel:@"￥999.00" font:systemFont(ScaleW(12)) textColor:kMainTxtColor frame:CGRectMake(_headerImgView.right + ScaleW(10), _bkNameLabel.bottom + ScaleW(20), ScaleW(260), ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
        NSString *string = _moneyLabel.text;
        NSMutableAttributedString *atts = [[NSMutableAttributedString alloc] initWithString:string];
        [atts setAttributes:@{NSFontAttributeName:systemBoldFont(ScaleW(15))} range:NSMakeRange(1,  string.length - 4)];
        _moneyLabel.attributedText = atts;
    }
    return _moneyLabel;
}
-(UIView *)septorLine{
    if (!_septorLine) {
        _septorLine = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(11), ScaleW(26) + _headerImgView.bottom, self.width - ScaleW(22), .5f)];
        _septorLine.backgroundColor = kMainLineColor;
    }
    return _septorLine;
}
-(UILabel *)amountNameLabel{
    if (!_amountNameLabel) {
        _amountNameLabel = [WLTools allocLabel:@"退款数量" font:systemFont(ScaleW(14)) textColor:kSubTxtColor frame:CGRectMake(ScaleW(11), ScaleW(50) + _headerImgView.bottom, ScaleW(100), ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _amountNameLabel;
}
-(UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [WLTools allocButtonTitle:@"+" font:systemBoldFont(18) textColor:kMainTxtColor image:nil frame:CGRectMake(self.width - ScaleW(25), _amountNameLabel.top, ScaleW(18), ScaleW(18)) sel:@selector(addAction:) taget:self];
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
        _reduceBtn = [WLTools allocButtonTitle:@"-" font:systemBoldFont(18) textColor:kMainTxtColor image:nil frame:CGRectMake(0, _addBtn.top, ScaleW(18), ScaleW(18)) sel:@selector(reduceAction:) taget:self];
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
-(void)setAmountCount:(NSInteger)amountCount
{
    _amountCount = amountCount;
    
    _amountLabel.text = [NSString stringWithFormat:@"%ld",_amountCount];
//    if (_detailModel) {
//        double index  =  _detailModel.goodsprice1.floatValue *_amountCount;
//        _totalLabel.text = [NSString stringWithFormat:@"总计：￥%.2f",index];
//        _scoreLabel.text = [NSString stringWithFormat:@"%ld积分",_detailModel.goodsprice.integerValue *_amountCount];
//        !self.scoreAmountBlock?:self.scoreAmountBlock(_amountCount);
//    }
    
}
- (LXOrderMessageValueItemView *)moneyView{
    if (!_moneyView) {
        _moneyView = [[LXOrderMessageValueItemView alloc]initWithTop:ScaleW(23) + _amountNameLabel.bottom titleString:@"退款金额" valueString:@"￥80.00" isRedValue:NO];
        _moneyView.titleLabel.textColor = kGrayTxtColor;
        _moneyView.titleLabel.font = systemFont(ScaleW(12));
        _moneyView.valueLabel.textColor = kRedColor;
        _moneyView.valueLabel.font = systemFont(ScaleW(12));
        NSString *string = _moneyView.valueLabel.text;
        NSMutableAttributedString *atts = [[NSMutableAttributedString alloc] initWithString:string];
        [atts setAttributes:@{NSFontAttributeName:systemBoldFont(ScaleW(15))} range:NSMakeRange(1,  string.length - 4)];
        _moneyView.valueLabel.attributedText = atts;
        _moneyView.backgroundColor = kSubBacColor;
        _moneyView.width = self.width;
        _moneyView.valueLabel.right = self.width - ScaleW(11);
    }
    return _moneyView;
}
-(UILabel *)descrpNameLabel{
    if (!_descrpNameLabel) {
        _descrpNameLabel = [WLTools allocLabel:@"退款说明" font:systemFont(ScaleW(14)) textColor:kSubTxtColor frame:CGRectMake(ScaleW(11), _moneyView.bottom + ScaleW(20), ScaleW(100), ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _descrpNameLabel;
}
-(UITextField *)descrpTextFied{
    if (!_descrpTextFied) {
        _descrpTextFied = [WLTools allocTextFieldText:systemFont(ScaleW(12)) placeHolderFont:systemFont(ScaleW(12)) text:nil placeText:@"选填" textColor:kMainTxtColor placeHolderTextColor:kGrayTxtColor frame:CGRectMake(0, _descrpNameLabel.top, ScaleW(200), _descrpNameLabel.height)];
        _descrpTextFied.right = self.width - ScaleW(11);
        _descrpTextFied.textAlignment = NSTextAlignmentRight;
    }
    return _descrpTextFied;
}
-(LXTitleImgeArrayItemView *)uploadImgView{
    if (!_uploadImgView) {
        [LXSaveUserInforTool sharedUserTool].medaiType = 1;
        _uploadImgView = [[LXTitleImgeArrayItemView alloc]initWithTop:_descrpNameLabel.bottom +ScaleW(100) title:@"上传凭证" imgeArray:@[@""] redHidden:YES];
       
        _uploadImgView.limitCount = 1;
        _uploadImgView.backgroundColor = kSubBacColor;
        
    }
    return _uploadImgView;
}
-(UIButton *)ensureBtn
{
    if (!_ensureBtn) {
        _ensureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _ensureBtn.frame = CGRectMake(ScaleW(11), _uploadImgView.bottom + ScaleW(70), self.width - ScaleW(22),ScaleW(40));
        [_ensureBtn btn:_ensureBtn font:ScaleW(14) textColor:kWhiteColor text:@"提交" image:nil sel:@selector(ensureBtnAction:) taget:self];
        _ensureBtn.backgroundColor = kGreenColor;
        _ensureBtn.cornerRadius = _ensureBtn.height/2.f;
    }
    return _ensureBtn;
}
-(void)ensureBtnAction:(UIButton *)sender
{
    !self.callBackBlock?:self.callBackBlock();
}
@end

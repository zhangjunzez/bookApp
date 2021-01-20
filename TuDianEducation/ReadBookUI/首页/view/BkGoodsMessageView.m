//
//  BkGoodsMessageView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/13.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "BkGoodsMessageView.h"


@interface BkGoodsMessageView()
@property (nonatomic, strong) UIView *bacView;

@property (nonatomic,strong) UIImageView *headerImgView;
@property (nonatomic,strong) UILabel *bkNameLabel;
@property (nonatomic,strong) UILabel *moneyLabel;
@property (nonatomic,strong) UIView *septorLine;
@property (nonatomic,strong) UILabel *amountNameLabel;
@property (nonatomic,strong) UIButton *addBtn;
@property (nonatomic,strong) UIButton *reduceBtn;
@property (nonatomic,strong) UILabel *amountLabel;
@property (nonatomic,assign) NSInteger amountCount;

@property (nonatomic,strong) UILabel *sevenLabel;
@property (nonatomic,strong) UILabel *totalAmountLabel;


@property (nonatomic,strong) UIView *yunView;
@property (nonatomic,strong) UILabel *yunfeeLabel;

@end

@implementation BkGoodsMessageView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self viewConfig];
    }
    return self;
}

-(void)viewConfig
{
    self.frame =CGRectMake(0, 0, ScreenWidth, ScaleW(200));
    self.backgroundColor = kSubBacColor;
    [self addSubview:self.bacView];
    [self.bacView addSubview:self.headerImgView];
    [self.bacView addSubview:self.bkNameLabel];
    [self.bacView addSubview:self.sevenLabel];
    [self.bacView addSubview:self.moneyLabel];
    [self.bacView addSubview:self.addBtn];
    [self.bacView addSubview:self.amountLabel];
    [self.bacView addSubview:self.reduceBtn];
    [self.bacView addSubview:self.totalAmountLabel];
    
    [self addSubview:self.yunView];
    [self.yunView addSubview:self.yunfeeLabel];
    self.height = self.yunView.bottom + ScaleW(8);
    
}

-(UIView *)bacView{
    if (!_bacView) {
        _bacView = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(8), ScreenWidth , ScaleW(103))];
        _bacView.backgroundColor = kWhiteColor;
    }
    return _bacView;
}
-(UIImageView *)headerImgView{
    if (!_headerImgView) {
        _headerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(11), ScaleW(15) , ScaleW(56), ScaleW(75))];
        _headerImgView.backgroundColor = kGrayTxtColor;

    }
    return _headerImgView;
}
-(UILabel *)bkNameLabel{
    if (!_bkNameLabel) {
        _bkNameLabel = [WLTools allocLabel:@"初中数学运算大法" font:systemFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(_headerImgView.right + ScaleW(10),   ScaleW(5) + _headerImgView.top, ScaleW(210), ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
        //_bkNameLabel.numberOfLines = 0;
    }
    return _bkNameLabel;
}
-(UILabel *)sevenLabel{
    if (!_sevenLabel) {
        _sevenLabel = [WLTools allocLabel:@"7天无理由退换" font:systemFont(ScaleW(12)) textColor:kSubTxtColor frame:CGRectMake(_bkNameLabel.left, ScaleW(9) + _bkNameLabel.bottom, ScaleW(260), ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _sevenLabel;
}
-(UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [WLTools allocLabel:@"￥999.00" font:systemFont(ScaleW(12)) textColor:kRedColor frame:CGRectMake(_headerImgView.right + ScaleW(10), _sevenLabel.bottom + ScaleW(20), ScaleW(260), ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
        NSString *string = _moneyLabel.text;
        NSMutableAttributedString *atts = [[NSMutableAttributedString alloc] initWithString:string];
        [atts setAttributes:@{NSFontAttributeName:systemBoldFont(ScaleW(15))} range:NSMakeRange(1,  string.length - 4)];
        _moneyLabel.attributedText = atts;
    }
    return _moneyLabel;
}


-(UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [WLTools allocButtonTitle:@"+" font:systemBoldFont(18) textColor:kMainTxtColor image:nil frame:CGRectMake(ScreenWidth - ScaleW(25), _sevenLabel.top, ScaleW(18), ScaleW(18)) sel:@selector(addAction:) taget:self];
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
-(UILabel *)totalAmountLabel{
    if (!_totalAmountLabel) {
        _totalAmountLabel = [WLTools allocLabel:@"x1" font:systemFont(ScaleW(12)) textColor:kSubTxtColor frame:CGRectMake(0, _moneyLabel.top, ScaleW(200), ScaleW(12)) textAlignment:(NSTextAlignmentRight)];
        _totalAmountLabel.right = self.bacView.width - ScaleW(12);
    }
    return _totalAmountLabel;
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

-(UIView *)yunView{
    if (!_yunView) {
        _yunView = [[UIView alloc]initWithFrame:CGRectMake(0, _bacView.bottom + ScaleW(8), self.bacView.width, ScaleW(45))];
        _yunView.backgroundColor = kWhiteColor;
        UILabel *nameLabel = [WLTools allocLabel:@"运费" font:systemFont(ScaleW(13)) textColor:kSubTxtColor frame:CGRectMake(ScaleW(12), 0, ScaleW(200), _yunView.height) textAlignment:(NSTextAlignmentLeft)];
        [_yunView addSubview:nameLabel];
        
    }
    return _yunView;
}

-(UILabel *)yunfeeLabel{
    if (!_yunfeeLabel) {
        _yunfeeLabel = [WLTools allocLabel:@"免运费" font:systemFont(ScaleW(13)) textColor:kGreenColor frame:CGRectMake(ScaleW(20), 0, _yunView.width - ScaleW(32), _yunView.height) textAlignment:(NSTextAlignmentRight)];
    }
    return _yunfeeLabel;
}
@end

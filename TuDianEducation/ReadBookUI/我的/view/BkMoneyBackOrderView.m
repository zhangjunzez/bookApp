//
//  BkMoneyBackOrderView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/9.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "BkMoneyBackOrderView.h"
#import "LXOrderMessageValueItemView.h"
#import "LXTitleImgView.h"
#import "LXSaveUserInforTool.h"
#import "LXUserInforModel.h"

@interface BkMoneyBackOrderView()
@property (nonatomic,strong) UIView *headerMessageView;
@property (nonatomic,strong) UILabel *headerMessageLabel;
@property (nonatomic,strong) UIView *goodsMessageView;
@property (nonatomic,strong) UILabel *titleMessageLabel;
@property (nonatomic,strong) UIImageView *headerImgView;
@property (nonatomic,strong) UILabel *bkNameLabel;
@property (nonatomic,strong) UILabel *moneyLabel;
@property (nonatomic,strong) UILabel *sevendaysLabel;
@property (nonatomic,strong) UILabel *amountLabel;
@property (nonatomic,strong) LXOrderMessageValueItemView *tuiAmountView;
@property (nonatomic,strong) LXOrderMessageValueItemView *tuiResionView;
@property (nonatomic,strong) LXOrderMessageValueItemView *tuiMoneyView;
@property (nonatomic,strong) LXOrderMessageValueItemView *tuiDescrpView;
@property (nonatomic,strong) UILabel *tuiTitleLabel;

@property (nonatomic,strong) UIView *messageView;
@property (nonatomic,strong) UIImageView *addressImg;
@property (nonatomic,strong) UILabel *detailAddressLabel;
@property (nonatomic,strong) UIImageView *gotoImg;
@property (nonatomic,strong) UILabel *userNameLabel;


@property (nonatomic,strong) NSMutableArray *imgUiarray;
@property (nonatomic,strong) NSArray*imgArray;
@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) LXOrderMessageValueItemView *tuiDateView;

@property (nonatomic,strong) UIButton *commitBtn;


@end

@implementation BkMoneyBackOrderView

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
    [self addSubview:self.goodsMessageView];
    [self.goodsMessageView addSubview:self.titleMessageLabel];
    [self.goodsMessageView addSubview:self.headerImgView];
    [self.goodsMessageView addSubview:self.bkNameLabel];
    [self.goodsMessageView addSubview:self.moneyLabel];
    self.goodsMessageView.height = _headerImgView.bottom + ScaleW(25);
    [self addSubview:self.messageView];
    


    [self.messageView addSubview:self.tuiAmountView];
    [self.messageView addSubview:self.tuiResionView];
    [self.messageView addSubview:self.tuiMoneyView];
    [self.messageView addSubview:self.tuiDescrpView];
    [self.messageView addSubview:self.tuiTitleLabel];
   
    self.imgArray = @[@"",@"",@"",@"",@"",@""];
    [self.messageView addSubview:self.tuiDateView];
    self.messageView.height = self.tuiDateView.bottom + ScaleW(5);
    //self.height = self.messageView.bottom + ScaleW(6);
    [self addSubview:self.commitBtn];
    self.height = self.commitBtn.bottom + ScaleW(20);
    self.scrollView.top = ScaleW(16) + _tuiTitleLabel.bottom;
   
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


-(UIView *)goodsMessageView{
    if (!_goodsMessageView) {
        _goodsMessageView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(13), ScaleW(10) + _headerMessageLabel.bottom, ScreenWidth - ScaleW(26), ScaleW(82))];
        _goodsMessageView.backgroundColor = kWhiteColor;
        _goodsMessageView.cornerRadius = ScaleW(10);
    }
    return _goodsMessageView;
}
-(UILabel *)titleMessageLabel{
    if (!_titleMessageLabel) {
        _titleMessageLabel = [WLTools allocLabel:@"退款信息" font:systemFont(ScaleW(13)) textColor:kGreenColor frame:CGRectMake(0, 0, ScaleW(92), ScaleW(28)) textAlignment:(NSTextAlignmentCenter)];
        _titleMessageLabel.backgroundColor = UIColorFromRGB(0xF2FFF8);
        
    }
    return _titleMessageLabel;
}
-(UIImageView *)headerImgView{
    if (!_headerImgView) {
        _headerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(11), ScaleW(17) + _titleMessageLabel.bottom, ScaleW(47), ScaleW(63))];
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
        _moneyLabel = [WLTools allocLabel:@"￥999.00" font:systemFont(ScaleW(12)) textColor:kMainTxtColor frame:CGRectMake(_headerImgView.right + ScaleW(10), _bkNameLabel.bottom + ScaleW(16), ScaleW(260), ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
        NSString *string = _moneyLabel.text;
        NSMutableAttributedString *atts = [[NSMutableAttributedString alloc] initWithString:string];
        [atts setAttributes:@{NSFontAttributeName:systemBoldFont(ScaleW(15))} range:NSMakeRange(1,  string.length - 4)];
        _moneyLabel.attributedText = atts;
    }
    return _moneyLabel;
}

-(UIView *)messageView{
    if (!_messageView) {
        _messageView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(12), ScaleW(4) + _goodsMessageView.bottom, ScaleW(350), ScaleW(84))];
        _messageView.backgroundColor = kWhiteColor;
        [_messageView setCornerRadius:ScaleW(10)];
        
    }
    return _messageView;
}

- (LXOrderMessageValueItemView *)tuiAmountView{
    if (!_tuiAmountView) {
        _tuiAmountView = [[LXOrderMessageValueItemView alloc]initWithTop:ScaleW(10)  titleString:@"退款数量" valueString:@"x1" isRedValue:NO];
        _tuiAmountView.titleLabel.textColor = kGrayTxtColor;
        _tuiAmountView.titleLabel.font = systemFont(ScaleW(12));
        _tuiAmountView.valueLabel.textColor = kGrayTxtColor;
        _tuiAmountView.valueLabel.font = systemFont(ScaleW(12));
        
    }
    return _tuiAmountView;
}
- (LXOrderMessageValueItemView *)tuiResionView{
    if (!_tuiResionView) {
        _tuiResionView = [[LXOrderMessageValueItemView alloc]initWithTop: _tuiAmountView.bottom titleString:@"退款原因" valueString:@"缺货" isRedValue:NO];
        _tuiResionView.titleLabel.textColor = kGrayTxtColor;
        _tuiResionView.titleLabel.font = systemFont(ScaleW(12));
        _tuiResionView.valueLabel.textColor = kGrayTxtColor;
        _tuiResionView.valueLabel.font = systemFont(ScaleW(12));
       
    }
    return _tuiResionView;
}
- (LXOrderMessageValueItemView *)tuiMoneyView{
    if (!_tuiMoneyView) {
        _tuiMoneyView = [[LXOrderMessageValueItemView alloc]initWithTop:_tuiResionView.bottom titleString:@"退款金额" valueString:@"￥80.00" isRedValue:NO];
        _tuiMoneyView.titleLabel.textColor = kGrayTxtColor;
        _tuiMoneyView.titleLabel.font = systemFont(ScaleW(12));
        _tuiMoneyView.valueLabel.textColor = kRedColor;
        _tuiMoneyView.valueLabel.font = systemFont(ScaleW(12));
        NSString *string = _tuiMoneyView.valueLabel.text;
        NSMutableAttributedString *atts = [[NSMutableAttributedString alloc] initWithString:string];
        [atts setAttributes:@{NSFontAttributeName:systemBoldFont(ScaleW(15))} range:NSMakeRange(1,  string.length - 4)];
        _tuiMoneyView.valueLabel.attributedText = atts;
    }
    return _tuiMoneyView;
}
- (LXOrderMessageValueItemView *)tuiDescrpView{
    if (!_tuiDescrpView) {
        _tuiDescrpView = [[LXOrderMessageValueItemView alloc]initWithTop:ScaleW(10) + _tuiMoneyView.bottom titleString:@"退款说明" valueString:@"一直不发货" isRedValue:NO];
        _tuiDescrpView.titleLabel.textColor = kGrayTxtColor;
        _tuiDescrpView.titleLabel.font = systemFont(ScaleW(12));
        _tuiDescrpView.valueLabel.font = systemFont(ScaleW(12));
        _tuiDescrpView.valueLabel.textColor = kGrayTxtColor;
       
    }
    return _tuiDescrpView;
}
-(UILabel *)tuiTitleLabel{
    if (!_tuiTitleLabel) {
        _tuiTitleLabel = [WLTools allocLabel:@"退款凭证" font:systemFont(ScaleW(12)) textColor:kGrayTxtColor frame:CGRectMake(ScaleW(11), _tuiDescrpView.bottom + ScaleW(10), ScaleW(150), ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _tuiTitleLabel;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(ScaleW(11), ScaleW(16) + _tuiTitleLabel.bottom,self.messageView.width - ScaleW(22), ScaleW(84))];
        _scrollView.cornerRadius = ScaleW(5);
    }
    return _scrollView;
}
-(NSMutableArray *)imgUiarray{
    if (!_imgUiarray) {
        _imgUiarray = [NSMutableArray array];
    }
    return _imgUiarray;
}
-(void)setImgArray:(NSArray *)imgArray{
    _imgArray = imgArray;
    for (UIView *v in self.imgUiarray) {
        [v removeFromSuperview];
    }
    [self.imgUiarray removeAllObjects];
    for (int i = 0; i < _imgArray.count; i ++) {
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(10) + i * ScaleW(110), 0, ScaleW(106), ScaleW(84))];
        img.backgroundColor = kGrayBtnBacColor;
        [img sd_setImageWithURL:[NSURL URLWithString:imgArray[i]]];
        [self.scrollView addSubview:img];
        self.scrollView.contentSize = CGSizeMake(img.right + ScaleW(16), 0);
        [self.imgUiarray addObject:img];
    }
    [self.messageView addSubview:self.scrollView];
}

- (LXOrderMessageValueItemView *)tuiDateView{
    if (!_tuiDateView) {
        _tuiDateView = [[LXOrderMessageValueItemView alloc]initWithTop:ScaleW(10) + _scrollView.bottom titleString:@"申请时间" valueString:@"2020-10-21  14:30" isRedValue:NO];
        _tuiDateView.titleLabel.textColor = kGrayTxtColor;
        _tuiDateView.titleLabel.font = systemFont(ScaleW(12));
        _tuiDateView.valueLabel.font = systemFont(ScaleW(12));
        _tuiDateView.valueLabel.textColor = kMainTxtColor;
       
    }
    return _tuiDateView;
}

-(UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [WLTools allocButtonTitle:@"联系商家" font:systemFont(ScaleW(15)) textColor:kMainTxtColor image:nil frame:CGRectMake(ScaleW(11), ScaleW(18) + _messageView.bottom, ScaleW(353), ScaleW(40)) sel:@selector(commentAction:) taget:self];
        _commitBtn.backgroundColor = UIColorFromRGB(0xFFC041);
        _commitBtn.cornerRadius = _commitBtn.height/2.f;
        [_commitBtn setImageEdgeInsets:UIEdgeInsetsMake(0, ScaleW(10), 0, 0)];
    }
    return _commitBtn;
}
-(void)commentAction:(UIButton *)sender{
    
}
@end

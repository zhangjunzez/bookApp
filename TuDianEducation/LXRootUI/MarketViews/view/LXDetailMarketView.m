//
//  LXDetailMarketView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/2.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXDetailMarketView.h"
#import "SDCycleScrollView.h"
#import "UIImage+Extension.h"

@interface LXDetailMarketView()<SDCycleScrollViewDelegate>
@property (nonatomic,strong) SDCycleScrollView *bannerView;
@property (nonatomic,strong) UILabel *currentPageLabel;

@property (nonatomic,strong) UIView *headerBackView;
@property (nonatomic,strong) UIView *boomView;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *alreadyLabel;
@property (nonatomic,strong) UILabel *goodsLabel;
@property (nonatomic,strong) UILabel *kucunLabel;
@property (nonatomic,strong) UILabel *tushujifen;




@end
@implementation LXDetailMarketView

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
    self.backgroundColor = kMainBgColor;
    [self addSubview:self.bannerView];
    [self addSubview:self.currentPageLabel];
     [self addSubview:self.headerBackView];
    [self addSubview:self.boomView];
    [self addSubview:self.goodsLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.alreadyLabel];
    [self addSubview:self.kucunLabel];
    [self addSubview:self.tushujifen];
   

    self.height = self.boomView.bottom + ScaleW(10);
   
}
#pragma mark - 播视图
-(SDCycleScrollView *)bannerView
{
    if (_bannerView==nil)
    {
        _bannerView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0, ScreenWidth, ScreenWidth + ScaleW(10)) delegate:self placeholderImage:BUNDLE_PNGIMG(@"homePage", @"bannerDefult")];
        _bannerView.backgroundColor = [UIColor clearColor];
        _bannerView.showPageControl = YES;
        _bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _bannerView.pageControlBottomOffset = ScaleW(20);
        _bannerView.currentPageDotColor = kGreenColor;
        _bannerView.pageDotColor = UIColorFromRGB(0xA4F4C7);
    
        _bannerView.localizationImageNamesGroup = @[@"defultLocalImg",@"defultLocalimg2"];
        _bannerView.autoScrollTimeInterval = 5.0;
        
    }
    
    return _bannerView;
}

    
-(UILabel *)currentPageLabel{
    if (!_currentPageLabel) {
        NSString *message = [NSString stringWithFormat:@"%d/%ld",1,_bannerView.localizationImageNamesGroup.count];
        _currentPageLabel = [WLTools allocLabel:message font:systemFont(ScaleW(15)) textColor:kWhiteColor frame:CGRectMake(ScaleW(304), (3/4.f)*_bannerView.height, ScaleW(56), ScaleW(26)) textAlignment:(NSTextAlignmentCenter)];
        _currentPageLabel.backgroundColor = kBacColor;
        _currentPageLabel.cornerRadius = _currentPageLabel.height/2.f;
        //_currentPageLabel.hidden = YES;
    }
    return _currentPageLabel;
}
#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    //!self.urlClickBlock?:self.urlClickBlock(index);
}
/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
     NSString *message = [NSString stringWithFormat:@"%ld/%ld",index + 1,_bannerView.imageURLStringsGroup.count];
    self.currentPageLabel.text = message;
};

-(UIView *)headerBackView{
    if (!_headerBackView) {
        _headerBackView = [[UIView alloc]initWithFrame:CGRectMake(0, _bannerView.bottom - ScaleW(20), ScreenWidth, ScaleW(65))];
        _headerBackView.backgroundColor = kWhiteColor;
        _headerBackView.cornerRadius = ScaleW(20);
        _headerBackView.frame = CGRectMake(0, _bannerView.bottom - ScaleW(20), ScreenWidth, ScaleW(65));
    }
    return _headerBackView;
}
-(UIView *)boomView{
    if (!_boomView) {
        _boomView = [[UIView alloc]initWithFrame:CGRectMake(0, _bannerView.bottom , ScreenWidth, ScaleW(140))];
        _boomView.backgroundColor = kWhiteColor;
    }
    return _boomView;
}
-(UILabel *)goodsLabel{
    if (!_goodsLabel) {
        _goodsLabel = [WLTools allocLabel:@"比纳仰卧板仰卧起坐健身器材家用多功能哑铃凳健身器收腹器腹肌板" font:systemBoldFont(ScaleW(17)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(15), _headerBackView.top + ScaleW(25) , self.width - ScaleW(30), ScaleW(17)) textAlignment:(NSTextAlignmentLeft)];
        
       //_goodsLabel.numberOfLines = 2;
    }
    return _goodsLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [WLTools allocLabel:@"1000积分  原价:￥2388.20" font:systemBoldFont(ScaleW(20)) textColor:kRedColor frame:CGRectMake(ScaleW(15), _goodsLabel.bottom + ScaleW(20), self.width - ScaleW(15) *2, ScaleW(25)) textAlignment:(NSTextAlignmentLeft)];
        NSString *string = _priceLabel.text;
        NSMutableAttributedString *atts = [[NSMutableAttributedString alloc] initWithString:string];
        NSRange range = [_priceLabel.text rangeOfString:@"积分"];
        [atts setAttributes:@{ NSForegroundColorAttributeName:kRedColor,NSFontAttributeName:systemFont(ScaleW(15))} range:range];
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle],NSForegroundColorAttributeName:kGrayTxtColor,NSFontAttributeName:systemFont(ScaleW(13))};
        
        range = [_priceLabel.text rangeOfString:@"原价"];
        [atts setAttributes:attribtDic range:(NSMakeRange(range.location, _priceLabel.text.length - range.location))];
        _priceLabel.attributedText = atts;
    }
    return _priceLabel;
}

-(UILabel *)alreadyLabel{
    if (!_alreadyLabel) {
        _alreadyLabel = [WLTools allocLabel:@"已兑换:5000" font:systemFont(ScaleW(13)) textColor:kMainTxtColor frame:CGRectMake(_priceLabel.left,ScaleW(22) + _priceLabel.bottom,  ScreenWidth - ScaleW(30), ScaleW(13)) textAlignment:(NSTextAlignmentLeft)];
        
    }
    return _alreadyLabel;
}

-(UILabel *)kucunLabel
{
    if (!_kucunLabel) {
        _kucunLabel = [WLTools allocLabel:@"库存量：8000" font:systemFont(ScaleW(13)) textColor:kMainTxtColor frame:CGRectMake(_alreadyLabel.left, _alreadyLabel.top + ScaleW(18), _alreadyLabel.width, ScaleW(13)) textAlignment:(NSTextAlignmentRight)];
    }
    return _kucunLabel;
}
-(UILabel *)tushujifen{
    if (!_tushujifen) {
        _tushujifen = [WLTools allocLabel:@"图书APP积分" font:systemFont(ScaleW(12)) textColor:kRedColor frame:CGRectMake(ScaleW(254), _goodsLabel.bottom, ScaleW(110), ScaleW(28)) textAlignment:(NSTextAlignmentCenter)];
        _tushujifen.cornerRadius = _tushujifen.height/2.f;
        _tushujifen.backgroundColor = UIColorFromRGB(0xFFF2F2);
    }
    return _tushujifen;
}

-(void)setModel:(LXMarketGoodsDetailModel *)model{
    _model = model;
    _bannerView.imageURLStringsGroup = _model.goodsimages;
        NSString *message = [NSString stringWithFormat:@"%d/%ld",1,_bannerView.imageURLStringsGroup.count];
    self.currentPageLabel.text = message;
   // _priceLabel.text = [self returnStringForShow:_model.goodsprice1 price2:_model.goodsprice];
    self.alreadyLabel.text = [NSString stringWithFormat:@"已兑换%@件",_model.goodssale];
    self.goodsLabel.text = _model.goodsname;
    //self.kucunLabel.hidden = YES;
}
-(NSString *)returnStringForShow:(NSString *)price1 price2:(NSString *)price2{
    if (price1.doubleValue == 0) {
        return  [NSString stringWithFormat:@"%@积分",price2];
    }
    if (price2.doubleValue == 0) {
        return  [NSString stringWithFormat:@"￥%@",price1];
    }
    if (price2.doubleValue != 0 &&price1.doubleValue != 0) {
        return  [NSString stringWithFormat:@"￥%@+%@积分",price1,price2];
    }
    return @"免费";
}



@end

//
//  BkGoodsDetailHeaderView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/13.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "BkGoodsDetailHeaderView.h"
#import <WebKit/WebKit.h>
#import "SDCycleScrollView.h"
#import "UIImage+Extension.h"

@interface BkGoodsDetailHeaderView()<WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate,SDCycleScrollViewDelegate>
@property (nonatomic,strong) UIView *messagesView;
@property (nonatomic,strong) SDCycleScrollView *bannerView;
@property (nonatomic,strong) UILabel *currentPageLabel;

@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *alreadyLabel;
@property (nonatomic,strong) UILabel *goodsLabel;
@property (nonatomic,strong) UILabel *kucunLabel;
@property (nonatomic,strong) UIButton *goodsConmmedsBtn;
@property (nonatomic,strong) UILabel *conmmendsLabel;
@property (nonatomic,strong) UIView *detailView;
@property (nonatomic,strong) UILabel *goodsNameLabel;
@property (nonatomic,strong)  WKWebView*webView;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIImageView *authorImgView;
@property (nonatomic,strong) UIView *authorView;
@property (nonatomic,strong) UIImageView *authorHeaderImg;
@property (nonatomic,strong) UILabel *authorNameLabel;
@property (nonatomic,strong) UILabel *authorAgeLabel;
@property (nonatomic,strong) UILabel *authorSchoolLabel;

@property (nonatomic,strong) UIImageView *youlikedImgView;

@end
@implementation BkGoodsDetailHeaderView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(-ScaleW(10), 0, ScreenWidth, ScaleW(200));
        [self addSubview:self.messagesView];
        [self addSubview:self.goodsConmmedsBtn];
        [self addSubview:self.detailView];
        [self addSubview:self.bottomView];
        self.height = self.bottomView.bottom;
        self.backgroundColor = kSubBacColor;
        [self kvoScrollViewContentSize];
    }
    return self;
}

#pragma mark ---messageView
-(UIView *)messagesView{
    if (!_messagesView) {
        _messagesView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(200))];
        _messagesView.backgroundColor = kWhiteColor;
        [_messagesView addSubview:self.bannerView];
        [_messagesView addSubview:self.goodsLabel];
        [_messagesView addSubview:self.priceLabel];
        [_messagesView addSubview:self.alreadyLabel];
        [_messagesView addSubview:self.kucunLabel];
        _messagesView.height = _kucunLabel.bottom + ScaleW(22);
    }
    return _messagesView;
}
#pragma mark - 播视图
-(SDCycleScrollView *)bannerView
{
    if (_bannerView==nil)
    {
        _bannerView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0, ScreenWidth, ScaleW(300)) delegate:self placeholderImage:BUNDLE_PNGIMG(@"homePage", @"bannerDefult")];
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

-(UILabel *)goodsLabel{
    if (!_goodsLabel) {
        _goodsLabel = [WLTools allocLabel:@"比纳仰卧板仰卧起坐健身器材家用多功能哑铃凳健身器收腹器腹肌板" font:systemBoldFont(ScaleW(17)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(15), _bannerView.bottom + ScaleW(25) , self.width - ScaleW(30), ScaleW(17)) textAlignment:(NSTextAlignmentLeft)];
        
       //_goodsLabel.numberOfLines = 2;
    }
    return _goodsLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [WLTools allocLabel:@"￥900.00  原价:￥2388.20" font:systemFont(ScaleW(15)) textColor:kRedColor frame:CGRectMake(ScaleW(15), _goodsLabel.bottom + ScaleW(20), self.width - ScaleW(15) *2, ScaleW(25)) textAlignment:(NSTextAlignmentLeft)];
        NSString *string = _priceLabel.text;
        NSMutableAttributedString *atts = [[NSMutableAttributedString alloc] initWithString:string];
        NSRange range = [_priceLabel.text rangeOfString:@"原价"];
        range = NSMakeRange(1, range.location - 5);
        [atts setAttributes:@{ NSForegroundColorAttributeName:kRedColor,NSFontAttributeName:systemBoldFont(ScaleW(20))} range:range];
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle],NSForegroundColorAttributeName:kGrayTxtColor,NSFontAttributeName:systemFont(ScaleW(13))};
        
        range = [_priceLabel.text rangeOfString:@"原价"];
        [atts setAttributes:attribtDic range:(NSMakeRange(range.location, _priceLabel.text.length - range.location))];
        _priceLabel.attributedText = atts;
    }
    return _priceLabel;
}

-(UILabel *)alreadyLabel{
    if (!_alreadyLabel) {
        _alreadyLabel = [WLTools allocLabel:@"已售:5000" font:systemFont(ScaleW(13)) textColor:kMainTxtColor frame:CGRectMake(_priceLabel.left,ScaleW(20) + _priceLabel.bottom,  ScreenWidth - ScaleW(30), ScaleW(13)) textAlignment:(NSTextAlignmentLeft)];
        
    }
    return _alreadyLabel;
}

-(UILabel *)kucunLabel
{
    if (!_kucunLabel) {
        _kucunLabel = [WLTools allocLabel:@"库存量：8000" font:systemFont(ScaleW(13)) textColor:kMainTxtColor frame:CGRectMake(_alreadyLabel.left, _alreadyLabel.top , _alreadyLabel.width, ScaleW(13)) textAlignment:(NSTextAlignmentRight)];
    }
    return _kucunLabel;
}
#pragma mark ----commendView
-(UIButton *)goodsConmmedsBtn{
    if (!_goodsConmmedsBtn) {
        _goodsConmmedsBtn = [WLTools allocButtonTitle:@"" font:systemFont(0) textColor:kWhiteColor image:nil frame:CGRectMake(0, ScaleW(12) + _messagesView.bottom, ScreenWidth, ScaleW(40)) sel:@selector(moreConmendAction:) taget:self];
        UILabel *nameLabel = [WLTools allocLabel:@"商品评价" font:systemFont(ScaleW(12)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(11), ScaleW(14), ScaleW(100), ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
        [_goodsConmmedsBtn addSubview:nameLabel];
        
        _conmmendsLabel = [WLTools allocLabel:@"99条" font:systemFont(ScaleW(12)) textColor:kGrayTxtColor frame:CGRectMake(0, nameLabel.top, ScaleW(200), ScaleW(12)) textAlignment:(NSTextAlignmentRight)];
        _conmmendsLabel.right = _goodsConmmedsBtn.width - ScaleW(30);
        UIImageView *gotoImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"chakanquanbu"]];
        gotoImgView.centerY = _goodsConmmedsBtn.height/2.f;
        gotoImgView.right = _goodsConmmedsBtn.width - ScaleW(10);
        [_goodsConmmedsBtn addSubview:_conmmendsLabel];
        [_goodsConmmedsBtn addSubview:gotoImgView];
        _goodsConmmedsBtn.backgroundColor = kWhiteColor;
    }
    return _goodsConmmedsBtn;
}

-(void)moreConmendAction:(UIButton *)sender
{
    !self.moreConmendBlock?:self.moreConmendBlock();
}
#pragma mark ---detailView
-(UIView *)detailView{
    if (!_detailView) {
        _detailView = [[UIView alloc]initWithFrame:CGRectMake(0, _goodsConmmedsBtn.bottom + ScaleW(11), ScreenWidth, ScaleW(300))];
        _detailView.backgroundColor = kWhiteColor;
        [_detailView addSubview:self.goodsNameLabel];
        [_detailView addSubview:self.webView];
        _detailView.height = self.webView.bottom;
    }
    return _detailView;
}
-(UILabel *)goodsNameLabel{
    if (!_goodsNameLabel) {
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(11), ScaleW(22), ScaleW(3), ScaleW(12))];
        lineView.backgroundColor = kMainTxtColor;
        [_detailView addSubview:lineView];
        _goodsNameLabel = [WLTools allocLabel:@"商品详情" font:systemBoldFont(ScaleW(15)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(5) + lineView.right, ScaleW(22), ScreenWidth - ScaleW(20) * 2, ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _goodsNameLabel;
}


-(WKWebView *)webView
{
    if (nil == _webView) {
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(ScaleW(10), _goodsNameLabel.bottom + ScaleW(15),ScreenWidth - ScaleW(20) , ScreenHeight-ScaleW(10))];
        _webView.UIDelegate = self;
        _webView.scrollView.scrollEnabled = YES;
        
        _webView.navigationDelegate = self;
        [_webView setOpaque:FALSE];
        _webView.backgroundColor=kWhiteColor;
        _webView.scrollView.delegate = self;
        
    }
    return _webView;
}
#pragma mark -自适应webVeiw的高度KVO

-(void)kvoScrollViewContentSize{
    [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:(NSKeyValueObservingOptionNew) context:nil];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}


#pragma mark ---- 实时改变webView的控件高度，使其高度跟内容高度一致
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"contentSize"]) {
        CGFloat height = self.webView.scrollView.contentSize.height;
        if (height != self.height - ScaleW(40)) {
            //NSlog(@"height ====== %f ==== %f ==== %@",height,self.webView.scrollView.contentSize.width,change);
            NSLog(@"height ====== %f ==== %f ==== %@",height,self.webView.scrollView.contentSize.width,change);
            if (self.webView.scrollView.contentSize.width <= ScreenWidth) {
                self.detailView.height = height + ScaleW(50);
                self.webView.height = height;
                 self.webView.width = ScreenWidth;
                self.bottomView.top = _detailView.bottom;
                self.height = self.bottomView.bottom;
                !self.reloadFrameBlock?:self.reloadFrameBlock();
            }
        }
    }else if ([keyPath isEqualToString:@"estimatedProgress"]) {
        //进度
        if (self.webView.estimatedProgress >= 1.0f) {
            [MBProgressHUD hideHUDForView:self animated:YES];
        }
        
    }
}
- (void)dealloc
{
    if (self.webView) {
        
        [self.webView.scrollView removeObserver:self
        forKeyPath:@"contentSize"
           context:nil];
        [self.webView removeObserver:self
           forKeyPath:@"estimatedProgress"
              context:nil];
    }
    
   
}

#pragma mark ----authorView

-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, _detailView.bottom, ScreenWidth, ScaleW(300))];
        [_bottomView addSubview:self.authorImgView];
        [_bottomView addSubview:self.authorView];
        [_bottomView addSubview:self.youlikedImgView];
        _bottomView.height = self.youlikedImgView.bottom + ScaleW(20);
        
    }
    return _bottomView;
}

-(UIImageView *)authorImgView{
    if (!_authorImgView) {
        _authorImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"作者信息"]];
        _authorImgView.top = ScaleW(20);
        _authorImgView.centerX = _bottomView.width/2.f;
    }
    return _authorImgView;
}

-(UIView *)authorView{
    if (!_authorView) {
        _authorView = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(60), _bottomView.width, ScaleW(138))];
        _authorView.backgroundColor = kWhiteColor;
        [_authorView addSubview:self.authorHeaderImg];
        [_authorView addSubview:self.authorNameLabel];
        [_authorView addSubview:self.authorAgeLabel];
        [_authorView addSubview:self.authorSchoolLabel];
        
        UIButton *btn = [WLTools allocButtonTitle:@"" font:systemFont(ScaleW(0)) textColor:kWhiteColor image:nil frame:CGRectMake(0, 0, _authorView.width, _authorView.height) sel:@selector(authorAction:) taget:self];
        [_authorView addSubview:btn];
    }
    return _authorView;
}
-(void)authorAction:(UIButton *)sender
{
    !self.authorBlock?:self.authorBlock();
}
-(UIImageView *)authorHeaderImg{
    if (!_authorHeaderImg) {
        _authorHeaderImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(11), ScaleW(28), ScaleW(90), ScaleW(90))];
        _authorHeaderImg.backgroundColor = kSubBacColor;
        _authorHeaderImg.cornerRadius = ScaleW(5);
        
    }
    return _authorHeaderImg;
}
-(UILabel *)authorNameLabel{
    if (!_authorNameLabel) {
        _authorNameLabel = [WLTools allocLabel:@"Lorem " font:systemBoldFont(ScaleW(16)) textColor:kMainTxtColor frame:CGRectMake(_authorHeaderImg.right + ScaleW(17), ScaleW(27), ScaleW(250), ScaleW(16)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _authorNameLabel;
}
-(UILabel *)authorAgeLabel{
    if (!_authorAgeLabel) {
        _authorAgeLabel = [WLTools allocLabel:@"出生年月：1996-12-10" font:systemFont(ScaleW(12)) textColor:kGrayTxtColor frame:CGRectMake(_authorHeaderImg.right + ScaleW(17), ScaleW(12) + _authorNameLabel.bottom, ScaleW(250), ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _authorAgeLabel;
}
-(UILabel *)authorSchoolLabel{
    if (!_authorSchoolLabel) {
        _authorSchoolLabel = [WLTools allocLabel:@"毕业院校：北京清华大学" font:systemFont(ScaleW(12)) textColor:kGrayTxtColor frame:CGRectMake(_authorHeaderImg.right + ScaleW(17), ScaleW(7) + _authorAgeLabel.bottom, ScaleW(250), ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _authorSchoolLabel;
}

-(UIImageView *)youlikedImgView{
    if (!_youlikedImgView) {
        _youlikedImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cainixihuan"]];
        _youlikedImgView.top = ScaleW(27) + _authorView.bottom;
        _youlikedImgView.centerX = _bottomView.width/2.f;
    }
    return _youlikedImgView;
}
@end

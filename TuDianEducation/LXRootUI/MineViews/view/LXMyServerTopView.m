//
//  LXMyServerTopView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/1.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXMyServerTopView.h"
#import "SDCycleScrollView.h"
#import "LXServerDetailModel.h"
#import "LXSaveUserInforTool.h"

@interface LXMyServerTopView()<SDCycleScrollViewDelegate>
@property (nonatomic,strong) SDCycleScrollView *bannerView;
@property (nonatomic,strong) UILabel *currentPageLabel;

@property (nonatomic,strong) UIView *headerBackView;
@property (nonatomic,strong) UIView *boomView;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UIButton *shareBtn;
@property (nonatomic,strong) UILabel *goodsLabel;
@property (nonatomic,strong) UILabel *subGoodsLabel;

@property (nonatomic,strong) UIView *userInstrate;
@property (nonatomic,strong) UIImageView *userPicImg;
@property (nonatomic,strong) UILabel *userUserName;
@property (nonatomic,strong) UILabel *subuserUserName;
@property (nonatomic,strong) UILabel *goodCommentsLabel;
@property (nonatomic,strong) UILabel *commentsLabel;



@end
@implementation LXMyServerTopView

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
    [self addSubview:self.priceLabel];
    [self addSubview:self.shareBtn];
    [self addSubview:self.goodsLabel];
    [self addSubview:self.subGoodsLabel];
    [self addSubview:self.userInstrate];
   
    
    [self.userInstrate addSubview:self.userPicImg];
    [self.userInstrate addSubview:self.userUserName];
    [self.userInstrate addSubview:self.subuserUserName];
    [self.userInstrate addSubview:self.goodCommentsLabel];
    [self.userInstrate addSubview:self.commentsLabel];
    
    self.height = self.userInstrate.top;
   
}
#pragma mark - 播视图
-(SDCycleScrollView *)bannerView
{
    if (_bannerView==nil)
    {
        _bannerView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0, ScreenWidth, ScreenWidth + ScaleW(10)) delegate:self placeholderImage:BUNDLE_PNGIMG(@"homePage", @"bannerDefult")];
        _bannerView.backgroundColor = [UIColor clearColor];
        _bannerView.pageControlAliment = SDCycleScrollViewPageContolStyleNone;
        _bannerView.localizationImageNamesGroup = @[@"defultLocalImg",@"defultLocalimg2"];
        _bannerView.autoScrollTimeInterval = 5.0;
        _bannerView.pageDotColor = kWhiteColor;
        _bannerView.currentPageDotColor = kBlueColor;
        
    }
    
    return _bannerView;
}
-(UILabel *)currentPageLabel{
    if (!_currentPageLabel) {
        NSString *message = [NSString stringWithFormat:@"%d/%ld",1,_bannerView.imageURLStringsGroup.count];
        _currentPageLabel = [WLTools allocLabel:message font:systemFont(ScaleW(15)) textColor:kWhiteColor frame:CGRectMake(ScaleW(304), (3/4.f)*_bannerView.height, ScaleW(56), ScaleW(26)) textAlignment:(NSTextAlignmentCenter)];
        _currentPageLabel.backgroundColor = kBacColor;
        _currentPageLabel.cornerRadius = _currentPageLabel.height/2.f;
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
        _boomView = [[UIView alloc]initWithFrame:CGRectMake(0, _bannerView.bottom , ScreenWidth, ScaleW(145))];
        _boomView.backgroundColor = kWhiteColor;
    }
    return _boomView;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [WLTools allocLabel:@"￥0.0" font:systemFont(ScaleW(25)) textColor:kRedColor frame:CGRectMake(ScaleW(15), _headerBackView.top + ScaleW(28), self.width - ScaleW(15) *2, ScaleW(25)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _priceLabel;
}

-(UIButton *)shareBtn{
    if (!_shareBtn) {
        _shareBtn  = [WLTools allocButtonTitle:@"分享" font:systemFont(ScaleW(13)) textColor:kMainTxtColor image:nil frame:CGRectMake(0, 0, ScaleW(70), ScaleW(26)) sel:@selector(shareBtnAction:) taget:self];
        _shareBtn.centerY = _priceLabel.centerY;
        _shareBtn.right = self.width;
        _shareBtn.backgroundColor = kGrayBtnBacColor;
    }
    return _shareBtn;
}
-(UILabel *)goodsLabel{
    if (!_goodsLabel) {
        _goodsLabel = [WLTools allocLabel:@"比纳仰卧板仰卧起坐健身器材家用多功能哑铃凳健身器收腹器腹肌板" font:systemFont(ScaleW(16)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(15), ScaleW(20) + _priceLabel.bottom, self.width - ScaleW(30), ScaleW(42)) textAlignment:(NSTextAlignmentLeft)];
        _goodsLabel.numberOfLines = 2;
    }
    return _goodsLabel;
}
-(UILabel *)subGoodsLabel
{
    if (!_subGoodsLabel) {
        _subGoodsLabel = [WLTools allocLabel:@"副标题：标题名称标题名称标题名称" font:systemFont(ScaleW(14)) textColor:kSubTxtColor frame:CGRectMake(_priceLabel.left, _goodsLabel.bottom + ScaleW(18), _goodsLabel.width, ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _subGoodsLabel;
}
-(UIView *)userInstrate{
    if (!_userInstrate) {
        _userInstrate = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(10) + _boomView.bottom, self.width, ScaleW(95))];
        _userInstrate.backgroundColor = kWhiteColor;
        _userInstrate.hidden = YES;
    }
    return _userInstrate;
}
-(UIImageView *)userPicImg{
    if (!_userPicImg) {
        _userPicImg = [[UIImageView alloc]initWithFrame:CGRectMake(_priceLabel.left,ScaleW(18),ScaleW(59) , ScaleW(59))];
        _userPicImg.backgroundColor = kBlueColor;
        [_userPicImg setCornerRadius:_userPicImg.height/2.f];
    }
    return _userPicImg;
}
-(UILabel *)userUserName{
    if (!_userUserName) {
        _userUserName = [WLTools allocLabel:@"工程师名称" font:systemBoldFont(ScaleW(15)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(16) + _userPicImg.right, ScaleW(5) + _userPicImg.top , _userInstrate.width - _userPicImg.right- ScaleW(46), ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _userUserName;
}
-(UILabel *)subuserUserName{
    if (!_subuserUserName) {
        _subuserUserName = [WLTools allocLabel:@"年龄：30  从业年限：3年 " font:systemFont(ScaleW(13)) textColor:kSubTxtColor frame:CGRectMake(_userUserName.left, ScaleW(16) + _userUserName.bottom, _userUserName.width, ScaleW(13)) textAlignment:(NSTextAlignmentLeft)];

    }
    return _subuserUserName;
}

-(UILabel *)goodCommentsLabel{
    if (!_goodCommentsLabel) {
        _goodCommentsLabel = [WLTools allocLabel:@"好评率" font:systemFont(ScaleW(14)) textColor:kGrayTxtColor frame:CGRectMake(_userUserName.left, _subuserUserName.top, _userUserName.width, ScaleW(14)) textAlignment:(NSTextAlignmentRight)];
    }
    return _goodCommentsLabel;
}
-(UILabel *)commentsLabel{
    if (!_commentsLabel) {
        _commentsLabel = [WLTools allocLabel:@"99%" font:systemBoldFont(ScaleW(20)) textColor:kRedColor frame:CGRectMake(ScaleW(10) + _userPicImg.right, ScaleW(5) + _userPicImg.top , _userInstrate.width - _userPicImg.right- ScaleW(40), ScaleW(20)) textAlignment:(NSTextAlignmentRight)];
    }
    return _commentsLabel;
}
-(void)shareBtnAction:(UIButton *)sender
{
    
}
-(void)setModel:(LXServerDetailModel *)model{
    _model = model;
    self.bannerView.imageURLStringsGroup = _model.bannerimages;
    NSString *message = [NSString stringWithFormat:@"%d/%ld",1,_bannerView.imageURLStringsGroup.count];
    self.currentPageLabel.text = message;
    NSString *priceString =[NSString stringWithFormat:@"￥%@",_model.servicesprice];
    self.priceLabel.text = priceString;
    self.goodsLabel.text = _model.servicesname;
    self.subGoodsLabel.text = _model.servicestitle;
     LXUserInforModel *userModel = [LXSaveUserInforTool sharedUserTool].userInforModel;
    [self.userPicImg sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:userModel.icon]]];
    self.userUserName.text = userModel.nickname;
    self.subuserUserName.text = [NSString stringWithFormat:@"年龄：%@  从业年限：%@年",userModel.age,userModel.workingyears];
    _commentsLabel.text = @"";
}
@end

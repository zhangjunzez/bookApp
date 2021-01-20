//
//  BkHomePageView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/12.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "BkHomePageView.h"
#import "BkAgeItemsView.h"
#import "BkBookItemsView.h"
#import "SDCycleScrollView.h"

@interface BkHomePageView()<SDCycleScrollViewDelegate>
@property (nonatomic,strong) SDCycleScrollView *bannerView;
@property (nonatomic,strong) NSMutableArray *imgUiarray;
@property (nonatomic,strong) NSArray*imgArray;
@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) NSMutableArray *imgItemsUiarray;
@property (nonatomic,strong) NSArray*imgItemsArray;

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIButton *seeMoreBtn;

@end
@implementation BkHomePageView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(-ScaleW(15), 0, ScreenWidth, ScaleW(300));
        [self addSubview:self.bannerView];
        self.imgArray = @[@"0~3岁",@"3~6岁",@"6~9岁",@"9~12岁",@"影音书"];
        self.imgItemsArray = @[@{@"title":@"启蒙教育",@"subTitle":@"学习会思考"},@{@"title":@"儿童文学",@"subTitle":@"太空科普"},@{@"title":@"科普百科",@"subTitle":@"发现宇宙奥妙"},@{@"title":@"教辅题材",@"subTitle":@"感受学习的乐趣"}];
        [self addSubview:self.titleLabel];
        [self addSubview:self.seeMoreBtn];
        self.height = self.titleLabel.bottom + ScaleW(15);
        self.backgroundColor = kWhiteColor;
    }
    return self;
}


#pragma mark - 播视图
-(SDCycleScrollView *)bannerView
{
    if (_bannerView==nil)
    {
        _bannerView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(ScaleW(0),0, self.width, ScaleW(170)) delegate:self placeholderImage:BUNDLE_PNGIMG(@"homePage", @"bannerDefult")];
        _bannerView.backgroundColor = [UIColor clearColor];
        _bannerView.pageControlAliment = SDCycleScrollViewPageContolStyleNone;
        _bannerView.localizationImageNamesGroup = @[@"defultLocalImg",@"defultLocalimg2"];
        _bannerView.autoScrollTimeInterval = 5.0;
        _bannerView.pageDotColor = kWhiteColor;
        _bannerView.currentPageDotColor = kRedColor;
        
    }
    
    return _bannerView;
}


#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    //!self.urlClickBlock?:self.urlClickBlock(index);
}
/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
     
};

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _bannerView.bottom,self.width, ScaleW(80))];
        
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
        BkAgeItemsView *img = [[BkAgeItemsView alloc]initWithFrame:CGRectMake(0 + i * ScaleW(76), 0, ScaleW(76), ScaleW(80))];
        [self.scrollView addSubview:img];
        self.scrollView.contentSize = CGSizeMake(img.right + ScaleW(16), 0);
        [self.imgUiarray addObject:img];
        WS(weakSelf);
        img.messageLabel.text = _imgArray[i];
        img.selectBlock = ^(BkAgeItemsView * _Nonnull sender) {
            [weakSelf setSelctItems:sender];
        };
    }
    [self addSubview:self.scrollView];
}

-(void)setSelctItems:(BkAgeItemsView *)sender
{
    for (BkAgeItemsView *v in self.imgUiarray) {
        if (v == sender) {
            [v setItemsSelct:YES];
        }else{
            [v setItemsSelct:NO];
        }
    }
    NSUInteger index = [self.imgUiarray indexOfObject:sender];
    !self.selctItemBlock?:self.selctItemBlock(index);
}

-(NSMutableArray *)imgItemsUiarray{
    if (!_imgItemsUiarray) {
        _imgItemsUiarray = [NSMutableArray array];
    }
    return _imgItemsUiarray;
}
-(void)setImgItemsArray:(NSArray *)imgItemsArray{
    _imgItemsArray = imgItemsArray;
    for (UIView *v in self.imgItemsUiarray) {
        [v removeFromSuperview];
    }
    [self.imgItemsUiarray removeAllObjects];
    for (int i = 0; i < _imgItemsArray.count; i ++) {
        BkBookItemsView *img = [[BkBookItemsView alloc]initWithFrame:CGRectMake(ScaleW(10) + (i%2) * ScaleW(178), (i/2)*ScaleW(74) + _scrollView.bottom, ScaleW(172), ScaleW(68))];
        [self addSubview:img];
        NSDictionary *dic = self.imgItemsArray[i];
        img.nameLabel.text = dic[@"title"];
        img.subNameLabel.text = dic[@"subTitle"];
        [self.imgItemsUiarray addObject:img];
        WS(weakSelf);
        img.selctBlock = ^(BkBookItemsView * _Nonnull sender) {
            [weakSelf setThemeSelctItems:sender];
        };
    }
}
-(void)setThemeSelctItems:(BkBookItemsView *)sender
{
   
    NSUInteger index = [self.imgItemsUiarray indexOfObject:sender];
    !self.selctThemeBlock?:self.selctThemeBlock(index);
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        BkBookItemsView *img = self.imgItemsUiarray.lastObject;
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(12), img.bottom + ScaleW(55), ScaleW(64), ScaleW(6))];
        lineView.backgroundColor = UIColorFromRGB(0xFF5F68);
        [self addSubview:lineView];
        _titleLabel = [WLTools allocLabel:@"为您推荐" font:systemBoldFont(ScaleW(16)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(12), ScaleW(44) + img.bottom, ScaleW(70), ScaleW(16)) textAlignment:(NSTextAlignmentLeft)];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"推荐(1)"]];
        imageView.left = ScaleW(78);
        imageView.top = _titleLabel.top - ScaleW(5);
        [self addSubview:imageView];
    }
    return _titleLabel;
}
-(UIButton *)seeMoreBtn{
    if (!_seeMoreBtn) {
        _seeMoreBtn = [WLTools allocButtonTitle:@"查看更多" font:systemFont(ScaleW(12)) textColor:kSubTxtColor image:nil frame:CGRectMake(0, _titleLabel.top - ScaleW(5), ScaleW(80), ScaleW(40)) sel:@selector(seeMoreBtnAction:) taget:self];
        _seeMoreBtn.right = self.width;
    }
    return _seeMoreBtn;
}

-(void)seeMoreBtnAction:(UIButton *)sender
{
    !self.seeMoreBlock?:self.seeMoreBlock();
}
@end

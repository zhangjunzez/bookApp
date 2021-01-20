//
//  LXDetailBottomView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/2.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//


#import "LXDetailBottomView.h"
#import <WebKit/WebKit.h>
@interface LXDetailBottomView()<WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate>
@property (nonatomic,strong) UILabel *goodsNameLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) NSArray *contenImgArray;
@property (nonatomic,strong) NSMutableArray *uiArray;
@property (nonatomic,strong)  WKWebView*webView;
@end

@implementation LXDetailBottomView

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
    self.backgroundColor = kWhiteColor;
    [self addSubview:self.goodsNameLabel];
    [self addSubview:self.detailLabel];
    [self addSubview:self.webView];
    [self kvoScrollViewContentSize];
    self.height = self.webView.bottom + ScaleW(10);
}

-(UILabel *)goodsNameLabel{
    if (!_goodsNameLabel) {
        _goodsNameLabel = [WLTools allocLabel:@"商品详情" font:systemBoldFont(ScaleW(15)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(15), ScaleW(20), ScreenWidth - ScaleW(15) * 2, ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _goodsNameLabel;
}

-(UILabel *)detailLabel
{
    if (!_detailLabel) {
        _detailLabel = [WLTools allocLabel:@"*********" font:systemFont(ScaleW(14)) textColor:kSubTxtColor frame:CGRectMake(_goodsNameLabel.left, _goodsNameLabel.bottom + ScaleW(22), ScreenWidth - ScaleW(15) * 2, ScaleW(50)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _detailLabel;
}
-(NSMutableArray *)uiArray{
    if (!_uiArray) {
        _uiArray = [NSMutableArray array];
    }
    return _uiArray;
}

-(void)setContenImgArray:(NSArray *)contenImgArray{
    _contenImgArray = contenImgArray;
    for (UIView * v in self.uiArray) {
        [v removeFromSuperview];
    }
    for (int i = 0; i < _contenImgArray.count; i ++) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(_detailLabel.left, _detailLabel.bottom + ScaleW(15) + _detailLabel.width*i , ScreenWidth - ScaleW(15) * 2, _detailLabel.width)];
        imgView.backgroundColor = kBlueColor;
        [self addSubview:imgView];
        [self.uiArray addObject:imgView];
    }
    UIImageView *img = self.uiArray.lastObject;
    self.height = img.bottom + ScaleW(50);
    
}
-(void)setModel:(LXMarketGoodsDetailModel *)model
{
    _model = model;
    _detailLabel.text = _model.introduction;
    [_detailLabel sizeToFit];
    self.webView.top = _detailLabel.bottom + ScaleW(20);
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_model.url]]];
}
-(WKWebView *)webView
{
    if (nil == _webView) {
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(ScaleW(10), _goodsNameLabel.bottom + ScaleW(20),ScreenWidth - ScaleW(20) , ScreenHeight-ScaleW(10))];
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

#pragma mark -禁止缩放ScrollViewdelegate

//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
//{
//    return nil;
//}
//- (void)dealloc
//{
//    [self.webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
//}
//- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
//    self.webView.scrollView.scrollEnabled = NO;
//    [webView evaluateJavaScript:@"document.body.scrollHeight" completionHandler:^(id result, NSError *_Nullable error) {
//        NSString * height = [NSString stringWithFormat:@"%@",result];
//        self.webView.height = height.doubleValue;
//        self.height = self.webView.bottom + ScaleW(40);
//        !self.reloadFrameBlock?:self.reloadFrameBlock();
//    }];
// }

#pragma mark ---- 实时改变webView的控件高度，使其高度跟内容高度一致
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"contentSize"]) {
        CGFloat height = self.webView.scrollView.contentSize.height;
        if (height != self.height - ScaleW(40)) {
            //NSlog(@"height ====== %f ==== %f ==== %@",height,self.webView.scrollView.contentSize.width,change);
            NSLog(@"height ====== %f ==== %f ==== %@",height,self.webView.scrollView.contentSize.width,change);
            if (self.webView.scrollView.contentSize.width <= ScreenWidth) {
                self.height = height + ScaleW(40);
                self.webView.height = height;
                 self.webView.width = ScreenWidth;
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
    [self.webView.scrollView removeObserver:self
    forKeyPath:@"contentSize"
       context:nil];
    [self.webView removeObserver:self
       forKeyPath:@"estimatedProgress"
          context:nil];
   
}
@end

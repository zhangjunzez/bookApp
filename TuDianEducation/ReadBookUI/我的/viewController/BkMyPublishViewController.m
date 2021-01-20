//
//  BkMyPublishViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/9.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "BkMyPublishViewController.h"
#import "BkMyxindeViewController.h"
#import "BkMyConmendViewController.h"

@interface BkMyPublishViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIView *swichView;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIButton *getCarPriceBtn;
@property (nonatomic,strong) UIButton *arivePriceBtn;
@property (nonatomic,strong) NSString *type;
@end

@implementation BkMyPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = self.swichView;
    [self.view addSubview:self.scrollView];
}
-(UIView *)swichView{
    if (!_swichView) {
        _swichView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(0), ScaleW(0), ScreenWidth - ScaleW(130), ScaleW(30))];
        
        _swichView.backgroundColor = kGreenColor;
        
        [_swichView setCornerRadius:_swichView.height/2.f];
        [_swichView addSubview:self.getCarPriceBtn];
        [_swichView addSubview:self.arivePriceBtn];
    }
    return _swichView;
}

-(UIButton *)getCarPriceBtn{
    if (!_getCarPriceBtn) {
        CGFloat w = _swichView.width/2.f-3;
        
        _getCarPriceBtn = [WLTools allocButtonTitle:@"我的心得" font:systemFont(ScaleW(13)) textColor:kWhiteColor image:nil frame:CGRectMake(3, 3, w, _swichView.height - 6) sel:@selector(swichViewAction:) taget:self];
        [_getCarPriceBtn setTitleColor:kGreenColor forState:(UIControlStateSelected)];
        _getCarPriceBtn.backgroundColor = kWhiteColor;
        [_getCarPriceBtn setCornerRadius:_getCarPriceBtn.height/2.f];
        _getCarPriceBtn.selected = YES;
    }
    return _getCarPriceBtn;
}
-(UIButton *)arivePriceBtn{
    if (!_arivePriceBtn) {
        CGFloat w = _swichView.width/2.f-3;
        _arivePriceBtn = [WLTools allocButtonTitle:@"我的回复" font:systemFont(ScaleW(13)) textColor:kWhiteColor image:nil frame:CGRectMake(_getCarPriceBtn.right, 3, w, _swichView.height - 6) sel:@selector(swichViewAction:) taget:self];
        [_arivePriceBtn setTitleColor:kGreenColor forState:(UIControlStateSelected)];
        _arivePriceBtn.backgroundColor = kGreenColor;
        _arivePriceBtn.selected = NO;
        [_arivePriceBtn setCornerRadius:_arivePriceBtn.height/2.f];
    }
    return _arivePriceBtn;
}
-(void)swichViewAction:(UIButton *)sender{

    if (sender == _getCarPriceBtn) {
 
        self.type = @"1";
        CGPoint offsize = self.scrollView.contentOffset;
        offsize.x = 0;
        [self.scrollView setContentOffset:offsize animated:YES];
    }
    if (sender == _arivePriceBtn) {
       
        self.type = @"2";
        CGPoint offsize = self.scrollView.contentOffset;
        offsize.x = ScreenWidth;
        [self.scrollView setContentOffset:offsize animated:YES];
    }
    
}

-(void)setType:(NSString *)type{
    _type = type;
    if ([_type isEqualToString:@"1"]) {
        _arivePriceBtn.selected = NO;
        _arivePriceBtn.backgroundColor = kGreenColor;
        _getCarPriceBtn.selected = YES;
        _getCarPriceBtn.backgroundColor = kWhiteColor;
    }
    if ([_type isEqualToString:@"2"]) {
        _arivePriceBtn.selected = YES;
        _arivePriceBtn.backgroundColor = kWhiteColor;
        _getCarPriceBtn.selected = NO;
        _getCarPriceBtn.backgroundColor = kGreenColor;
    }
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar )];
        _scrollView.contentSize = CGSizeMake(ScreenWidth *2, 0);
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        /////订单状态 0待支付 1服务中 2待评价 3已完成 4异常订单
       
        for (int i = 0; i < 2; i ++) {
            if (i == 0) {
                BkMyxindeViewController *vc = [[BkMyxindeViewController alloc]init];
               
                [self addChildViewController:vc];
                [_scrollView addSubview:vc.view];
                
                vc.view.frame = CGRectMake(ScreenWidth * i, 0, ScreenWidth, _scrollView.height);
            }
      
            if (i == 1) {
                BkMyConmendViewController *vc = [[BkMyConmendViewController alloc]init];
               
                [self addChildViewController:vc];
                [_scrollView addSubview:vc.view];
                
                vc.view.frame = CGRectMake(ScreenWidth * i, 0, ScreenWidth, _scrollView.height);
            }
      
        }
       
    }
    return _scrollView;
}
    
#pragma mark - scroll delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGPoint offset = scrollView.contentOffset;
    
    if (offset.x < 0) {
        return;
    }
    NSInteger index = offset.x/ScreenWidth;
    
    self.type = index == 1 ?@"2":@"1";

}


@end

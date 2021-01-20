//
//  LXScoreControlView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/24.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//


#import "LXScoreControlView.h"
@interface LXScoreControlView()<UIScrollViewDelegate>
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UIView *movingLine;
@property (nonatomic, strong) NSArray *bttonsArray;
@property (nonatomic, strong) UIScrollView *contenScrollView;
@property (nonatomic, strong) NSMutableArray *btnUiArray;
@end
#define kTag(a) 1000000 + a
@implementation LXScoreControlView

-(instancetype)init{
    if (self = [super init])
    {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(56));
        
        
        [self addSubview:self.contenScrollView];
        
        [self viewConfig];
        self.backgroundColor = kWhiteColor;
    }
    return self;
}

-(NSMutableArray *)btnUiArray
{
    if (!_btnUiArray) {
        _btnUiArray = [NSMutableArray array];
        
    }
    return _btnUiArray;
}

-(UIScrollView *)contenScrollView
{
    if (!_contenScrollView) {
        _contenScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _contenScrollView.delegate = self;
        _contenScrollView.backgroundColor = kWhiteColor;
    }
    return _contenScrollView;
}
-(instancetype)initWithTop:(CGFloat)top titleArray:(NSArray *)titleArray
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, top, ScreenWidth, ScaleW(43));
        [self addSubview:self.contenScrollView];
        
        [self viewConfig];
        
        self.bttonsArray = titleArray;
    }
    return self;
};

-(void)viewConfig
{
    [self.contenScrollView addSubview:self.bottomLine];
    [self.contenScrollView addSubview:self.movingLine];
}

-(UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(42), ScreenWidth, ScaleW(1))];
        //_bottomLine.backgroundColor = kLineViewColor;
        
        
    }
    return _bottomLine;
    
}

-(UIView *)movingLine
{
    if (!_movingLine) {
     CGFloat width =  [self returnWidth:SSKJLocalized(@"STO账户", nil) font:ScaleW(13)];
        _movingLine = [[UIView alloc]initWithFrame:CGRectMake(0,self.height -  ScaleW(4), width, ScaleW(4))];
        _movingLine.backgroundColor = kGreenColor;
        
    }
    return _movingLine;
}
-(void)setBttonsArray:(NSArray *)bttonsArray
{
    _bttonsArray = bttonsArray;
    if (self.btnUiArray.count > 0) {
        for (UIButton *btn in self.btnUiArray) {
            [btn removeFromSuperview];
        }
    }
    
    [self.btnUiArray removeAllObjects];

    CGFloat allWidth = 0;
    for (int i = 0; i < _bttonsArray.count; i ++) {
        CGFloat titleWidth = ScreenWidth/3.f;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake( allWidth, 0, (titleWidth), ScaleW(40));
        [self.contenScrollView addSubview:btn];
        btn.tag = kTag(i);
        [btn btn:btn font:ScaleW(13) textColor:kSubTxtColor text:SSKJLocalized(_bttonsArray[i], nil) image:nil sel:@selector(bttonsAction:) taget:self];
        [btn setTitleColor:kMainTxtColor forState:(UIControlStateSelected)];
        [self.btnUiArray addObject:btn];
        [self setCurrentIndex:0];
        allWidth += titleWidth ;
       
    }
    
    self.contenScrollView.contentSize = CGSizeMake(allWidth, 0);
    
    
    
}
-(void)setCurrentIndex:(NSInteger)currentIndex
{
    for (int i = 0; i < self.bttonsArray.count; i ++) {
        UIButton * btn = [self viewWithTag:kTag(i)];
        btn.selected = NO;
        btn.titleLabel.font = systemFont(ScaleW(13));
    }
    _currentIndex = currentIndex;
    UIButton * btn = [self viewWithTag:kTag(_currentIndex)];
    btn.selected = YES;
    btn.titleLabel.font = systemFont(ScaleW(15));
    self.movingLine.width = [self returnWidth:self.bttonsArray[_currentIndex] font:ScaleW(16)];
    [UIView animateWithDuration:.2 animations:^{
       self.movingLine.centerX = btn.centerX;
    }];
        
    if (btn.centerX > ScreenWidth/2.f + ScaleW(15)) {
        if ((btn.centerX - ScreenWidth/2.f) > self.contenScrollView.contentSize.width - ScreenWidth) {
            if (self.contenScrollView.contentSize.width - ScreenWidth >0) {
               [self.contenScrollView setContentOffset:CGPointMake(self.contenScrollView.contentSize.width - ScreenWidth, 0) animated:YES];
            }
    
        }else{
            [self.contenScrollView setContentOffset:CGPointMake(btn.centerX - ScreenWidth/2.f, 0) animated:YES];
        }
        
    }else{
         [self.contenScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    
    
}

-(void)bttonsAction:(UIButton *)sender
{
    NSInteger index = sender.tag - kTag(0);
    
    [self setCurrentIndex:index];
    
    !self.btnClickedBlock?:self.btnClickedBlock(index);
}


@end

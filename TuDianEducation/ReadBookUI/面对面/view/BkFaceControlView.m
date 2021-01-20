//
//  BkFaceControlView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/11.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//


#import "BkFaceControlView.h"
@interface BkFaceControlView()<UIScrollViewDelegate>
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UIView *movingLine;
@property (nonatomic, strong) NSArray *bttonsArray;
@property (nonatomic, strong) UIScrollView *contenScrollView;
@property (nonatomic, strong) NSMutableArray *btnUiArray;
@property (nonatomic,assign) CGFloat pamaWidth;
@end
#define kTag(a) 1000000 + a
@implementation BkFaceControlView

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

-(instancetype)initWithTop:(CGFloat)top titleArray:(NSArray *)titleArray width:(CGFloat)width
{
    if (self = [super init]) {
           self.pamaWidth = width;
           self.frame = CGRectMake(0, top, ScreenWidth, ScaleW(43));
           [self addSubview:self.contenScrollView];
         
           [self viewConfig];
           
           self.bttonsArray = titleArray;
       }
       return self;
};
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
        _movingLine = [[UIView alloc]initWithFrame:CGRectMake(0,self.height -  ScaleW(3), width, ScaleW(2))];
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

    CGFloat allWidth = ScaleW(15);
    for (int i = 0; i < _bttonsArray.count; i ++) {
        NSString *string = _bttonsArray[i];
        CGFloat w =  [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, ScaleW(18)) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:systemFont(ScaleW(12))} context:nil].size.width;
        CGFloat titleWidth =w + ScaleW(20);
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake( allWidth, ScaleW(15), (titleWidth), ScaleW(25));
        [self.contenScrollView addSubview:btn];
        btn.tag = kTag(i);
        [btn btn:btn font:ScaleW(12) textColor:kSubTxtColor text:SSKJLocalized(_bttonsArray[i], nil) image:nil sel:@selector(bttonsAction:) taget:self];
        [btn setTitleColor:kWhiteColor forState:(UIControlStateSelected)];
        [self.btnUiArray addObject:btn];
        [self setCurrentIndex:0];
        btn.cornerRadius = btn.height/2.f;
        
        allWidth += titleWidth + ScaleW(15);
       
    }
    
    self.contenScrollView.contentSize = CGSizeMake(allWidth, 0);
    
    
    
}
-(void)setCurrentIndex:(NSInteger)currentIndex
{
    for (int i = 0; i < self.bttonsArray.count; i ++) {
        UIButton * btn = [self viewWithTag:kTag(i)];
        btn.selected = NO;
        btn.titleLabel.font = systemFont(ScaleW(12));
        btn.backgroundColor = kSubBacColor;
    }
    _currentIndex = currentIndex;
    UIButton * btn = [self viewWithTag:kTag(_currentIndex)];
    btn.selected = YES;
    btn.backgroundColor = kGreenColor;
    btn.titleLabel.font = systemBoldFont(ScaleW(12));
    self.movingLine.width = [self returnWidth:self.bttonsArray[_currentIndex] font:ScaleW(13)];
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

//
//  ETF_Default_ActionsheetView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/7.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "ETF_Default_ActionsheetView.h"

@interface ETF_Default_ActionsheetView ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *showView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *cancleButton;
@property (nonatomic, strong) NSMutableArray *viewArray;
@property (nonatomic, strong) NSArray *itemsArray;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) void (^selectedIndexBlock)(NSInteger selectIndex);

@property (nonatomic, strong) void (^cancleBlock)(void);

@end

@implementation ETF_Default_ActionsheetView

+(void)showWithItems:(NSArray *)itemsArray title:(NSString *)title selectedIndexBlock:(void(^)(NSInteger selectIndex))selectIndexBlcok cancleBlock:(void(^)(void))cancleBlock
{
    ETF_Default_ActionsheetView *actionSheet = [[ETF_Default_ActionsheetView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    actionSheet.title = title;
    actionSheet.itemsArray = itemsArray;
    actionSheet.selectedIndexBlock = selectIndexBlcok;
    actionSheet.cancleBlock = cancleBlock;
    [actionSheet show];
}

-(NSMutableArray *)viewArray
{
    if (nil == _viewArray) {
        _viewArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _viewArray;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        [self addSubview:self.scrollView];
        [self.scrollView addSubview:self.showView];
        [self.showView addSubview:self.titleLabel];
        [self.showView addSubview:self.cancleButton];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancleEvent)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(UIScrollView *)scrollView
{
    if (nil == _scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, Height_NavBar, ScreenWidth, ScreenHeight - Height_NavBar)];
    }
    return _scrollView;
}

-(UIView *)showView
{
    if (nil == _showView) {
        _showView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
        _showView.backgroundColor = kWhiteColor;
    }
    return _showView;
}

-(UIButton *)cancleButton
{
    if (nil == _cancleButton) {
        _cancleButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(48))];
        [_cancleButton setTitle:SSKJLocalized(@"取消", nil) forState:UIControlStateNormal];
        [_cancleButton setTitleColor:kMainTxtColor forState:UIControlStateNormal];
        _cancleButton.titleLabel.font = systemFont(ScaleW(14));
        [_cancleButton addTarget:self action:@selector(cancleEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:@"" font:systemBoldFont(ScaleW(14)) textColor:kBlueColor frame:CGRectMake(0, 0, ScreenWidth, ScaleW(48)) textAlignment:NSTextAlignmentCenter];
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _titleLabel.height, _titleLabel.width, 0.5)];
        lineView.backgroundColor = kMainLineColor;
        [_titleLabel addSubview:lineView];
    }
    return _titleLabel;
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = title;
    
    if (title.length) {
        self.titleLabel.hidden = NO;
    }else{
        self.titleLabel.hidden = YES;
    }
}

-(void)setItemsArray:(NSArray *)itemsArray
{
    _itemsArray = itemsArray;
    
    CGFloat startY = 0;
    if (self.title.length) {
        startY = self.titleLabel.height;
    }
    
    for (UIButton *btn in self.viewArray) {
        [btn removeFromSuperview];
    }
    
    [self.viewArray removeAllObjects];
    
    
    for (int i = 0; i < self.itemsArray.count; i++) {
        NSString *title = self.itemsArray[i];
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, startY + i * ScaleW(48), ScreenWidth, ScaleW(48))];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:kBlueColor forState:UIControlStateNormal];
        btn.titleLabel.font = systemFont(ScaleW(14));
        [self.showView addSubview:btn];
        [self.viewArray addObject:btn];
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, btn.height, btn.width, 0.5)];
        lineView.backgroundColor = kMainLineColor;
        [btn addSubview:lineView];
        
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
        
     }
    
    self.cancleButton.y = startY + self.itemsArray.count * ScaleW(48);
    self.showView.height = self.cancleButton.bottom;
    
//    self.showView.bottom = self.scrollView.height;
    
    if (self.showView.height >= self.scrollView.height) {
        self.showView.y = 0;
        self.scrollView.contentSize = CGSizeMake(ScreenWidth, self.showView.height);
        self.scrollView.contentOffset = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.height);

    }else{
        self.showView.y = self.scrollView.height - self.showView.height;
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }
    
}


-(void)cancleEvent
{
    if (self.cancleBlock) {
        self.cancleBlock();
    }
    
    [self hide];
}

-(void)selectItem:(UIButton *)btn
{
    NSInteger index = btn.tag - 100;
    if (self.selectedIndexBlock) {
        self.selectedIndexBlock(index);
        [self hide];
    }
}

-(void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    self.scrollView.y = self.height;
    WS(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.scrollView.y = ScreenHeight - weakSelf.scrollView.height;
    }];
}

-(void)hide
{
    WS(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.scrollView.y = ScreenHeight;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

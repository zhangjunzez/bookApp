//
//  MoreSelectActionSheetView.m

#import "MoreSelectActionSheetView.h"

@interface MoreSelectActionSheetView ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *showView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *cancleButton;
@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, strong) NSMutableArray *selectArray;
@property (nonatomic, strong) NSMutableArray *viewArray;
@property (nonatomic, strong) NSArray *itemsArray;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) void (^selectedIndexBlock)(NSArray * selectArray);

@property (nonatomic, strong) void (^cancleBlock)(void);

@end

@implementation MoreSelectActionSheetView

+(void)showWithItems:(NSArray *)itemsArray title:(NSString *)title selectedIndexBlock:(void(^)(NSArray * selectArray))selectIndexBlcok cancleBlock:(void(^)(void))cancleBlock
{
    MoreSelectActionSheetView *actionSheet = [[MoreSelectActionSheetView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
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
-(NSMutableArray *)selectArray{
    if (!_selectArray) {
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        [self addSubview:self.scrollView];
        [self.scrollView addSubview:self.showView];
        [self.showView addSubview:self.titleLabel];
        [self.showView addSubview:self.cancleButton];
        [self.showView addSubview:self.confirmBtn];
        
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
        _cancleButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/2.f, ScaleW(48))];
        [_cancleButton setTitle:SSKJLocalized(@"取消", nil) forState:UIControlStateNormal];
        [_cancleButton setTitleColor:kBlueColor forState:UIControlStateNormal];
        _cancleButton.titleLabel.font = systemFont(ScaleW(14));
        [_cancleButton addTarget:self action:@selector(cancleEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}
-(UIButton *)confirmBtn
{
    if (nil == _confirmBtn) {
        _confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2.f, 0, ScreenWidth/2.f, ScaleW(48))];
        [_confirmBtn setTitle:SSKJLocalized(@"确定", nil) forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:kBlueColor forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = systemFont(ScaleW(14));
        [_confirmBtn addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
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
    
    CGFloat startY = self.cancleButton.height;
    if (self.title.length) {
        startY += self.titleLabel.height;
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
        if (i == 0) {
            UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, btn.width, 0.5)];
            topLine.backgroundColor = kMainLineColor;
            [btn addSubview:topLine];
        }
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:BUNDLE_PNGIMG(@"mineCenter", @"checkboxOn") forState:(UIControlStateSelected)];
        [btn setImage:BUNDLE_PNGIMG(@"mineCenter", @"checkboxOff") forState:(UIControlStateNormal)];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, ScaleW(150), 0, 0)];
        
     }
    
    self.cancleButton.y = 0;
    self.confirmBtn.y = 0;
    self.showView.height = startY + self.itemsArray.count * ScaleW(48);
    
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
-(void)confirmEvent{
    if (self.selectedIndexBlock) {
        self.selectedIndexBlock(self.selectArray);
        [self hide];
    }
}
-(void)selectItem:(UIButton *)btn
{
    NSInteger index = btn.tag - 100;
    NSString *selectIndex = [NSString stringWithFormat:@"%ld",index];
    if ([self.selectArray containsObject:selectIndex]) {
        [self.selectArray removeObject:selectIndex];
        btn.selected = NO;
    }else{
        [self.selectArray addObject:selectIndex];
        btn.selected = YES;
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

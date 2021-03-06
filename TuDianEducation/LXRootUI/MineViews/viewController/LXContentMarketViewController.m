//
//  LXContentMarketViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/3.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//


#import "LXContentMarketViewController.h"
#import "LXMarketOrderViewController.h"

#import "LXGetMoneyControl.h"

@interface LXContentMarketViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) NSMutableArray *titleArray;
@property (nonatomic,strong) LXGetMoneyControl *controlView;
@property (nonatomic,strong) UIScrollView *scrollView;
@end

@implementation LXContentMarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.controlView];
    [self.view addSubview:self.scrollView];
    self.title = @"积分订单";
}
-(NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray= [NSMutableArray array];
        
    };
    return _titleArray;
}
-(LXGetMoneyControl *)controlView{
    if (!_controlView) {
        NSArray *titleArray = @[@"全部",@"待发货",@"待收货",@"已完成"];;
        [self.titleArray addObjectsFromArray:titleArray];
        _controlView = [[LXGetMoneyControl alloc]initWithTop:0 titleArray:self.titleArray width:ScreenWidth/4];
        ///默认全部
        _controlView.currentIndex = 0;
        WS(weakSelf);
        _controlView.btnClickedBlock = ^(NSInteger index) {
            CGPoint offsize = weakSelf.scrollView.contentOffset;
            offsize.x = index * ScreenWidth;
            [weakSelf.scrollView setContentOffset:offsize animated:YES];
        };
    }
    return _controlView;
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _controlView.height, ScreenWidth, ScreenHeight - Height_NavBar - _controlView.height)];
        _scrollView.contentSize = CGSizeMake(ScreenWidth *self.titleArray.count, 0);
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        /////订单状态0待发货 1待收货 2已完成 (不传是全部)
        NSArray *array = @[@"",@"0",@"1",@"2"];
        for (int i = 0; i < self.titleArray.count; i ++) {
            LXMarketOrderViewController *vc = [[LXMarketOrderViewController alloc]init];
            vc.state = array[i];
            [self addChildViewController:vc];
            [_scrollView addSubview:vc.view];
            vc.view.frame = CGRectMake(ScreenWidth * i, 0, ScreenWidth, _scrollView.height);
            vc.title = self.titleArray[i];
        }
        [self.view bringSubviewToFront:self.controlView];
    }
    return _scrollView;
    
}

    
#pragma mark - scroll delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGPoint offset = scrollView.contentOffset;
    
    if (offset.x < 0) {
        return;
    }

    [self.controlView setCurrentIndex:offset.x/ScreenWidth];

}


@end

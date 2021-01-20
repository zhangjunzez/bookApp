//
//  LXContenGetMoneyRecodViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/4.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//


#import "LXContenGetMoneyRecodViewController.h"
#import "LXGetMoneyRecodeViewController.h"

#import "LXGetMoneyControl.h"

@interface LXContenGetMoneyRecodViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) NSMutableArray *titleArray;
@property (nonatomic,strong) LXGetMoneyControl *controlView;
@property (nonatomic,strong) UIScrollView *scrollView;
@end

@implementation LXContenGetMoneyRecodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.controlView];
    [self.view addSubview:self.scrollView];
    self.title = @"提现记录";
}
-(NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray= [NSMutableArray array];
        
    };
    return _titleArray;
}
-(LXGetMoneyControl *)controlView{
    if (!_controlView) {
        NSArray *titleArray = @[@"全部",@"待审核",@"成功",@"失败"];
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
        for (int i = 0; i < self.titleArray.count; i ++) {
            LXGetMoneyRecodeViewController *vc = [[LXGetMoneyRecodeViewController alloc]init];
            if (i >=1) {
                vc.statusString = [NSString stringWithFormat:@"%d",i - 1];
            }
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

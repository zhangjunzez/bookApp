//
//  LXTuijianContentViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/4.
//  Copyright © 2020 zhangbenchao. All rights reserved.

#import "LXTuijianContentViewController.h"
#import "LXTuijianViewController.h"
#import "SSKJ_H5Web_ViewController.h"
#import "LXGetMoneyControl.h"


@interface LXTuijianContentViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) NSMutableArray *titleArray;
@property (nonatomic,strong) LXGetMoneyControl *controlView;
@property (nonatomic,strong) UIScrollView *scrollView;
@end

@implementation LXTuijianContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.controlView];
    [self.view addSubview:self.scrollView];
    self.title = @"我的推荐";
    [self addRightNavItemWithTitle:@"推荐规则" color:kSubTxtColor font: systemFont(ScaleW(15))];
    
}
-(void)rigthBtnAction:(id)sender
{
    NSString *url = [NSString stringWithFormat:@"%@%@",kBaseRequstUrl,@"/display/agreement?id=9"];
    [self gotoWebWithUrl:url title:@"推荐规则"];
}

-(NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray= [NSMutableArray array];
        
    };
    return _titleArray;
}
-(LXGetMoneyControl *)controlView{
    if (!_controlView) {
        NSArray *titleArray = @[@"用户列表",@"工程师列表"];
        [self.titleArray addObjectsFromArray:titleArray];
        _controlView = [[LXGetMoneyControl alloc]initWithTop:0 titleArray:self.titleArray width:ScreenWidth/2];
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
        NSArray *urls = @[kEngineermemberlist,kEngineerengineerlist];
        for (int i = 0; i < self.titleArray.count; i ++) {
            LXTuijianViewController *vc = [[LXTuijianViewController alloc]init];
            vc.requstUrl = urls[i];
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

-(void)gotoWebWithUrl:(NSString *)url title:(NSString *)title{
    SSKJ_H5Web_ViewController *vc = [[SSKJ_H5Web_ViewController alloc]init];
    vc.url = url;
    vc.title = title;
    [self.navigationController pushViewController:vc animated:YES];
}
@end

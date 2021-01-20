//
//  LXNewsViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/30.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXNewsViewController.h"
#import "LXNewsListViewController.h"

#import "LXNewsControlView.h"

#import "LXSaveUserInforTool.h"
#import "LXClassifyModel.h"

@interface LXNewsViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) NSMutableArray *titleArray;
@property (nonatomic,strong) LXNewsControlView *controlView;
@property (nonatomic,strong) UIScrollView *scrollView;
@end

@implementation LXNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"行业资讯";
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self requstClassifiyRequst];
}

-(NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray= [NSMutableArray array];
        
    };
    return _titleArray;
}
-(LXNewsControlView *)controlView{
    if (!_controlView) {
        NSArray *titleArray = @[@"推荐",@"热门",@"区块链",@"汽车",@"招租",@"汽车"];
        NSMutableArray *nameArray = [NSMutableArray array];
        if ([LXSaveUserInforTool sharedUserTool].newsTypeArray.count) {
            NSArray *savedArray = [LXSaveUserInforTool sharedUserTool].newsTypeArray;
            for (LXClassifyModel* model in savedArray) {
                [nameArray addObject: model.name];
            }
            titleArray = nameArray;
        }
        [self.titleArray addObjectsFromArray:titleArray];
        _controlView = [[LXNewsControlView alloc]initWithTop:0 titleArray:self.titleArray width:ScreenWidth/5.5];
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
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _controlView.height, ScreenWidth, ScreenHeight - Height_NavBar - Height_TabBar - _controlView.height)];
        _scrollView.contentSize = CGSizeMake(ScreenWidth *self.titleArray.count, 0);
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        for (int i = 0; i < self.titleArray.count; i ++) {
             NSArray *savedArray = [LXSaveUserInforTool sharedUserTool].newsTypeArray;
            LXClassifyModel *model =  savedArray[i];
            LXNewsListViewController *vc = [[LXNewsListViewController alloc]init];
            vc.typId = model.typeId;
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
#pragma mark -parapearData

-(void)requstClassifiyRequst{
        [NetWorkTools postConJSONWithUrl:kInformationsTypeListUrl parameters:@{} success:^(id responseObject) {
            NSString *result = responseObject[@"result"];
            NSString *resultNote = responseObject[@"resultNote"];
            NSArray *array = responseObject[@"dataList"];
            NSMutableArray *muArray = [NSMutableArray array];
            if ([result integerValue] == 0) {
                for (NSDictionary *dic  in array) {
                    LXClassifyModel *model = [[LXClassifyModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    [muArray addObject:model];
                }
                LXClassifyModel *model = [[LXClassifyModel alloc]init];
                model.name = @"推荐";
                [muArray insertObject:model atIndex:0];
                [LXSaveUserInforTool sharedUserTool].newsTypeArray = muArray;
                [self.view addSubview:self.controlView];
                [self.view addSubview:self.scrollView];
            }else{
                 [MBProgressHUD showError:resultNote];
            }
                         
        } fail:^(NSError *error) {
            
        }];
}

@end
